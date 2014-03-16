//
//  LoginViewController.m
//  coyote-bio
//
//  Created by apple on 14-3-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "QuestionViewController.h"
#import "Toolkit.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface LoginViewController ()

@end

@implementation LoginViewController

-(void)dealloc
{
    [_nameTextField release];
    [_passwordTextField release];
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
	[self addLoginView];
    
}

-(void)addLoginView
{
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = self.view.bounds;
    
    NSString *path = [[NSBundle mainBundle] bundlePath];  //获取路径
    NSString *imagePath = [path stringByAppendingPathComponent:@"Start.png"];
    [imageView setImage:[UIImage imageWithContentsOfFile: imagePath]];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imageView];
    [imageView release];
    
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(499, 616, 150, 48)];
    _nameTextField.placeholder = @"10101010";
    _nameTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_nameTextField];
    
    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(700, 616, 150, 48)];
    _passwordTextField.placeholder = @"123456";
    _passwordTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_passwordTextField];
    
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(980, 606, 28, 57);
    [button setBackgroundImage:[UIImage imageNamed:@"BtnStart_1.jpg"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"BtnStart_2.jpg"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button release];
    
    //观察者模式实现委托的功能
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateView) name:@"updateView" object:nil];
}

//登录
-(void)login
{
    [Toolkit saveUserName:@"lixiang"];
    [self performSegueWithIdentifier:@"LoginToQuestion" sender:self];
    
    
    /*
     if ([_nameTextField.text isEqualToString:@""] || [_passwordTextField.text isEqualToString:@""]) {
     [ProgressHUD showError:@"用户名或密码为空"];
     return;
     }
     
     [ProgressHUD show:@"登录中..."];
     
     NSString *urlstr = @"http://bbs.seu.edu.cn/api/token.json";
     NSURL *myurl = [NSURL URLWithString:urlstr];
     ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:myurl];
     //设置表单提交项
     [request setPostValue:_nameTextField.text forKey:@"user"];
     [request setPostValue:_passwordTextField.text forKey:@"pass"];
     
     [request setCompletionBlock:^{
     NSLog(@"responseString = %@",request.responseString);
     
     NSDictionary *dic = [request.responseString objectFromJSONString];
     NSLog(@"dic %@",dic);
     if ([[dic objectForKey:@"success"] boolValue] == 1) {
     
     //[ProgressHUD dismiss];
     [Toolkit saveUserName:_nameTextField.text];
     [ProgressHUD showSuccess:@"登陆成功"];
     [self.view addSubview:_choiceView];
     }
     else{
     //[ProgressHUD dismiss];
     [ProgressHUD showError:@"输入的账户信息有误"];
     }
     
     }];
     [request setFailedBlock:^{
     
     NSLog(@"asi error: %@",request.error.debugDescription);
     
     }];
     
     [request startAsynchronous];
     
     */
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
