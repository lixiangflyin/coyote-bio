//
//  Toolkit.h
//  weitaozhi
//
//  Created by admin  on 13-8-3.
//  Copyright (c) 2013年 com.seuli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Toolkit : NSObject

+ (void)saveUserName:(NSString *)userName;
+ (void)saveTotalTime:(NSString *)totalTime;
+ (void)saveRecordTime:(NSString *)recordTime;
+ (void)saveNoticeTime:(NSString *)noticeTime;
+ (void)saveTestUrl:(NSString *)url;
+ (void)saveUploadFileName:(NSString *)fileName;
+ (void)saveLocalAccess:(BOOL)local_access;
+ (NSString *)getUserName;
+ (NSString *)getTotalTime;
+ (NSString *)getRecordTime;
+ (NSString *)getNoticeTime;
+ (NSString *)getTestUrl;
+ (NSString *)getUploadFileName;
+ (BOOL)getLocalAccess;
@end
