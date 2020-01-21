---
layout: default
title: フラッシュメモリマップ
parent: 技術情報
nav_order: 1
---
## フラッシュメモリマップ

Deguに内蔵されているFlashメモリマップは、以下のように構成されています。

| Address             | Size  | Region                                         |
|:-------------------:|------:|:----------------------------------------------:|
| 0x000000 - 0x013FFF |  80KB | [MCUboot](#region_mcuboot)                     | 
| 0x014000 - 0x081FFF | 440KB | [Degu Firmware Slot-0](#region_degu_firmware)  |
| 0x082000 - 0x0EFFFF | 440KB | [Degu Firmware Slot-1](#region_degu_firmware)  |
| 0x0F0000 - 0x0F7FFF |  32KB | [Scratch Partition](#region_scratch_partition) |
| 0x0F8000 - 0x0FFFFF |  32KB | [USB Mass Storage](#region_usb_mass_storage)   |

### <a name="region_mcuboot">MCUboot領域</a>

MCUboot領域には、MCUbootバイナリが書き込まれています。Deguに電源を投入するとMCUbootが起動し、MCUbootはDeguファームウェア領域のSlot-0に書き込まれたファームウェアを起動します。

### <a name="region_degu_firmware">Deguファームウェア領域</a>

Deguファームウェア領域は、Slot-0とSlot-1との2つに分けられています。

Slot-0は、通常起動するDeguファームウェアが書き込まれています。

Slot-1は、ファームウェアアップデート時に新しいファームウェアが書き込まれます。その後、再度電源投入(又はリセット)すると、MCUbootがSlot-1の内容をSlot-0に上書きします。

### <a name="region_scratch_partition">Scratch Partition</a>

Scratch Partitionは、MCUbootがファームウェアアップデートを実行するために使用する作業領域です。

### <a name="region_usb_mass_storage">USB Mass Storage領域</a>

USB Mass Storage領域は、DeguをPCに接続したとき、USBマスストレージとして認識します。

さらに、この領域は以下のように用途を分けています。

| Address         | Size | Use                                                                     |
|:---------------:|-----:|:-----------------------------------------------------------------------:|
| 0x0000 - 0x3FFF | 16KB |               [FAT12 Partition](#region_fat12_partition)                |
| 0x4000 - 0x7FFF | 16KB | [OpenThread Network Information](#region_openthread_network_infomation) |

### <a name="region_fat12_partition">FAT12 Partition領域</a>

FAT12 PartitionはFAT12形式でフォーマットされており、MicroPythonコードとCONFIGファイルを格納しています。

### <a name="region_openthread_network_infomation">OpenThread Network Information領域</a>

OpenThread Network Information領域には、DeguがOpenThreadネットワークに接続するための情報が書き込まれています。
Deguはこれを使って、一度JoinしたOpenThreadネットワークに接続します。

OpenThread Network Information領域を消去すると、Deguを別のOpenThreadネットワークにJoinさせることができます。例えば、DeguをLinux PCに接続したとき、/dev/sdxとしてUSB Mass Storage領域にアクセスできる場合、次のコマンドでこの領域を消去することができます。

```
$ sudo dd if=/dev/zero of=/dev/sdx bs=1k count=16 seek=16 conv=fsync,nocreat
```

/dev/sdx の x はPCに接続した Degu 以外のストレージデバイスによって変わります。多くの PC には最初から /dev/sda があるので、Degu には /dev/sdb 等が割り当てられます。必ず Degu を接続した時に作られるファイルを使ってください。
