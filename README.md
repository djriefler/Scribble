
# Scribble iOS SDK

This library allows you to integrate Scribble's color capture technology into your iOS app. 

## Requirements

 - XCode 8.3.3+
 - Swift 3+
 - iOS  9.0+

## Getting Started

To get started you must first obtain a license key from the Scribble team. 
Please also note that both a Scribble Pen / Stylus and an iOS device are required to use this SDK (it will not work on the simulator). 

### Manual Integration
1. Copy the ScribbleKit.framework file into the project directory of your application.
![screenshot 1](/Screenshots/add_to_directory.png?raw=true)
2.	In XCode, click File -> Add Files to "YourProjectName"...
![screenshot 2](/Screenshots/add_files.png?raw=true)
3. Select ScribbleKit.framework and click "Add"
![screenshot 3](/Screenshots/select_framework.png?raw=true)
4. Select the 'General' tab and verify the ScribbleKit.framework file is copied to the sidebar on the left and to the ‘Linked Frameworks and Libraries’ section
![screenshot 4](/Screenshots/added_to_project.png?raw=true)
5.	Click the '+' in the ‘Embedded Binaries’ section, select ScribbleKit.framework and click 'Add'
![screenshot 5](/Screenshots/add_to_embedded_binaries.png?raw=true)
6.	Make sure that the ScribbleKit.framework file is copied to both the 'Embedded Binaries' and ‘Linked Frameworks and Libraries’ sections.
![screenshot 6](/Screenshots/final_state.png?raw=true)

ScribbleKit is now ready to use!

### Using the SDK

The Scribble SDK acts a middleman between the consumer app and the Scribble Pen / Stylus.

Scribble provides two classes to communicate with the Scribble SDK:

**ScribbleProtocol** is a protocol that receives event callbacks from the Scribble SDK. It has offers a list of optional stub methods that can be implemented to receive updates when things like registration, device pairing or color capturing occur. A full list of events can be found in the [Documentation](Documentation.md).

**ScribbleManager** is a class with static methods that can be called directly to interact with the Scribble SDK. ScribbleManager is used to verify your license key, initiate pairing with and request information from a Scribble Device. A full list of ScribbleManager functions can be found in the [Documentation](Documentation.md).

## Example Usage

### Quick Integration

First, import ScribbleKit into your source code:

    import ScribbleKit

Next, have your delegate conform to the ScribbleProtocol and implement the ScribbleProtocol methods you would like to receive callbacks for. Here we implement didPeripheralCaptured so that we can receive color information and store it in a variable:

    class MyDelegateClass: NSObject, ScribbleProtocol {
       var myColor: UIColor?
       func didPeripheralCaptured(_ color: UIColor) {
          myColor = color
       }
    }

Next, ScribbleManager must register the delegate and pass a license key for verification:

    ScribbleManager.registerScribbleManager(with: myClassInstance, registeredLicenseKey: "abcdefg")
   
Next, implement didLicenseVerificationSucceed() in your delegate and call ScribbleManager.startDevicePairing() to begin pairing with the Scribble Pen / Stylus upon successful license verification.
      
    func didLicenseVerificationSucceed() {
       ScribbleManager.startDevicePairing()
    }

Once the Scribble Pen / Stylus has been paired with the iOS device, the class implementing the ScribbleProtocol will receive updates whenever the Scribble device captures a new color!

### Full Example
A sample application with this basic functionality and more can be found in SwiftExample.
