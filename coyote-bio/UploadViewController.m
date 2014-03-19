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
    [_uploadParma release];  //其实不需要释放，因为未申请内存
    [_replies release];
    [_rightAnswers release];
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
    
    _rightAnswers = [[NSMutableArray alloc]init];
    
	//获取测试数据
    NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *plistPath = [path stringByAppendingPathComponent:@"answer.plist"];
    NSArray *list = [NSMutableArray arrayWithContentsOfFile:plistPath];
    //NSLog(@"%@",list);
    [_rightAnswers addObjectsFromArray:list];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGRect viewFrame = CGRectZero;
    viewFrame.size = CGSizeMake(HEIGHT, WIDTH);
    self.view.frame = viewFrame;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:@"End_Background" ofType:@"jpg"];
    [imageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imageView];
    [imageView release];
    
    NSLog(@"access: %d",[Toolkit getLocalAccess]);
    //是否本地访问
    if ([Toolkit getLocalAccess] == YES) {
        [self addAnswersView];
    }
    else{
        [self simpleToServer];
    }
    
    NSLog(@"reply: %@",_replies);

    
    
}

#pragma -mark 显示答案结果
-(void)addAnswersView
{
    //初始化
    UITextView *textView = [[[UITextView alloc] initWithFrame:CGRectMake(155, 170, 750, 430)] autorelease];
    //设置代理 需在interface中声明UITextViewDelegate
    textView.delegate = self;
    //字体大小
    textView.font = [UIFont systemFontOfSize:20];
    textView.editable = NO;
    textView.text = [self showTestExplaination];
    //添加滚动区域
    textView.contentInset = UIEdgeInsetsMake(-11, -6, 0, 0);
    //是否可以滚动
    textView.scrollEnabled = YES;
    //获得焦点
    [textView becomeFirstResponder];
    [self.view addSubview:textView];
    
    
    UIButton *reagainBtn = [[UIButton alloc]init];
    reagainBtn.frame = CGRectMake(0, 280, 113, 226);
    [reagainBtn setBackgroundImage:[UIImage imageNamed:@"BtnRestart_1.jpg"] forState:UIControlStateNormal];
    [reagainBtn setBackgroundImage:[UIImage imageNamed:@"BtnRestart_2.jpg"] forState:UIControlStateHighlighted];
    [reagainBtn addTarget:self action:@selector(reAgain) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reagainBtn];
    [reagainBtn release];
}

-(NSString *)showTestExplaination
{
    NSMutableString *str = [[[NSMutableString alloc]init]autorelease];
    for (int i=0; i<[_replies count]; i++) {
        NSDictionary *dic = [_rightAnswers objectAtIndex:i];
        NSArray *arr = [dic objectForKey:@"explaination"];
        if ([[_replies objectAtIndex:i] isEqualToString:[dic objectForKey:@"reply"]]) {
            if (i == 4) {
                str = [NSMutableString stringWithFormat:@"%@ 第%d题 %@ \n",str,i+1,@"正确"];
            }
            else{
                NSString *str1 = [arr objectAtIndex:[self getReplyNumber:[_replies objectAtIndex:i]]];
                str = [NSMutableString stringWithFormat:@"%@ 第%d题 %@ \n",str,i+1,str1];
            }
        }
        else
        {
            if (i == 4) {
                str = [NSMutableString stringWithFormat:@"%@ 第%d题 %@ \n",str,i+1,@"错误"];
            }
            else{
                NSString *str1 = [arr objectAtIndex:[self getReplyNumber:[_replies objectAtIndex:i]]];
                str = [NSMutableString stringWithFormat:@"%@ 第%d题 %@ \n",str,i+1,str1];
            }
        }
    }
    
    return str;
}

-(int)getReplyNumber:(NSString *)reply
{
    if ([reply isEqualToString:@"A"])
        return 0;
    else if ([reply isEqualToString:@"B"])
        return 1;
    else if ([reply isEqualToString:@"C"])
        return 2;
    else if ([reply isEqualToString:@"D"])
        return 3;
    else
        return 100;
}


//视图切换
-(void)reAgain
{
    [self performSegueWithIdentifier:@"UploadToLogin" sender:self];
}

#pragma -mark 显示重传视图
-(void)addReuploadView
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(924, 317, 80, 270)];
    NSString *imagePath = [[NSBundle mainBundle]pathForResource:@"UploadErrorView_Background" ofType:@"jpg"];
    [imageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:imageView];
    [imagePath release];
    
    UIButton *reuploadBtn = [[UIButton alloc]init];
    reuploadBtn.frame = CGRectMake(939, 602, 50, 50);
    [reuploadBtn setBackgroundImage:[UIImage imageNamed:@"BtnReupload_1.jpg"] forState:UIControlStateNormal];
    [reuploadBtn setBackgroundImage:[UIImage imageNamed:@"BtnReupload_2.jpg"] forState:UIControlStateHighlighted];
    [reuploadBtn addTarget:self action:@selector(reUpload) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:reuploadBtn];
    [reuploadBtn release];
    
}

-(void)reUpload
{
    [self simpleToServer];
}

#pragma -mark 下面两个函数仅仅用来测试
-(NSString*) getValidURL
{
    if (false) {
        //TODO: 从系统的配置文件中读取，然后自动将可以用的url返回给所需函数
    }
    
    return [NSString stringWithFormat:@"http://%@/apps/coyotes/post_answer1.php?",[Toolkit getTestUrl]];
    //return [NSString stringWithFormat:@"http://%@:8080/coyotes/post_answer1.php?",[Toolkit getTestUrl]];
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
    [request setPostValue:[self arrToString:_replies] forKey:@"ans"];
    
    NSLog(@"request = %@",request);
    
    [request setCompletionBlock:^{
        
        NSLog(@"responseString = %@",request.responseString);
        
        NSDictionary *dic = [request.responseString objectFromJSONString];
        NSLog(@"dic %@",dic);
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            
            [ProgressHUD showSuccess:@"上传成功"];
            
            [self addAnswersView];
            
        }
        else{
            [ProgressHUD showError:@"上传失败"];
            
            //显示重传按钮
            [self addReuploadView];

        }
        
    }];
    [request setFailedBlock:^{
        
        [ProgressHUD showError:@"上传失败"];
        
        NSLog(@"asi error: %@",request.error.debugDescription);
        
        //显示重传按钮
        [self addReuploadView];
        
    }];
    
    [request startAsynchronous];
}

//数组转字符串
-(NSString *) arrToString:(NSMutableArray *)array
{
    NSString *str = [[[NSString alloc]init]autorelease];
    for (int i=0; i<[array count]; i++) {
        str = [str stringByAppendingFormat:@"%@_", [array objectAtIndex:i]];
    }
    
    return str;
}

#pragma -mark 视图切换函数
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
