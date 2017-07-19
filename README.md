
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
2.	Add the framework to the project structure by clicking adding framework file from the project directory.
3.	Open the application target and select the 'General' tab.
4.	Drag and drop ScribbleKit.framework to the ‘Embedded Binaries’ section.
5.	Make sure that the ScribbleKit.framework file is copied to ‘Linked Frameworks and Libraries’ section too (As shown in the screenshot below).

![enter image description here](https://lh3.googleusercontent.com/-L_vP4VTD7iQ/WW01S1lsDhI/AAAAAAAAAc0/0dyWy9wnBcoFRnihMLeFxNqg0KAsSc9BgCLcBGAs/s0/ScribbleManualIntegration.png "ScribbleManualIntegration.png")

ScribbleKit is now ready to use!

### Scribble SDK

The Scribble SDK acts a middleman between the consumer app and the Scribble Pen / Stylus.

Scribble provides two classes to communicate with the Scribble SDK: ScribbleProtocol and ScribbleManager.
ScribbleProtocol is a protocol that receives event callbacks from the Scribble SDK. It has offers a list of optional stub methods that can be implemented to receive updates when things like registration, device pairing or color capturing occur. A full list of events can be found in the [iOS API](#iOS-API).

ScribbleManager is a class with static methods that can be called directly to interact with the Scribble SDK. ScribbleManager is used to verify your license key, initiate pairing with and request information from a Scribble Device. A full list of ScribbleManager functions can be found in the [iOS API](#iOS-API).

A sample application with this basic functionality can be found here: 
