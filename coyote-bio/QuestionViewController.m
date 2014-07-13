//
//  QuestionViewController.m
//  coyote-bio
//
//  Created by apple on 14-3-15.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "QuestionViewController.h"
#import "ProgressHUD.h"
#import "Toolkit.h"
#import "UploadViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)dealloc
{
    [_numberLabel release];
    [_nextStep release];
    [_questionImageView release];
    [_mulButtonView release];
    [_specialButton1 release];
    [_specialButton2 release];
    [_specialButton3 release];
    [_choiceView release];
    [_questionList release];
    [_replies release];
    [_uploadParma release];
    [_question5Answer release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        //_questionList = [[NSMutableArray alloc]init];
        //_uploadParma = [[NSMutableDictionary alloc]init];
       // _count = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _questionList = [[NSMutableArray alloc]init];
    _uploadParma = [[NSMutableDictionary alloc]init];
    _count = 1;
    
	//获取测试数据
    NSString *path = [[NSBundle mainBundle] bundlePath];
	NSString *plistPath = [path stringByAppendingPathComponent:@"test.plist"];
    NSLog(@"filePath: %@",plistPath);
    NSArray *list = [NSMutableArray arrayWithContentsOfFile:plistPath];
    //NSLog(@"%@",list);
    [_questionList addObjectsFromArray:list];
    //这里的情况有可能在其它函数中，变量被释放啦
    self.item = [NSMutableDictionary dictionaryWithDictionary:[_questionList objectAtIndex:0]];
    
    _replies = [[NSMutableArray alloc] init];
    //题5
    _question5Answer = [[NSMutableString alloc] initWithFormat:@"000"];
    
    for (int i=0; i<[_questionList count]; i++) {
        [_replies addObject:@"0"];
    }
    
    [self addImageView];
    [self addLabelView];
    [self addButtonView];
    
    //self.view.bounds = CGRectMake(0, 0, 1344, 768);
    NSLog(@"wight %f heigh %f",self.view.bounds.size.width, self.view.bounds.size.height);
    //self.view.backgroundColor = [UIColor redColor];
    
    //左划手势
    UISwipeGestureRecognizer *swipeGesture=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeGesture.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeGesture];
    [swipeGesture release];
    
    //	UITapGestureRecognizer *panGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickPicture:)];
    //    [self.view addGestureRecognizer:panGes];
    //    [panGes release];
}

#pragma -mark first update view
//view添加labelView控件
-(void)addLabelView
{
    //答题时间显示
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 22, 250, 30)];
    _timeLabel.font = [UIFont boldSystemFontOfSize:25];
    _timeLabel.textColor = [UIColor redColor];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_timeLabel];
    
    //block实现倒计时
    NSLog(@"total = %@",[Toolkit getTotalTime]);
    __block int timeout = [[Toolkit getTotalTime] intValue]; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        //测试过程中时间结束，立即跳出。如果测试者答完也将跳出
        if(timeout < 0 || _endTestSign == YES){
            
            //倒计时结束，关闭，须立即提交，停止作答
            dispatch_source_cancel(_timer);
            dispatch_release(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                
                //强制提交
                //[_dynamicImageView stopAnimating];
                //[self zipFile];
                //[self uploadToServer];
                
            });
            
        }
        else{
            
            int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%d:%.2d",minutes, seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //主线程显示
                [_timeLabel setText:strTime];
                
            });
            timeout--;
            
            //实时计算答题时间
            int cha = 3000 - timeout;
            [_uploadParma setValue:[NSString stringWithFormat:@"%d", cha] forKey:@"testTime"];
        }
    });
    dispatch_resume(_timer);
    
    //题数显示
    _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 50, 80, 60)];
    [_numberLabel setText:[NSString stringWithFormat:@"%d/%lu",_count,(unsigned long)[_questionList count]]];
    _numberLabel.font = [UIFont boldSystemFontOfSize:23];
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:_numberLabel];
}

//view添加buttonView控件
-(void)addButtonView
{
    _nextStep = [[UIButton alloc]init];
    _nextStep.frame = CGRectMake(1024-62, 384-70, 62, 140);
    [_nextStep setBackgroundImage:[UIImage imageNamed:@"BtnNext_1.jpg"] forState:UIControlStateNormal];
    [_nextStep setBackgroundImage:[UIImage imageNamed:@"BtnNext_2.jpg"] forState:UIControlStateHighlighted];
    [_nextStep addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_nextStep setTag:100];
    [self.view addSubview:_nextStep];
    
    //答题按钮 范围很重要！！！！！！！
    _mulButtonView = [[MulButtonView alloc]initWithDelegate:self];
    [_mulButtonView refreshButtonLocation:[_item objectForKey:@"button_location"]];
    [self.view addSubview:_mulButtonView];
}

//view添加imageView控件
-(void)addImageView
{
    
    //题目图片view
    _questionImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];  //获取路径
    NSString *imagePath = [path stringByAppendingPathComponent:[_item objectForKey:@"test_picture"]];
    [_questionImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
    _questionImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_questionImageView];
    
}

#pragma -mark 按钮触发事件，涉及以下三个函数
-(void)btnClicked:(id)sender
{
    UIButton *btn =(UIButton *)sender;
    switch (btn.tag) {
        case 100:
            [self refreshView];
            break;
        case 200:
        {
            _buttonNum = 200;
            [self addSpecialView];
            break;
        }
        case 201:
            _buttonNum = 201;
            [self addSpecialView];
            break;
        case 202:
            _buttonNum = 202;
            [self addSpecialView];
            break;
        default:
            break;
    }
}

-(void)addSpecialView
{
    if (_choiceView == nil) {
        _choiceView = [[ChoiceView alloc]initWithDelegate:self];
    }
    [_choiceView resetViewLocation:_buttonNum];
    [self.view addSubview:_choiceView];
}

//划动手势
-(void)handleSwipeGesture:(UIGestureRecognizer*)sender{
    //划动的方向
    UISwipeGestureRecognizerDirection direction=[(UISwipeGestureRecognizer*) sender direction];
    //判断是上下左右
    switch (direction) {
        case UISwipeGestureRecognizerDirectionUp:
            //NSLog(@"up");
            break;
        case UISwipeGestureRecognizerDirectionDown:
            //NSLog(@"down");
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            NSLog(@"left");
            [self refreshView];  //滑动后切换视图
            break;
        case UISwipeGestureRecognizerDirectionRight:
            //NSLog(@"right");
            break;
        default:
            break;
    }
}

#pragma -mark view change
//更新界面
-(void)refreshView
{
    //考虑是否该题已答，这里需要判断处理
    
    if ([[_replies objectAtIndex:_count-1] isEqualToString:@"0"]) {
        [ProgressHUD showError:@"本题还未答！"];
        return;
    }
    
    
    //数据变化
    _count++;
    
    //UI变化
    //最后一次题特殊处理，即需要提交
    if(_count <= [_questionList count]){
        //界面数据
        _item = [_questionList objectAtIndex:_count-1];
        
        //题目数量显示
        [_numberLabel setText:[NSString stringWithFormat:@"%d/%lu",_count,(unsigned long)[_questionList count]]];
        
        //题目显示
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSString *imagePath = [path stringByAppendingPathComponent:[_item objectForKey:@"test_picture"]];
        [_questionImageView setImage:[UIImage imageWithContentsOfFile:imagePath]];
        
        //特殊视图特殊对待
        if (_count == 5) {
            _mulButtonView.hidden = YES;
            [self addSpecialButton];
        }
        else{
            _mulButtonView.hidden = NO;
            //按钮显示
            _specialButton1.hidden = YES;
            _specialButton2.hidden = YES;
            _specialButton3.hidden = YES;
            [_mulButtonView refreshButtonLocation:[_item objectForKey:@"button_location"]];
        }
        
        //如果是最后一题，出现的是提交按钮
        if (_count == [_questionList count]) {
            //提交按钮显示
        }
    }
    
    else{
        
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"提示" message:@"此刻是否完成提交！！！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertview show];
        [alertview release];
        alertview = nil;
        
    }
}

//针对alertView的事件处理 alertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        //将这个量设为之前翻页时的量 两种情况，一种上传失败，一种是取消
        _count = (int)[_questionList count];
        return;
    }
    else if(buttonIndex == 1)
    {
        _endTestSign = YES;
        
        //答题时间 姓名 试题编号 答案
        [_uploadParma setValue:[Toolkit getUserName] forKey:@"uc"];
        [_uploadParma setValue:@"20140201" forKey:@"qgc"];
        [_uploadParma setValue:[self arrToString:_replies] forKey:@"ans"];
        
        //切换到上传页
        [self performSegueWithIdentifier:@"QuestionToUpload" sender:self];
        
    }
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

#pragma -mark SpecialButtonView 创建按钮
-(void) createSpecialButton:(NSString*)buttonName :(NSInteger)left :(NSInteger)top
{
    UIButton * button = [[UIButton alloc]init];
    button.frame = CGRectMake(left,top,65,65);
    [button setBackgroundImage:[UIImage imageNamed:@"BtnClick_1.jpg"]forState:UIControlStateNormal];
    [button.titleLabel setTextColor: [UIColor blackColor]];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if ([buttonName isEqualToString:@"btn1"]) {
        _specialButton1 = button;
        [_specialButton1 setTag:200];
        [self.view addSubview:_specialButton1];
    }
    if ([buttonName isEqualToString:@"btn2"]) {
        _specialButton2 = button;
        [_specialButton2 setTag:201];
        [self.view addSubview:_specialButton2];
    }
    if ([buttonName isEqualToString:@"btn3"]) {
        _specialButton3 = button;
        [_specialButton3 setTag:202];
        [self.view addSubview:_specialButton3];
    }
}

//添加三个特殊按钮
-(void) addSpecialButton
{
    [self createSpecialButton:@"btn1" :498 :229];
    [self createSpecialButton:@"btn2" :316 :342];
    [self createSpecialButton:@"btn3" :216 :469];
    
}

//第五题特殊处理
-(void) setButtonTitle:(NSInteger)buttonIndex
{
    NSArray *ansABC = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D", nil];
    NSArray *arr = [NSArray arrayWithObjects:@"05Txt_1.jpg",@"05Txt_2.jpg", @"05Txt_3.jpg",@"05Txt_4.jpg", nil];
    //区分是哪个按钮的响应
    switch (_buttonNum) {
        case 200:
            [_specialButton1 setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:buttonIndex]] forState:UIControlStateNormal];
            [_specialButton1 setFrame:CGRectMake(459, 238, 140, 50)];
            [_question5Answer replaceCharactersInRange:NSMakeRange(0, 1) withString:[ansABC objectAtIndex:buttonIndex]];
            NSLog(@"ANSWER5: %@",_question5Answer);
            break;
        case 201:
            [_specialButton2 setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:buttonIndex+2]] forState:UIControlStateNormal];
            [_specialButton2 setFrame:CGRectMake(282, 356, 140, 50)];
            [_question5Answer replaceCharactersInRange:NSMakeRange(1, 1) withString:[ansABC objectAtIndex:buttonIndex]];
            break;
        case 202:
            [_specialButton3 setBackgroundImage:[UIImage imageNamed:[arr objectAtIndex:buttonIndex+2]] forState:UIControlStateNormal];
            [_specialButton3 setFrame:CGRectMake(181, 477, 140, 50)];
            [_question5Answer replaceCharactersInRange:NSMakeRange(2, 1) withString:[ansABC objectAtIndex:buttonIndex]];
            break;
        default:
            break;
    }
}


#pragma -mark ChoiceViewDelegate
-(void)removeChoiceView
{
    [_choiceView removeFromSuperview];
}

-(void)clickChoiceValue:(int)btnNumber
{
    if (btnNumber == 0) {
        
        NSLog(@"0");
        [self setButtonTitle:btnNumber];
        
        
    }else if (btnNumber == 1) {
        
        NSLog(@"1");
        [self setButtonTitle:btnNumber];
        
    }else if(btnNumber == 2) {
        
        NSLog(@"2");
        [self setButtonTitle:btnNumber];
        
    }else if(btnNumber == 3) {
        
        NSLog(@"3");
        [self setButtonTitle:btnNumber];
    }
    
    [_replies replaceObjectAtIndex:_count-1 withObject:_question5Answer];
    
    [self removeChoiceView];
}

#pragma -mark MulButtonViewDelegate 委托
//gaiAPP只用到这个
-(void)clickSingleButtonValue:(int)btnNumber
{
    NSArray *ansABC = [NSArray arrayWithObjects:@"A",@"B",@"C",@"D", nil];
    [_replies replaceObjectAtIndex:_count-1 withObject:[ansABC objectAtIndex:btnNumber]];
    //输出回答问题答案
    NSLog(@"%@",_replies);
}

-(void)clickButtonValue:(int)btnNumber
{
    //TODO:
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

#pragma mark -Prepare for Segue 传递参数
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [segue.identifier isEqualToString:@"QuestionToUpload"]) {
        // To Last View
        
        UploadViewController * dstViewController = (UploadViewController*)segue.destinationViewController;

        //传值
        [dstViewController setReplies:_replies];
        
        dstViewController = nil;
    }
}

@end
