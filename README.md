# SYPrintLog

[![CI Status](https://img.shields.io/travis/wanghao/SYPrintLog.svg?style=flat)](https://travis-ci.org/wanghao/SYPrintLog)
[![Version](https://img.shields.io/cocoapods/v/SYPrintLog.svg?style=flat)](https://cocoapods.org/pods/SYPrintLog)
[![License](https://img.shields.io/cocoapods/l/SYPrintLog.svg?style=flat)](https://cocoapods.org/pods/SYPrintLog)
[![Platform](https://img.shields.io/cocoapods/p/SYPrintLog.svg?style=flat)](https://cocoapods.org/pods/SYPrintLog)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SYPrintLog is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SYPrintLog'
```

```c++
//放在main函数中
[SYPrintAppLog start];
```

## Document

功能：    把Xcode控制台日志信息写进Log日志，保存本地
功能说明： 把NSLog写进日志文件，start只需在mian函数调用一次，之后App每次启动都会生成一个文件，最后一个数字是当天所生成文件的序号
文件名格式:YYYY-MM-DD_XX 如：(2016-09-22_1.log)(2016-09-22_2.log)...
自定义项目: 日志文件保存时间  单位:天
          日志文件储存文件夹名称
提示:     启用此功能会把日志保存在本地，若想看到日志文件请在Info.plist配置文件中加入 UIFileSharingEnabled  并且置为YES。
         然后连接iTunes在iTunes中点击你的应用图标右侧列表可看到日志文件。并且启用此功能后，所有NSLog将不会在控制台输出；
使用demo时，控制台会输出log保存路径，和log文件夹路径（Foler path）打开终端
```shell
cd Foler path
open .  # 可以看到所有log文件
```


## Author

wanghao, 512975801@qq.com

## License

SYPrintLog is available under the MIT license. See the LICENSE file for more info.
