//
//  ChoiceView.h
//  coyote-bio
//
//  Created by apple on 14-3-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChoiceViewDelegate <NSObject>

-(void)clickChoiceValue:(int)btnNumber;

-(void)removeChoiceView;

@end

@interface ChoiceView : UIView

@property (nonatomic, assign) id delegate;

@property (nonatomic, retain) UIImageView *backgroundView;

@property (nonatomic, retain) NSArray *btnPictureArray;

-(void)resetViewLocation:(int)buttonValue;

- (id)initWithDelegate:(id)delegate;

@end
