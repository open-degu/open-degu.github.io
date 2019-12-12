---
layout: default
title: OTAリモートアップデート(ドラフト版)
parent: 技術情報
nav_order: 4
---
# OTAリモートアップデート(ドラフト版)

本機能は、ユーザースクリプト(`main.py`)、CONFIGファイル(`CONFIG`)、Deguファームウェアのリモートアップデートに対応しています。

## 対応するソフトウェア

現在、OTAリモートアップデートに対応しているDeguファームウェアは[v0.9.4-ota_draft](https://github.com/open-degu/degu/releases/tag/v0.9.4-ota_draft)です。

また、Deguゲートウェイのソフトウェアを最新のものにアップデートする必要があります。
Deguゲートウェイにシリアルコンソールで接続し、rootでログイン後に以下のコマンドを実行してください。

```
# apt-get update
# apt-get upgrade
```

## リモートアップデート方法

DeguのOTAリモートアップデートは、AWS IoT Core上のDevice Shadowの操作により実行することができます。

### 準備

アップデートしたいファイル(ユーザースクリプト、CONFIGファイル、Deguファームウェア)を任意のWebサーバー上にアップロードし、それぞれのMD5ハッシュ値を確認してください。

### Device Shadowからのアップデートの実行

リモートアップデートを実行するには、Device Shadowで次のJSONメンバーを使用します。

|キー|値(文字列)|
|-|-|
|script_user|ユーザースクリプトのダウンロードURL|
|script_user_ver|ユーザースクリプトのMD5ハッシュ値|
|config_user|CONFIGファイルのダウンロードURL|
|config_user_ver|CONFIGファイルのMD5ハッシュ値|
|firmware_system|DeguファームウェアのダウンロードURL|
|firmware_system_ver|DeguファームウェアのMD5ハッシュ値|

OTA対応版Deguファームウェアは、起動時に自身のユーザースクリプト(`main.py`)、CONFIGファイル(`CONFIG`)、DeguファームウェアのMD5ハッシュ値をAWS IoT Coreに`reported`として送信し、対応する`desired`の内容を確認します。

起動時、Thing Shadowは次のように更新されます。

```
{
  "reported": {
    "script_user_ver": "f2265f8db7da1cf7305da0cee9561928",
    "config_user_ver": "9f708b6598745146e5b61c6961449ad3",
    "firmware_system_ver": "c4ff012243272695c13fa5b2f9a62b1e"
  }
}
```

ユーザーは、アップデートしたいファイルのダウンロードURLとMD5ハッシュ値を`desired`に追加することで、アップデートを実行することができます。

例として、ユーザースクリプト、CONFIGファイル、Deguファームウェアをアップデートする場合の`desired`を示します。

```
{
  "desired": {
    "script_user": "https://example/path/to/main.py",
    "script_user_ver": "fffe02f1355f6fbb045d2ca8b26a04b5",
    "config_user": "https://example/path/to/config",
    "config_user_ver": "14585326db2071a0d746b8c4e2b1aeb9",
    "firmware_system": "https://example/path/to/degu.bin",
    "firmware_system_ver": "c4ff012243272695c13fa5b2f9a62b1e"
  }
}
```

アップデートしたいファイルのダウンロードURLとMD5ハッシュ値が`desired`に追加されている場合、DeguはこのMD5ハッシュ値と自身のMD5ハッシュ値とを比較します。
これらに差異があった場合、対応する要素のURLからファイルをダウンロードし、自身に書き込みます。

書き込み完了後、Deguは自動的に再起動し、新しいDeguファームウェアやユーザースクリプトで動作します。

## MicroPythonでのアップデートの確認

Deguファームウェアは、アップデートの確認と実施を起動時に一度だけしか実施しません。

これは、センサーデバイスという特性上、MicroPythonで指定した任意のタイミングで省電力モードに遷移したいため、自動的にアップデートの確認をすることができないためです。

したがって、MicroPython上でアップデートの確認を定期的に実施する必要があります。

### サンプルスクリプト

Githubの[open-degu/degu-micropython-samples](https://github.com/open-degu/degu-micropython-samples/tree/master/basic/remote_update)に、リモートアップデートのサンプルスクリプトがあります。

* `main_A.py`
  ```
  import machine
  import time
  import degu

  if __name__ == '__main__':
      while True:
          print("Hello! I'm Alice.")
          if (degu.check_update()):
              print("New script is comming! Restarting...")
              machine.reset()

          time.sleep(1)
  ```

* `main_B.py`
  ```
  import machine
  import time
  import degu

  if __name__ == '__main__':
      while True:
          print("Hello! I'm Bob.")
          if (degu.check_update()):
              print("New script is comming! Restarting...")
              machine.reset()

          time.sleep(1)
  ```

まず、DeguをPCにUSBケーブルで接続し、`main_A.py`を`main.py`としてDeguにコピーします。

Deguを再起動すると`main.py`が実行され、1秒間隔で`Hello! I'm Alice.`と表示しながらアップデートを確認します。

```
Hello! I'm Alice.
Hello! I'm Alice.
Hello! I'm Alice.
...
```

この状態で、AWS IoT Core上の対応するDevice Shadowを編集し、`main_B.py`のURLとMD5ハッシュ値を以下のように追加します。

```
{
  "reported": {
    (省略)
  },
  "desired": {
    "script_user": "https://raw.githubusercontent.com/open-degu/degu-micropython-samples/master/basic/remote_update/main_B.py",
    "script_user_ver": "4f3e01b7dc12348ebbd1acfe11ef6328"
  }
}
```

すると、`degu.check_update()`が1を返し、`machine.reset()`で再起動します。

```
New script is comming! Restarting...
```

再起動後、Deguは`main_B.py`を新たな`main.py`としてダウンロードします。ダウンロードが完了したら、再度再起動し、アップデートされた`main.py`を実行します。

```
Hello! I'm Bob.
Hello! I'm Bob.
Hello! I'm Bob.
...
```
