//
//  EndView.m
//  StuentEvaluation
//
//  Created by admin  on 13-12-23.
//  Copyright (c) 2013年 com.seuli. All rights reserved.
//

#import "EndView.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation EndView

-(void)dealloc
{
    _delegate = nil;
    [super dealloc];
}

- (id)initWithDelegate:(id)delegate quesArray:(NSArray *)questionNumber
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        self.backgroundColor = [UIColor whiteColor];
        CGRect viewFrame = CGRectZero;
        viewFrame.size = CGSizeMake(HEIGHT, WIDTH);
        self.frame = viewFrame;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        for (int i=0; i<12; i++) {
            //for (int i=0; i<[questionNumber count]; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            if (i%2 == 0) {
                NSString *imagePath1 = [[NSBundle mainBundle]pathForResource:@"UI-Button-Result-True" ofType:@"png"];
                [imageView setImage:[UIImage imageWithContentsOfFile:imagePath1]];
            }
            else{
                NSString *imagePath2 = [[NSBundle mainBundle]pathForResource:@"UI-Button-Result-False" ofType:@"png"];
                [imageView setImage:[UIImage imageWithContentsOfFile:imagePath2]];
            }
            [imageView setFrame:CGRectMake(625, 180+35*i, 200, 30)];
            [self addSubview:imageView];
            [imageView release];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(655, 180+35*i, 150, 30)];
            [label setText:[NSString stringWithFormat:@"第%d题",i+1]];
            label.font = [UIFont systemFontOfSize:18];
            label.textAlignment = NSTextAlignmentCenter;
            [self addSubview:label];
            [label release];
        }
        
        UIButton *reagain = [[UIButton alloc]init];
        reagain.frame = CGRectMake(0, 280, 113, 226);
        [reagain setBackgroundImage:[UIImage imageNamed:@"BtnRestart_1.jpg"] forState:UIControlStateNormal];
        [reagain setBackgroundImage:[UIImage imageNamed:@"BtnRestart_2.jpg"] forState:UIControlStateHighlighted];
        [reagain addTarget:self action:@selector(reAgain) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:reagain];
        [reagain release];
    }
    return self;
}


-(void)reAgain
{
    [_delegate back];
}

@end
