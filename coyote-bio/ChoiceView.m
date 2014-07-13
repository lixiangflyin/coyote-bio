//
//  ChoiceView.m
//  coyote-bio
//
//  Created by apple on 14-3-16.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ChoiceView.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation ChoiceView

- (void)dealloc
{
    [_btnPictureArray release];
    [_backgroundView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
    
        self.backgroundColor = [UIColor clearColor];
        CGRect viewFrame = CGRectZero;
        viewFrame.size = CGSizeMake(HEIGHT, WIDTH);
        self.frame = viewFrame;
    
        NSLog(@"height:%f width:%f",HEIGHT, WIDTH);
    
        UIButton *backgroundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backgroundBtn.frame = CGRectMake(0, 0, HEIGHT, WIDTH);
        backgroundBtn.backgroundColor = [UIColor blackColor];
        backgroundBtn.alpha = 0.7;
        [backgroundBtn setTag:300];
        [backgroundBtn addTarget:self action:@selector(touchToBack) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backgroundBtn];
        
        _backgroundView = [[UIImageView alloc] init];
        [_backgroundView setImage:[UIImage imageNamed:@"05PopView_Background.jpg"]];
        [_backgroundView setFrame:CGRectMake(0, 0, 181, 118)];
        [self addSubview:_backgroundView];
    
        _btnPictureArray = [[NSArray alloc]initWithObjects:@"05Btn1_1.jpg", @"05Btn1_2.jpg", @"05Btn2_1.jpg", @"05Btn2_2.jpg", @"05Btn3_1.jpg", @"05Btn3_2.jpg", @"05Btn4_1.jpg", @"05Btn4_2.jpg", nil];
    
        for (int i = 0; i < 2; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake(35, 20+40*i, 132, 38);
            //[btn setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex:i*2]]forState:UIControlStateNormal];
            //[btn setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex:i*2+1]]forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(chooseAnswer:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:200+i];
            [self addSubview:btn];
            [btn release];
        }
    }
    
    return self;
}

//单选情况
- (void)chooseAnswer:(id)sender
{
    UIButton *but =(UIButton *)sender;
    
    //按钮控件全变灰色
    for(id tmpView in self.subviews){
        if([tmpView isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton *)tmpView;
            for(int i = 200; i < 200+2;i++){
                if (button.tag == i)
                    [(UIButton *)button setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex: (i-200)*2]] forState:UIControlStateNormal];
            }
        }
    }
    //找到刚按下的那个空间
    for(int i = 200; i < 200+2;i++){
        if(but.tag == i && _picValue == 1)
            [(UIButton *)but setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex: (i-200)*2+1]] forState:UIControlStateNormal];
        else
            [(UIButton *)but setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex: (i-198)*2+1]] forState:UIControlStateNormal];
    }
    
    //顺便去除视图
    [_delegate clickChoiceValue:(int)but.tag-200];
}

-(void)resetViewLocation:(int)buttonValue
{
    
    switch (buttonValue) {
        case 200:
        {
            _picValue = 1;
            
            _backgroundView.frame = CGRectMake(578, 227, 181, 118);
            //按钮控件全变灰色
            for(id tmpView in self.subviews){
                if([tmpView isKindOfClass:[UIButton class]]){
                    UIButton *button = (UIButton *)tmpView;
                    for(int i = 200; i < 200+2;i++){
                        if (button.tag == i){
                            [(UIButton *)button setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex: (i-200)*2]] forState:UIControlStateNormal];
                            [(UIButton *)button setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex:(i-200)*2+1]]forState:UIControlStateHighlighted];
                            [(UIButton *)button setFrame:CGRectMake(578+34, 227+18+40*(i-200), 132, 38)];
                        }
                    }
                }
            }
            break;
        }
        case 201:
            _picValue = 2;
            
            _backgroundView.frame = CGRectMake(394, 345, 181, 118);
            //按钮控件全变灰色
            for(id tmpView in self.subviews){
                if([tmpView isKindOfClass:[UIButton class]]){
                    UIButton *button = (UIButton *)tmpView;
                    for(int i = 200; i < 200+2;i++){
                        if (button.tag == i){
                            [(UIButton *)button setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex: (i-198)*2]] forState:UIControlStateNormal];
                            [(UIButton *)button setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex:(i-198)*2+1]]forState:UIControlStateHighlighted];
                            [(UIButton *)button setFrame:CGRectMake(394+34, 345+18+40*(i-200), 132, 38)];
                        }
                    }
                }
            }
            break;
        case 202:
            _picValue = 2;
            
            _backgroundView.frame = CGRectMake(298, 470, 181, 118);
            //按钮控件全变灰色
            for(id tmpView in self.subviews){
                if([tmpView isKindOfClass:[UIButton class]]){
                    UIButton *button = (UIButton *)tmpView;
                    for(int i = 200; i < 200+2;i++){
                        if (button.tag == i){
                            [(UIButton *)button setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex: (i-198)*2]] forState:UIControlStateNormal];
                            [(UIButton *)button setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex:(i-198)*2+1]]forState:UIControlStateHighlighted];
                            [(UIButton *)button setFrame:CGRectMake(298+34, 470+18+40*(i-200), 132, 38)];
                        }
                    }
                }
            }
            break;
        default:
            break;
    }
}

-(void)touchToBack
{
    [_delegate removeChoiceView];
    
}

@end
