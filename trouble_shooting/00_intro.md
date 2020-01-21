---
layout: default
title: トラブルシューティング
nav_order: 4
has_children: false
permalink: trouble_shooting

---

# トラブルシューティング

本ドキュメントでは、Deguを使用する上で陥る可能性のあるトラブルとその対処法について紹介します。

* [main.pyが保存できない](#mainpy_not_save)
* [AWS IoT Coreのシャドウが更新されない](#not_update_shadow)
* [Deguを別のDeguゲートウェイに接続したい](#join_another_gateway)

### <a name="mainpy_not_save">main.pyが保存できない</a>

maiy.pyが保存できない場合、以下の理由が考えられます

* 保存可能な容量を超えている

    main.pyが保存される[FAT12 Partition領域](../../technical_specifications/flash_memory_map/#region_fat12_partition)の容量は16KBですが、この中にはFAT12メタデータも含まれているため、16KB全てを利用することはできません。保存可能な容量を超えている場合は、コメント・改行を減らすなどして容量を削減してください。

* DeguのFlashメモリへmain.pyが書き込まれる前にUSBケーブルを切断している

    [MicroPythonコードの変更](../../user_manual/40_update_user_script)の手順を参考に、「デバイスの安全な取り外し」等の手順を行ってください。


### <a name="not_update_shadow">AWS IoT Coreのシャドウが更新されない</a>

DeguのMACアドレスがAWS IoT Coreの「モノ」として登録されている状態で、Deguの電源を投入してもAWS IoT Core上のシャドウが更新されない場合には、以下の手順をお試しください。

1. Deguの接続情報を初期化する

    [OpenThread Network Information領域](../../technical_specifications/flash_memory_map/#region_openthread_network_infomation)を消去することで、Deguの接続情報を初期化することができます。

    Linux PCにDeguを接続し以下のスクリプトを実行することで、Deguの接続情報を初期化できます。

    ```
    $ wget https://open-degu.github.io/script/degu_delete_con_info.sh
    $ sudo degu_delete_con_info.sh
    ```

1. AWS IoT Core上のデバイスを削除する

    デバイスを削除するには、登録されているモノのページで、`アクション`->`削除` をクリックしてください。
    ![](../../user_manual/images/delete_thing.png)

1. DeguのMACアドレスをAWS IoT Coreに登録する

    [Deguゲートウェイのセットアップ](../../user_manual/30_setup)の「DeguをAWS IoT Coreに登録する」に従い、再度DeguのMACアドレスを登録してください。

### <a name="join_another_gateway">Deguを別のDeguゲートウェイに接続したい</a>

[AWS IoT Coreのシャドウが更新されない](#not_update_shadow)と同様の手順で、接続情報を消去し、AWS IoT Core上にデバイスを削除・追加してください。
