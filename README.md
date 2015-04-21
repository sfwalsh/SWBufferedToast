# SWBufferedToast

[![CI Status](http://img.shields.io/travis/Stephen Walsh/SWBufferedToast.svg?style=flat)](https://travis-ci.org/Stephen Walsh/SWBufferedToast)
[![Version](https://img.shields.io/cocoapods/v/SWBufferedToast.svg?style=flat)](http://cocoapods.org/pods/SWBufferedToast)
[![License](https://img.shields.io/cocoapods/l/SWBufferedToast.svg?style=flat)](http://cocoapods.org/pods/SWBufferedToast)
[![Platform](https://img.shields.io/cocoapods/p/SWBufferedToast.svg?style=flat)](http://cocoapods.org/pods/SWBufferedToast)

## About

SWBufferedToast is a simple alert-style class for presenting information to the user.
An SWBufferedToast can be instantiated with one of three types:


Plain Toast
A simple dismissable alert with a title, description and action button.

![Alt text](https://github.com/sfwalsh/SWBufferedToast/blob/master/Screenshots/plainToast.png "Plain Toast")

Notice Toast
A non-dismissable alert used to notify the user of an ongoing task. This alert cannot be dismissed by the user, but can be dismissed using a timer or by calling toast.dismiss.

![Alt text](https://github.com/sfwalsh/SWBufferedToast/blob/master/Screenshots/noticeToast.png "Notice Toast")

Login Toast
A modal login window in the style of a toast.

![Alt text](https://github.com/sfwalsh/SWBufferedToast/blob/master/Screenshots/loginToast.png "Login Toast")


All three alert types have a buffering animation that can be turned on and off as necessary. Additionally, you can supply your own images for this buffering animation.

If you wish to use your own animation images for the buffering state please be sure to add them to the "Pods-SWBufferedToast-SWBufferedToast-SWBufferedToast" target.

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

A project with a deployment target of iOS 7.0 or later

## Installation

SWBufferedToast is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SWBufferedToast"
```

## Author

Stephen Walsh, sw7891@hotmail.com

## License

SWBufferedToast is available under the MIT license. See the LICENSE file for more info.
