//
//  EndView.h
//  StuentEvaluation
//
//  Created by admin  on 13-12-23.
//  Copyright (c) 2013年 com.seuli. All rights reserved.
//

/**
 * @brief 最后一页的视图（View）
 * @author lixiang
 * @todo: 创建一个效果图
 */

#import <UIKit/UIKit.h>


@protocol EndViewDelegate <NSObject>

-(void)back;

@end

@interface EndView : UIView

@property (nonatomic, assign) id delegate;

- (id)initWithDelegate:(id)delegate quesArray:(NSArray *)questionNumber;

@end
