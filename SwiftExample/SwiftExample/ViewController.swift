//
//  ViewController.swift
//  SwiftExample
//
//  Created by Architect on 10/07/17.
//  Copyright © 2017 Architect. All rights reserved.
//
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import UIKit
import ScribbleKit

class ViewController: UIViewController, ScribbleProtocols {

    // To Pair/UnPair ScribblePen
    @IBOutlet weak var btnPairDevice: UIButton!
    @IBOutlet weak var btnBatteryLife: UIButton!
    @IBOutlet weak var btnProximity: UIButton!
    @IBOutlet weak var btnDeviceInfo: UIButton!

    @IBOutlet weak var lblCurrentColorHeader: UILabel!

    // Color Pallete that reflects color captured once pen is connected
    @IBOutlet weak var viewColor: UIView!

    // Current Device State (Pair/UnPaired)
    var deviceState : DeviceState = .unPaired

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        self.resetInterface()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Register ScribbleKit to get notifications
        ScribbleManager.registerScribbleManager(with: self, registeredLicenseKey: Configuration.LicenseKey)
    }

    override func viewWillDisappear(_ animated: Bool) {

        // UnRegister ScribbleKit to remove subscription from notifications
        ScribbleManager.unRegisterScribbleManager()

        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startPairingClick(_ sender: Any) {
        // IF current state is unPaired then try start pairing process
        if self.deviceState == .unPaired
        {
            ScribbleManager.startDevicePairing()
        }
        else
        {
            ScribbleManager.stopPairingDevice()
        }
    }

    @IBAction func getDeviceGeneralInfoClick(_ sender : Any) {
       // To get Device general information like devicename, udid etc once pen is connected
       ScribbleManager.requestScribbleDeviceGeneralInfo()
    }

    @IBAction func getDeviceProximityInfoClick(_ sender : Any) {
      // To get Proximity information once pen is connected
       ScribbleManager.requestScribbleDeviceProximityInfo()
    }

    @IBAction func getDeviceBatteryInfoClick(_ sender : Any) {
      // To get BatteryLife information once pen is connected
      ScribbleManager.requestScribbleDeviceBatteryInfo()
    }

    // To Configure Interface based on current device pairing state
    func resetInterface()
    {
        self.btnPairDevice.setTitle(self.deviceState == .unPaired ? Configuration.PairDeviceText : Configuration.DevicePairedText, for: UIControlState.normal)

        // Device is not paired yet
        if self.deviceState == .unPaired
        {
           self.btnProximity.isHidden   = true
           self.btnDeviceInfo.isHidden  = true
           self.btnBatteryLife.isHidden = true
           self.viewColor.isHidden      = true
        }
        else
        {
            self.btnProximity.isHidden   = false
            self.btnDeviceInfo.isHidden  = false
            self.btnBatteryLife.isHidden = false
            self.viewColor.isHidden      = false
        }
    }

    // To show Banner Message
    func showBannerMessage(_ alertTitle:String, message:String)
    {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

    //MARK:- ScribbleProtocols Delegate stubs

    /**
     The callback function when the Server communication is failed while verifying LicenseKey.
     */

    func didServerCommunicationFailed(_ error:NSError)
    {
        print("didServerCommunicationFailed with error \(error)")
        self.showBannerMessage("Server communication failed", message: "code - \(error.code) \n detail - \(error.localizedDescription)")
    }

    /**
     The callback function when the LicenseKey is verified successfully.
     */

    func didLicenseVerificationSucceed()
    {
        print("didLicenseVerificationSucceed")
    }

    /**
     The callback function when there LicenseKey verification is failed.
     - parameter error: License key verification is failed with error returned.
     */

    func didLicenseVerificationFailed(_ error:NSError)
    {
      print("didLicenseVerificationFailed")

     /**
      CONTACT scribble support team to reIssue LicenseKey
     */
      self.showBannerMessage("LicenseKey verification failed", message: "code - \(error.code) \n detail - \(error.domain)")
    }

    /**
     The callback function when Bluetooth is found disabled.

     - parameter error: The failed to connect with bluetooth error message.
     */

    func didFailToConnectWithBlueTooth(_ error:NSError)
    {
        print("didFailToConnectWithBlueTooth")

        self.deviceState = .unPaired
        self.resetInterface()

        self.showBannerMessage(Configuration.Alert, message: error.domain)
    }

    /**
     The callback function when peripheral has been found.

     */

    func didDiscoverPeripheral()
    {
        print("didDiscoverPeripheral")
    }

    /**
     The callback function when the services has been discovered and device is connected.

     */

    func didConnectedToPeripheral()
    {
        print("didConnectedToPeripheral")
        self.deviceState = .Paired
        self.resetInterface()
    }

    /**
     The callback function when interrogate the peripheral is timeout

     - parameter error: The failed to interrogate peripheral error message.
     */

    func didFailedToInterrogate(_ error:NSError)
    {
        print("didFailedToInterrogate")
        self.deviceState = .unPaired
        self.resetInterface()
        self.showBannerMessage(Configuration.Alert, message: error.domain)
    }

    /**
     The callback function when the peripheral disconnected.
     */

    func didDisconnectPeripheral()
    {
        print("didDisconnectPeripheral")

        self.deviceState = .unPaired
        self.resetInterface()
    }

    /**
     The callback function when the peripheral captures new color.

     - parameter color: The new captured color value.
     */

    func didPeripheralCaptured(_ color:UIColor)
    {
        print("didPeripheralCaptured")

        // Set newly captured color as background
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseIn, animations: {
            self.viewColor.backgroundColor = color
        }, completion: nil)
    }

    /**
     The callback function when the peripheral returns current battery level.

     - parameter batteryLevel: The current battery level value.
     */

    func didPeripheralIndicated(_ batteryLevel:Int)
    {
        print("didPeripheralIndicated")
        self.showBannerMessage("Battery Level", message: "Value is \(batteryLevel)")
    }

    /**
     The callback function when the peripheral returns current proximity value.

     - parameter proximity: The current bluetooth proximity value.
     */

    func didPeripheralSensored(_ proximityValue:Int)
    {
        print("didPeripheralSensored")
        self.showBannerMessage("Proximity value", message: "Proximity is \(proximityValue)")
    }

    /**
     The callback function when the peripheral returns currently connected device's general info.

     - parameter deviceName: The currently connected device name.
     - parameter deviceUdid: The currently connected device udid.
     */

    func didPeripheralProvided(_ deviceName:String, deviceUdid:String)
    {
        self.showBannerMessage("Device General information", message: "DeviceName \(deviceName) \n Udid \(deviceUdid)")
    }
}

