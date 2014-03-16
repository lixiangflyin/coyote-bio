//
//  MulButtonView.m
//  StuentEvaluation
//
//  Created by admin  on 13-12-24.
//  Copyright (c) 2013年 com.seuli. All rights reserved.
//

#import "MulButtonView.h"


@implementation MulButtonView

- (void)dealloc
{
    [_clickSign release];
    [_btnPictureArray release];
    [super dealloc];
}

- (id)initWithDelegate:(id)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        //self.backgroundColor = [UIColor blackColor];
        self.frame = CGRectMake(0, 0, 568, 1024);
        self.backgroundColor = [UIColor clearColor];
        NSLog(@"frame: %f",self.frame.size.width);
        
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        _btnPictureArray = [[NSArray alloc]initWithObjects:@"BtnA_1.jpg", @"BtnA_2.jpg", @"BtnB_1.jpg", @"BtnB_2.jpg", @"BtnC_1.jpg", @"BtnC_2.jpg", @"BtnD_1.jpg", @"BtnD_2.jpg", nil];
        
        for (int i = 0; i < 4; i++) {
            UIButton *btn = [[UIButton alloc]init];
            btn.frame = CGRectMake(90, 276+76*i, 65, 65);
            //[btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex:i*2]]forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex:i*2+1]]forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(chooseAnswer:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:200+i];
            [self addSubview:btn];
            [btn release];
        }
        
    }
    return self;
}

- (void)refreshButtonLocation:(NSArray *)locationArray
{
    //初始化颜色
    for(id tmpView in self.subviews){
        if([tmpView isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton *)tmpView;
            for(int i = 200; i < 200+4; i++){
                if (button.tag == i){
                    int index = i - 200;
                    float chang = [[locationArray objectAtIndex:2*index]floatValue];
                    float kuang = [[locationArray objectAtIndex:2*index+1]floatValue];
                    [(UIButton *)button setFrame:CGRectMake(chang, kuang, 65, 65)];
                    [(UIButton *)button setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex: (i-200)*2]]forState:UIControlStateNormal];
                }
            }
        }
    }
}

//单选情况
- (void)chooseAnswer:(id)sender
{
    UIButton *but =(UIButton *)sender;
    
    //按钮控件全变灰色
    for(id tmpView in self.subviews){
        if([tmpView isKindOfClass:[UIButton class]]){
            UIButton *button = (UIButton *)tmpView;
            for(int i = 200; i < 200+6;i++){
                if (button.tag == i)
                    [(UIButton *)button setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex: (i-200)*2]] forState:UIControlStateNormal];
            }
        }
    }
    //找到刚按下的那个空间
    for(int i = 200; i < 200+6;i++){
        if(but.tag == i)
            [(UIButton *)but setBackgroundImage:[UIImage imageNamed:[_btnPictureArray objectAtIndex: (i-200)*2+1]] forState:UIControlStateNormal];
    }
    
    [_delegate clickSingleButtonValue:(int)but.tag-200];
}








//以下情况该APP无用

//重新对按钮显示作更新
//- (void)refreshButtonTitle:(NSArray *)titleArray isRadio:(BOOL)isRadio
//{
//    _isRadio = isRadio;
//    _buttonNumber = (int)[titleArray count];
//    //设置标识
//    _clickSign = [[NSMutableArray alloc] initWithCapacity:6];
//    for(int i=0; i<6; i++)
//        [_clickSign addObject:@"0"];
//    
//    //初始化颜色
//    for(id tmpView in self.subviews){
//        if([tmpView isKindOfClass:[UIButton class]]){
//            UIButton *button = (UIButton *)tmpView;
//            for(int i=200; i<200+_buttonNumber;i++){
//                if (button.tag == i)
//                    [(UIButton *)button setBackgroundImage:[UIImage imageNamed:@"UI-Button-Question-NoCheck-Up.png"]forState:UIControlStateNormal];
//            }
//        }
//    }
//    //答题按钮
//    //NSArray *ansABC = [NSArray arrayWithObjects:@"A、",@"B、",@"C、",@"D、",@"E、",@"F、", nil];
//    //获取每题答案
//    for(id tmpView in self.subviews){
//        if([tmpView isKindOfClass:[UIButton class]]){
//            UIButton *button = (UIButton *)tmpView;
//            for(int i=200; i<200+6;i++)
//                if (button.tag == i) {
//                    [(UIButton *)button setHidden:YES];
//                }
//            for(int i=200; i<200+[titleArray count];i++)
//                if (button.tag == i) {
//                    [(UIButton *)button setHidden:NO];
//                }
//        }
//        
//        if([tmpView isKindOfClass:[UILabel class]]){
//            UILabel *label = (UILabel *)tmpView;
//            for(int i=300; i<300+6;i++)
//                if (label.tag == i) {
//                    [(UILabel *)label setHidden:YES];
//                }
//            for(int i=300; i<300+[titleArray count];i++)
//                if (label.tag == i) {
//                    [(UILabel *)label setHidden:NO];
//                    NSString *str = [NSString stringWithFormat:@"%@",[titleArray objectAtIndex:i-300]];
//                    [(UILabel *)label setText:str];
//                    
//                }
//        }
//    }
//}
//
//
////单双选
//- (void)chooseAnswer:(id)sender
//{
//    UIButton *but =(UIButton *)sender;
//
//    if (_isRadio) {       //是单选
//        //按钮控件全变灰色
//        for(id tmpView in self.subviews){
//            if([tmpView isKindOfClass:[UIButton class]]){
//                UIButton *button = (UIButton *)tmpView;
//                for(int i=200; i<200+_buttonNumber;i++){
//                    if (button.tag == i)
//                        [(UIButton *)button setBackgroundImage:[UIImage imageNamed:@"UI-Button-Question-NoCheck-Up.png"]forState:UIControlStateNormal];
//                }
//            }
//        }
//        //找到刚按下的那个空间
//        for(int i=200; i<200+_buttonNumber;i++){
//            if(but.tag == i)
//            [(UIButton *)but setBackgroundImage:[UIImage imageNamed:@"UI-Button-Question-WithCheck-Up.png"] forState:UIControlStateNormal];
//        }
//    }
//    
//    else{
//        int a = (int)but.tag - 200;
//        if ([[_clickSign objectAtIndex:a] integerValue] == 0) {
//            [(UIButton *)but setBackgroundImage:[UIImage imageNamed:@"UI-Button-Question-WithCheck-Up.png"]forState:UIControlStateNormal];
//            [_clickSign replaceObjectAtIndex:a withObject:@"1"];
//        }
//        else{
//            [(UIButton *)but setBackgroundImage:[UIImage imageNamed:@"UI-Button-Question-NoCheck-Up.png"]forState:UIControlStateNormal];
//            [_clickSign replaceObjectAtIndex:a withObject:@"0"];
//        }
//    }
//    
//    [_delegate clickButtonValue:(int)but.tag-200];
//}

    
    
@end
