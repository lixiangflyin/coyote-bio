//
//  UploadViewController.h
//  coyote-bio
//
//  Created by apple on 14-3-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegueStatusListener.h"
#import "EndView.h"

@interface UploadViewController : UIViewController<EndViewDelegate,SegueStatusListener>

@property (nonatomic, retain) EndView *endView;
@property (nonatomic, retain) NSMutableDictionary *uploadParma;

@end
