//
//  UploadViewController.h
//  coyote-bio
//
//  Created by apple on 14-3-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegueStatusListener.h"


@interface UploadViewController : UIViewController<SegueStatusListener>

@property (nonatomic, retain) NSMutableDictionary *uploadParma;

@property (nonatomic, retain) NSString * sampleValue;

@end
