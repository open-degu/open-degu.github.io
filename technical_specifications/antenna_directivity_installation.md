---
layout: default
title: アンテナの指向性と設置方法
parent: 技術情報
nav_order: 3
---

# Antenna directivity and installation / アンテナの指向性と設置方法

## アンテナの指向性

Deguベースユニット、DeguゲートウェイG3に内蔵されているThread通信用のアンテナには指向性があります。
以下の図のように天面方向へ強く電波が飛びます。※製品面の定義については下記を参照してください。

#### Deguベースユニット　　　　　　　　　　　　　　DeguゲートウェイG3
![](images/degu_base_unit_ant_directivity.svg) ![](images/degu_gw_g3_ant_directivity.svg)

### Deguベースユニット製品面の定義

<img src="technical_specifications/images/degu_base_unit_surface.svg" width="600" />

### DegeゲートウェイG3製品面の定義

![](images/degu_gw_g3_surface.svg)

## 設置方法

Deguベースユニット、DeguゲートウェイG3を設置する際には、アンテナの指向性を考慮し
以下の図のように、それぞれの天面方向が向かいあわせになるように設置することを推奨します。
また、通信経路上の障害物ができるたけ少なくなるような高さに設置することも重要になります。

![](images/degu_installation.svg)

## フレネルゾーンの確保

安定した無線通信を行うためには、DeguベースユニットとDeguゲートウェイG3間、またはDeguベースユニットとDeguベースユニット間
の通信経路においてフレネルゾーンを確保する必要があります。
フレネルゾーンとは、アンテナ間を結ぶ直線を中心に広がる回転楕円体の空間で、この空間内に障害物があると無線通信に影響します。
フレネルゾーンの中で、中心部分の半径をフレネルゾーン半径と呼び、一般的にフレネルゾーン半径の60％以上を確保すれば自由空間と同じ特性を得られると言われています。
フレネルゾーン半径r[m]は、アンテナ間距離から以下のように算出することができます。

![](images/fresnel_zone.svg)

2.4GHzの波長 λ=0.125[m]、アンテナから中心部までの距離 d1[m],d2[m]

<img src="https://latex.codecogs.com/gif.latex?r=\sqrt{\frac{\lambda&space;\times&space;d1\times&space;d2}{d1&plus;d2}}" />

アンテナ間距離が100mの場合、フレネルゾーン半径r[m]は以下の計算式から約1.8mとなります。
したがって、安定した通信を行うためにはDeguベースユニットおよびDeguゲートウェイG3を約1.8m以上(60%だと1.08m以上)の高さに設置することが望ましいと言えます。

<img src="https://latex.codecogs.com/gif.latex?r=\sqrt{\frac{0.125\times&space;50\times&space;50}{50&plus;50}}\fallingdotseq&space;1.8" />
