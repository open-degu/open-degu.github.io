---
layout: default
title: パワーマネジメント
parent: 技術情報
nav_order: 5
---
# パワーマネジメント

パワーマネジメント機能を使用することで、消費電力を大幅に削減することができます。
Deguのパワーマネジメントでは、以下の2つの状態を設定することが可能です。

* suspend
* powerdown

## 比較

| 状態             | 消費電流(※1)  | 説明                                         |
|:-------------------:|:------:|:----------------------------------------------:|
| suspend | 5uA | 指定した時間、Deguの動作を停止します。RAMのデータは保持されます |
| powerdown | 1uA | 電源を切断した時と同様の状態になります。RAMのデータを保持しません |
  
※1: ボタン電池での3.0V供給時

## サンプルスクリプト

Githubの[open-degu/degu-micropython-samples](https://github.com/open-degu/degu-micropython-samples/tree/master/basic/power_management)に、パワーマネジメントのサンプルスクリプトがあります。

### suspend
* `main.py`
  ```
  from machine import ADC
  import ujson
  
  import degu
  
  def battery_voltage():
      R6 = 68
      R8 = 100
  
      ADC_REF = 0.6
      ADC_RESOLUTION=4096 #12bit
      ain = ADC(1)
      ain.gain(ain.GAIN_1_6) #gain set to 1/6
  
      raw = ain.read()
      vin = (raw / ADC_RESOLUTION) * ADC_REF * 6
  
      v = vin * ((R6 + R8) / R8)
      return v
  
  if __name__ == '__main__':
      reported = {'state':{'reported':{}}}
  
      while True:
          reported['state']['reported']['battery'] = battery_voltage()
  
          json = ujson.dumps(reported)
          degu.update_shadow(json)
          print(json)
  
          degu.suspend(30)
    ```

DeguをPCにUSBケーブルで接続し、`main.py`をDeguにコピーします。

Deguを再起動すると`main.py`が実行され、バッテリー電圧の送信と、30秒間のsuspendを繰り返します。

### powerdown
* `main.py`
  ```
  import time
  import ujson
  
  import degu
  
  def update_power_state(state):
      reported = {'state':{'reported':{}}}
      reported['state']['reported']['state'] = state
  
      json = ujson.dumps(reported)
      degu.update_shadow(json)
      print(json)
  
  if __name__ == '__main__':
      update_power_state('wakeup')
  
      print("power down after 15 seconds...")
      time.sleep(15)
  
      update_power_state('powerdown')
      degu.powerdown()
  ```

DeguをPCにUSBケーブルで接続し、`main.py`をDeguにコピーします。

Deguを再起動すると`main.py`が実行され、15秒経過した後にpowerdownとなります。
