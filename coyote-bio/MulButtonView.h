//
//  MulButtonView.h
//  StuentEvaluation
//
//  Created by admin  on 13-12-24.
//  Copyright (c) 2013年 com.seuli. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MulButtonDelegate <NSObject>

-(void)clickSingleButtonValue:(int)btnNumber;
-(void)clickButtonValue:(int)btnNumber;

@end


@interface MulButtonView : UIView

@property (nonatomic, retain) NSMutableArray *clickSign;
@property (nonatomic, retain) NSArray *btnPictureArray;
//@property (nonatomic) BOOL isRadio;   //是否单选
//@property (nonatomic) int buttonNumber;
@property (nonatomic, assign) id delegate;

- (id)initWithDelegate:(id)delegate;
- (void)refreshButtonLocation:(NSArray *)locationArray;
//- (void)refreshButtonTitle:(NSArray *)titleArray isRadio:(BOOL)isRadio;

@end
