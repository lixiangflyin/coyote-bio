//
//  UploadViewController.h
//  coyote-bio
//
//  Created by apple on 14-3-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegueStatusListener.h"
#import "ASIFormDataRequest.h"


@interface UploadViewController : UIViewController<UITextViewDelegate,SegueStatusListener>

@property (nonatomic, retain) NSMutableDictionary *uploadParma;

@property (nonatomic, retain) NSMutableArray *replies;

@property (nonatomic, retain) NSMutableArray *rightAnswers;

@property (nonatomic, retain) ASIFormDataRequest *request;

@end
