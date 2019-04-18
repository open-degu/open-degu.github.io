---
layout: default
title: Armadillo-IoT ゲートウェイ G3 M1モデル
parent: Deguゲートウェイマニュアル
nav_order: 1
---

# Armadillo-IoT ゲートウェイ G3 M1モデル

[アットマークテクノ製 Armadillo-IoT ゲートウェイ G3 M1モデル](https://armadillo.atmark-techno.com/armadillo-iot-g3)は、Linux OSを搭載したIoT向けゲートウェイの開発プラットフォームです。

Armadillo-IoT ゲートウェイ G3 M1モデルに[TH00 Threadアドオンモジュール](https://armadillo.atmark-techno.com/option-products/OP-AGA-TH00-00)を接続し、専用のdebianパッケージをインストールすることで、[Deguゲートウェイ G3](https://armadillo.atmark-techno.com/armadillo-iot-g3/AGX3142-D10Z)と同等の構成にすることができます。ここでは、その手順を紹介します。

## Threadアドオンモジュールの接続

Armadillo-IoT ゲートウェイ G3 M1モデルの`CON1`、または`CON2`のアドオンインターフェースに、Threadアドオンモジュールを接続してください。

## Linuxカーネルの更新

LinuxカーネルとDTB(Device Tree Blob)を最新のものに書き換えてください。対応するLinuxカーネルのバージョンは[v4.9-x1-at6以降](https://armadillo.atmark-techno.com/news/20190327/software-update-aiotg3)です。

LinuxカーネルとDTBの書き換え方法は公式の[製品マニュアル](https://manual.atmark-techno.com/armadillo-iot-g3/armadillo-iotg-g3_product_manual_ja-2.1.0/ch11.html#sct.update_image_simply.linux)を参照してください。

## debianパッケージのインストール

シリアルコンソールからrootでログインし、次のコマンドで`degu-manager`をインストールしてください。

```
# apt-get update
# apt-get install degu-manager
```

インストールが完了したら、再起動してください。

```
# reboot
```

これで、お持ちのArmadillo-IoT ゲートウェイ G3 M1モデルは、Deguゲートウェイ G3と同等の構成となりました。
