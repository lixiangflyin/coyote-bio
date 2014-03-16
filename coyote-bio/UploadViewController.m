//
//  UploadViewController.m
//  coyote-bio
//
//  Created by apple on 14-3-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "UploadViewController.h"
#import "ProgressHUD.h"
#import "JSONKit.h"
#import "ASIFormDataRequest.h"

#import "Toolkit.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface UploadViewController ()

@end

@implementation UploadViewController

- (void)dealloc
{
    [_uploadParma release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
    CGRect viewFrame = CGRectZero;
    viewFrame.size = CGSizeMake(HEIGHT, WIDTH);
    self.view.frame = viewFrame;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:@"End" ofType:@"png"];
    [imageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imageView];
    [imageView release];
    
    //[self simpleToServer];
    
    [self addAnswersView];
    
    
}

-(void)addAnswersView
{
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
        [self.view addSubview:imageView];
        [imageView release];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(655, 180+35*i, 150, 30)];
        [label setText:[NSString stringWithFormat:@"第%d题",i+1]];
        label.font = [UIFont systemFontOfSize:18];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        [label release];
    }
    
    UIButton *reagain = [[UIButton alloc]init];
    reagain.frame = CGRectMake(0, 280, 113, 226);
    [reagain setBackgroundImage:[UIImage imageNamed:@"BtnRestart_1.jpg"] forState:UIControlStateNormal];
    [reagain setBackgroundImage:[UIImage imageNamed:@"BtnRestart_2.jpg"] forState:UIControlStateHighlighted];
    [reagain addTarget:self action:@selector(reAgain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reagain];
    [reagain release];
}

-(void)reAgain
{
    [self performSegueWithIdentifier:@"UploadToLogin" sender:self];
}


#pragma -mark 下面两个函数仅仅用来测试
//测试
-(NSString*) getValidURL
{
    if (false) {
        //TODO: 从系统的配置文件中读取，然后自动将可以用的url返回给所需函数
    }
    
    return [NSString stringWithFormat:@"http://%@/apps/coyotes/post_answer1.php?",[Toolkit getTestUrl]];
}

-(void) simpleToServer
{
    [ProgressHUD show:@"正在上传中..." Interacton:NO];
    
    NSString *urlstr = [self getValidURL];
    NSLog(@"url = %@",urlstr);
    
    
    NSURL *myurl = [NSURL URLWithString:urlstr];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
    //设置表单提交项
    [request setPostValue:@"1" forKey:@"uc"];
    [request setPostValue:@"20140201" forKey:@"qgc"];
    [request setPostValue:@"A_B_C" forKey:@"ans"];
    
    NSLog(@"request = %@",request);
    
    [request setCompletionBlock:^{
        
        NSLog(@"responseString = %@",request.responseString);
        
        NSDictionary *dic = [request.responseString objectFromJSONString];
        NSLog(@"dic %@",dic);
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            
            //[ProgressHUD dismiss];
            [ProgressHUD showSuccess:@"上传成功"];
            
        }
        else{
            //[ProgressHUD dismiss];
            [ProgressHUD showError:@"上传失败"];

        }
        
    }];
    [request setFailedBlock:^{
        
        [ProgressHUD showError:@"上传失败"];
        
        NSLog(@"asi error: %@",request.error.debugDescription);
        
    }];
    
    [request startAsynchronous];
}

#pragma -mark RemoveVideoViewDelegate 委托
-(void)back
{
    [_endView removeFromSuperview];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"updateView" object:nil];
    [self.navigationController popViewControllerAnimated:NO];
    //[self dealloc];
}

//该三个函数未实现
- (void)transitionAwayFrom {
}

- (void)beginTransition:(id)sender {
}

- (void)finishedTransition:(id)sender {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
