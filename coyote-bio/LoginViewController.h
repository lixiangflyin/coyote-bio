//
//  LoginViewController.h
//  coyote-bio
//
//  Created by apple on 14-3-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegueStatusListener.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate,SegueStatusListener>

@property (nonatomic, retain) UITextField *nameTextField;
@property (nonatomic, retain) UITextField *passwordTextField;

@end
