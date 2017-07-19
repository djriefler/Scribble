//
//  ScribbleKit.swift
//  ScribbleKit
//
//  Created by Architect on 06/07/17.
//  Copyright © 2017 Architect. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import UIKit


open class ScribbleManager: NSObject {

    /**
     Register Delegate for ScribbleManager

     - parameter ScribbleProtocols delegate listener
     - parameter Device Type Boolean - for Real Device - true, for Emulator - false
     */

    open static func registerScribbleManager(with object : ScribbleProtocols, registeredLicenseKey : String)
    {
        ScribbleHandler.getInstance().publishHandler(with: object, licenseKey: registeredLicenseKey)
    }

    /**
     UnRegister Delegate for ScribbleManager
     */

    open static func unRegisterScribbleManager()
    {
        ScribbleHandler.getInstance().unPublishHandler()
    }

    /**
     Start Device Pairing for ScribbleManager
     */

    open static func startDevicePairing()
    {
        ScribbleHandler.getInstance().startScribbleHandler()
    }

    /**
     Stop Device Pairing for ScribbleManager
     */

    open static func stopPairingDevice()
    {
        ScribbleHandler.getInstance().stopScribbleHandler()
    }

    /**
     Request Connected Device's Battery Value()
    */

    open static func requestScribbleDeviceBatteryInfo()
    {
        ScribbleHandler.getInstance().requestBatteryLifeValue()
    }

    /**
     Request Connected Device's Proximity Value()
     */

    open static func requestScribbleDeviceProximityInfo()
    {
        ScribbleHandler.getInstance().requestBluetoothSignalInfo()
    }

    /**
     Request Connected Device's Information like DeviceName, Udid etc()
     */
    open static func requestScribbleDeviceGeneralInfo()
    {
      ScribbleHandler.getInstance().requestDeviceGeneralInfo()
    }
}
