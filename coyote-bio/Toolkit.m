//
//  Toolkit.m
//  weitaozhi
//
//  Created by admin  on 13-8-3.
//  Copyright (c) 2013年 com.seuli. All rights reserved.
//

#import "Toolkit.h"
#import <Foundation/Foundation.h>

@implementation Toolkit

+ (void)saveUserName:(NSString *)userName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userName forKey:@"userName"];
}

+ (void)saveTotalTime:(NSString *)totalTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:totalTime forKey:@"totalTime"];
}

+ (void)saveRecordTime:(NSString *)recordTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:recordTime forKey:@"recordTime"];
}

+ (void)saveNoticeTime:(NSString *)noticeTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:noticeTime forKey:@"noticeTime"];
}

+ (void)saveTestUrl:(NSString *)url
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:url forKey:@"testUrl"];
}

+ (void)saveUploadFileName:(NSString *)fileName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:fileName forKey:@"uploadFileName"];
}

+ (NSString *)getUserName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (NSString *)[defaults objectForKey:@"userName"];
}

+ (NSString *)getTotalTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (NSString *)[defaults objectForKey:@"totalTime"];
}

+ (NSString *)getRecordTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (NSString *)[defaults objectForKey:@"recordTime"];
}

+ (NSString *)getNoticeTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (NSString *)[defaults objectForKey:@"noticeTime"];
}

+ (NSString *)getTestUrl
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (NSString *)[defaults objectForKey:@"testUrl"];
}

+ (NSString *)getUploadFileName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return (NSString *)[defaults objectForKey:@"uploadFileName"];
}



@end
