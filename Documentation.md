


# Scribble Documentation

## Table Of Contents
<!-- TOC depth:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [ScribbleProtocol](#scribbleprotocol)
	- [didLicenseVerificationSucceed](#didlicenseverificationsucceed)
	- [didLicenseVerificationFailed](#didlicenseverificationfailed)
	- [didServerCommunicationFailed](#didservercommunicationfailed)
	- [didDiscoverPeripheral](#diddiscoverperipheral)
	- [didConnectToPeripheral](#didconnecttoperipheral)
	- [didDisconnectPeripheral](#diddisconnectperipheral)
	- [didFailToConnectWithBlueTooth](#didfailtoconnectwithbluetooth)
	- [didPeripheralCaptured](#didperipheralcaptured)
	- [didPeripheralIndicated](#didperipheralindicated)
	- [didPeripheralSensed](#didperipheralsensed)
	- [didPeripheralProvided](#didperipheralprovided)
- [ScribbleManager](#scribblemanager)
	- [registerScribbleManager](#registerscribblemanager)
	- [unRegisterScribbleManager](#unregisterscribblemanager)
	- [startPairingDevice](#startpairingdevice)
	- [stopPairingDevice](#stoppairingdevice)
	- [requestScribbleDeviceBatteryInfo](#requestscribbledevicebatteryInfo)
	- [requestScribbleDeviceProximityInfo](#requestscribbledeviceproximityinfo)
	- [requestScribbleDeviceGeneralInfo](#requestscribbledevicegeneralinfo)

<!-- /TOC -->

## ScribbleProtocol
Protocol that receives messages sent from the Scribble SDK. It offers the following optional stubs: 

Note: **peripheral** refers to the Scribble device that your app is interacting with.

### didLicenseVerificationSucceed

Event occurs when the license is verified successfully.

	func didLicenseVerificationSucceed()

### didLicenseVerificationFailed
Event occurs when the license key verification fails.

	func didLicenseVerificationFailed(_ error: NSError) 

**Parameters**:

| Attribute | Type | Description |
| ------- | ------------ | ------------ |
| *error* | **NSError**  | The reason for failure. |

### didServerCommunicationFailed
Event occurs when server communication fails while attempting to verify the license key.

	func didServerCommunicationFailed(_ error: NSError)

**Parameters**:

| Attribute | Type | Description |
| ------- | ------------ | ------------ |
| *error* | **NSError**  | The reason for failure. |

### didDiscoverPeripheral
Event occurs when the peripheral has been found.

	func didDiscoverPeripheral()

### didConnectToPeripheral
Event occurs when the iOS device is connected to the peripheral.

    func didConnectToPeripheral()

### didDisconnectPeripheral
Event occurs when the peripheral is disconnected.

    func didDisconnectPeripheral()

### didFailToConnectWithBlueTooth
Event occurs when Bluetooth is found disabled.

    func didFailToConnectWithBlueTooth(_ error: NSError)
    
**Parameters**:

| Attribute | Type | Description |
| ------- | ------------ | ------------ |
| *error* | **NSError**  | The reason for failure. |


### didPeripheralCaptured 
Event occurs when the peripheral captures a new color.

	func didPeripheralCaptured (_ color: UIColor)
	
**Parameters**:

| Attribute | Type | Description |
| ------- | ------------ | ------------ |
| *color* | **UIColor**  | The color that the peripheral captured. |

### didPeripheralIndicated
Event occurs when the peripheral returns its current battery level.
 
	func didPeripheralIndicated(_ batteryLevel: Int)

**Parameters**:

| Attribute | Type | Description |
| ------- | ------------ | ------------ |
| *batteryLevel* | **Int**  | The current battery level value. Value ranges from 0-100. |

### didPeripheralSensed
Event occurs when the peripheral returns the current proximity value.

	func didPeripheralSensed(_ proximityValue: Int)
**Parameters**:

| Attribute | Type | Description |
| ------- | ------------ | ------------ |
| *proximityValue* | **Int**  | The current bluetooth proximity value. Value ranges from around 30-97 where 30 is nearest proximity value. |

### didPeripheralProvided
Event occurs when the peripheral returns the currently connected device's general info.
	
	func didPeripheralProvided(_ deviceName: String, deviceUdid: String)

**Parameters**:

| Attribute | Type | Description |
| ------- | ------------ | ------------ |
| *deviceName* | **String**  | Name of the currently connected device. |
| *deviceUdid* | **String**  | UDID of the currently connected device. |
	


## ScribbleManager
Offers the following functional stubs:

### registerScribbleManager
Register delegate for the ScribbleManager.

	static func registerScribbleManager(with object: ScribbleProtocols, registeredLicenseKey: String)

**Parameters**:

| Attribute | Type | Required | Description |
| ------- | ------------ | ------------ | ------------ |
| *object* | **ScribbleProtocol**  | Yes | The delegate listener that will receive callbacks from the peripheral |
| *registeredLicenseKey* | **String**  | Yes | License key that will be used for verification. |
	
### unRegisterScribbleManager
Unregister delegate for ScribbleManager.
     
	static func unRegisterScribbleManager()

### startDevicePairing
Begin pairing with Scribble device.

	static func startDevicePairing()

### stopPairingDevice
Stop pairing device with Scribble device.

	static func stopPairingDevice()

### requestScribbleDeviceBatteryInfo

Request connected device's battery level. Will invoke [didPeripheralIndicated](#didperipheralindicated).
 
	static func requestScribbleDeviceBatteryInfo()

### requestScribbleDeviceProximityInfo

Request connected device's proximity value.  Will invoke [didPeripheralSensed](#didperipheralsensed).

	static func requestScribbleDeviceProximityInfo()

### requestScribbleDeviceGeneralInfo
Request connected device's information (currently device's name and UDID). Will invoke [didPeripheralProvided](#didperipheralprovided).
 
	static func requestScribbleDeviceGeneralInfo()
