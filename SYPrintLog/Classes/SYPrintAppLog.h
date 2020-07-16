//
//  SYPrintAppLog.h
//  IOSFramework
//
//  Created by 王浩 on 16/9/22.
//  Copyright © 2016年 wanghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SYPrintAppLog : NSObject

/// 功能：    开启日志信息写进Log日志，保存本地
/// 功能说明： 把NSLog写进日志文件，start只需在mian函数调用一次，之后App每次启动都会生成一个文件，最后一个数字是当天所生成文件的序号
/// 文件名格式:YYYY-MM-DD_XX 如：(2016-09-22_1.log)(2016-09-22_2.log)...
/// 自定义项目: 日志文件保存时间  单位:天
///           日志文件储存文件夹名称
/// 提示:     启用此功能会把日志保存在本地，若想看到日志文件请在Info.plist配置文件中加入 UIFileSharingEnabled  并且置为YES。
///          然后连接iTunes在iTunes中点击你的应用图标右侧列表可看到日志文件。并且启用此功能后，所有NSLog将不会在控制台输出；
/// [SYPrintAppLog start];
+ (void)start;
@end
