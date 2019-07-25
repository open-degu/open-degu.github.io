---
layout: default
title: 最新の状態へのアップデート
parent: ユーザーマニュアル
nav_order: 20
---
#  最新の状態へのアップデート

DeguゲートウェイとDeguとをセットアップする前に、それぞれのソフトウェアを最新のものにアップデートしてください。

## Deguゲートウェイのソフトウェアアップデート

Deguゲートウェイのソフトウェアをアップデートする方法を次に示します。

1. Deguゲートウェイにシリアルコンソールで接続し、rootでログインしてください。

1. 以下のコマンドを実行してください。

    ```
    # apt-get update
    # apt-get upgrade
    ```

これで、Deguゲートウェイのソフトウェアのアップデートが完了しました。

## Deguファームウェアアップデート

Deguファームウェアをアップデートする方法を次に示します。最新のDeguファームウェアは、[リリースノート](https://github.com/open-degu/degu/releases)からダウンロードすることができます。

### USB接続でアップデートする

DeguファームウェアをUSB接続でアップデートするには、専用の[dfu-util](https://github.com/open-degu/dfu-util)を使用します。
`dfu-util`は、DeguゲートウェイまたはLinux PCで実行することができます。


#### Deguゲートウェイで行う場合
Deguゲートウェイで行う場合、次のコマンドで`dfu-util`をインストールすることができます。

```
$ sudo apt-get update
$ sudo apt-get install dfu-util
```

#### Linux PCで行う場合
Linux PCで行う場合、Debian GNU/LinuxまたはUbuntu向けのdebパッケージを利用することができます。

[dfu-utilのリリースノート](https://github.com/open-degu/dfu-util/releases)から、お使いのPCのアーキテクチャに合った、最新のdebパッケージをPCにダウンロードし、インストールしてください。

```
$ sudo dpkg -i dfu-util_[VERSION]_[ARCH].deb
```

#### アップデート手順

1. MicroUSBケーブル(TypeA側)をDeguゲートウェイまたはLinux PCに接続してください。

1. JST 2pin PHコネクタを外して、JP3をショートしてください。

1. DeguのSW4(ケース外側に出ているスイッチ)を押しながら、MicroUSBケーブル(micro Type-B側)を接続してください。

    ![JP-USB](images/JP-USB.svg)

1. DeguがUSB DFU(Device Firmware Update)モードで起動します。USB DFUモードで起動すると、LED1とLED2が500ms間隔で交互に点滅します。この状態で、`dfu-util`で任意のファームウェアを書き込んでください。

    ```
    $ sudo dfu-util --alt 1 -D degu.bin
    dfu-util 0.9  
    ...
    Opening DFU capable USB device...
    ID 2fe3:0100
    Run-time device DFU version 0110
    Claiming USB DFU Runtime Interface...
    Determining device status: state = appIDLE, status = 0
    Device really in Runtime Mode, send DFU detach request...
    Resetting USB...
    Opening DFU USB Device...
    Claiming USB DFU Interface...
    Setting Alternate Setting #1 ...
    Determining device status: state = dfuIDLE, status = 0
    dfuIDLE, continuing
    DFU mode device DFU version 0110
    Device returned transfer size 64
    Copying data from PC to DFU device
    Download        [=========================] 100%       433004 bytes
    Download done.
    state(2) = dfuIDLE, status(0) = No error condition is present
    Done!
    ```

1. "Done!" と表示されれば、書き込み完了です。書き込みが完了したら、MicroUSBケーブルを切断してください。
