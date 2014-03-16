//
//  QuestionViewController.h
//  coyote-bio
//
//  Created by apple on 14-3-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegueStatusListener.h"
#import "MulButtonView.h"
#import "ChoiceView.h"

@interface QuestionViewController : UIViewController<UIActionSheetDelegate,MulButtonDelegate,ChoiceViewDelegate,SegueStatusListener>

@property (nonatomic) int count;
@property (nonatomic, retain) NSMutableArray *questionList;
@property (nonatomic, retain) NSMutableDictionary *item;
@property (nonatomic, retain) NSMutableArray *replies;
@property (nonatomic, retain) NSMutableDictionary *uploadParma;

@property (nonatomic, assign) int buttonNum;
@property (nonatomic, strong) NSMutableString *question5Answer;

@property (nonatomic) BOOL endTestSign;  //判断是否答题完毕

@property (nonatomic, retain) UILabel *numberLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UIImageView *questionImageView;
@property (nonatomic, retain) UIButton *nextStep;
@property (nonatomic, retain) UIButton *specialButton1;
@property (nonatomic, retain) UIButton *specialButton2;
@property (nonatomic, retain) UIButton *specialButton3;
@property (nonatomic, retain) MulButtonView *mulButtonView;
@property (nonatomic, retain) ChoiceView *choiceView;

@end
