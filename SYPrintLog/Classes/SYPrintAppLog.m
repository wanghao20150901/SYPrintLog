//
//  SYPrintAppLog.m
//  IOSFramework
//
//  Created by 王浩 on 16/9/22.
//  Copyright © 2016年 wanghao. All rights reserved.
//

#import "SYPrintAppLog.h"

static NSString *SYLog_folderName = @"AppLogs";
static int SY_MAX_LOGFILESAVETIME = 4;//日志保留时间  单位:天

@implementation SYPrintAppLog

-(id)init{
    self = [super init];
    if (self) {
        return self;
    }
    
    return self;
}

-(void)redirectNSLogToDocumentFolder{

    NSString *folerPath = [self getLogFolderPath];                           //获取文件夹目录
    if (!folerPath) {
        NSLog(@"#Wrong:'SYPrintAppLog' failed to open, cause: create folder failed!");
        return;
    }
    NSString *filePath = [self getFilePathWithLogFolderPath:folerPath];      //根据文件夹目录获取文件全路径

    if (filePath) {
        NSLog(@"Log print to file initialization SUCCESS!");
        NSLog(@"Foler path :%@",folerPath);
        NSLog(@"Log path :%@",filePath);
        NSLog(@"Log 保存在log文件中，控制台不会再输出log");
        freopen([filePath cStringUsingEncoding:NSASCIIStringEncoding],"a+", stdout);
        freopen([filePath cStringUsingEncoding:NSASCIIStringEncoding],"a+", stderr);
    }else{
        NSLog(@"#Wrong:'SYPrintAppLog' failed to open, cause: failure to generate the file name! ");
    }
}

//获取文件夹目录
-(NSString *)getLogFolderPath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths firstObject];
    //组装文件夹目录
    NSString *rootStr = [documentDirectory stringByAppendingPathComponent:SYLog_folderName];
    
    //创建文件夹
    BOOL b = [self createFileDirectories:rootStr];
    if (!b) {
        return nil;
    }
    
    return rootStr;
}

//获取文件路径
-(NSString *)getFilePathWithLogFolderPath:(NSString *)sFolderPath{
    
    NSString *logFolderPath = [sFolderPath copy];
    
    //获得系统日期
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    NSString *currdentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    
    //枚举遍历日志文件
    NSFileManager *empFileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *empDirectory =[empFileManager enumeratorAtPath:logFolderPath];
    NSString *LocalFilePath;
    int maxV =0;
    while ((LocalFilePath = [empDirectory nextObject])) {
        if ([LocalFilePath.pathExtension isEqualToString:@"log"]) {
            
            NSArray *array = [NSArray arrayWithArray:[LocalFilePath componentsSeparatedByString:@"_"]];
            if (array.count<2) {
                return nil;
            }
            //判断当前日期内是否已经创建过日志文件，如果创建过则拿到最大序号；
            NSString *fileDateStr = array.firstObject;
            if ([fileDateStr isEqualToString:currdentDateStr]) {
                int empValue = [array.lastObject intValue];
                maxV = maxV>empValue?maxV:empValue;
            }
            //删除过期文件
            if ([self isExpireDateComparisonWithDateStr:fileDateStr]) {
                NSString *deletePath = [logFolderPath stringByAppendingPathComponent:LocalFilePath];
                [[NSFileManager defaultManager] removeItemAtPath:deletePath error:nil];
            }
        }
    }
    maxV = maxV == 0?1:maxV+1;//如果今天有过日志文件则序号加1，否则序号从1
    NSString *fileName =[NSString stringWithFormat:@"%@_%d.log",currdentDateStr,maxV];
    return [logFolderPath stringByAppendingPathComponent:fileName];

}

//判断文件是否过期
-(BOOL)isExpireDateComparisonWithDateStr:(NSString *)sDateStr{
    //获取日期临界值
    NSDate *criticalDate =[[NSDate date] dateByAddingTimeInterval:-SY_MAX_LOGFILESAVETIME*60*60*24];
    NSDateFormatter *dateFormatter =[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    NSString *criticalDateStr = [dateFormatter stringFromDate:criticalDate];
    criticalDateStr =[criticalDateStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    //临界值
    int criticalDateValue = [criticalDateStr intValue];
    //需要判断的值
    int agoDateValue = [[sDateStr stringByReplacingOccurrencesOfString:@"-" withString:@""] intValue];
    
    return (criticalDateValue-agoDateValue)>0?YES:NO;
}

/**
 *	@brief	创建文件夹
 *
 *	@param 	to 	所创建文件夹的路径
 */
- (BOOL)createFileDirectories:(NSString *)to
{
    BOOL isDir = NO;
    NSError *error = nil;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:to isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
       existed =[fileManager createDirectoryAtPath:to withIntermediateDirectories:YES attributes:nil error:&error];
        return existed;
    }
    return YES;
}

+ (void)start{
    static dispatch_once_t sy_PrintOnceToken;
    dispatch_once(&sy_PrintOnceToken,^{
        [[SYPrintAppLog new] redirectNSLogToDocumentFolder];
    });
}

@end
