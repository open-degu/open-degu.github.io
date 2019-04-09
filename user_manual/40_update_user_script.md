---
layout: default
title: MicroPythonコードの変更
parent: ユーザーマニュアル
nav_order: 40
---

## MicroPythonコードの変更

DeguをMicroUSBケーブルでPCに接続すると、PC上では32KBのUSBマスストレージとして認識されます。

このマスストレージの先頭から16KB分はFAT12形式でフォーマットされており、デフォルトでは以下のファイルが格納されています。

* main.py
  * Degu起動後、自動実行されるMicroPythonコード

* CONFIG
  * Deguが使用する設定ファイル(現在未定義)

Deguは起動後、自動的にmain.pyを実行します。main.pyが存在しない場合は、ZephyrのShellを起動し、USBシリアルコンソールに表示します。
main.pyの内容を任意のMicroPythonコードに書き換えると、電源再投入以降、Deguは変更されたmain.pyを実行します。

USBマスストレージ内のファイルを変更した後、Deguの電源を入れ直す際は、各OSの正しい手順でPCからDeguを切断してください。
