//
//  NSBSimpleSegue.m
//  StoryBoardSample
//
//  Created by yankchina on 14-3-13.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "NSBSimpleSegue.h"
#import "SegueStatusListener.h"

@implementation NSBSimpleSegue

- (void)perform {
    UIViewController<SegueStatusListener> *srcViewController = [self sourceViewController];
    UIViewController<SegueStatusListener> *dstViewController = [self destinationViewController];
    
    UIView *srcView = [srcViewController view];
    UIView *dstView = [dstViewController view];
    
    [srcView addSubview:dstView];
    
    [dstView setTransform: CGAffineTransformMakeScale(0.05, 0.05)];
    
    // Store original centre point of the destination view
    CGPoint originalCenter = dstView.center;
    // Set center to start point of the button
    dstView.center = srcView.center;
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         // Grow!
                         dstView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         dstView.center = originalCenter;
                     }
                     completion:^(BOOL finished){
                         [dstView removeFromSuperview]; // remove from temp super view
                         [srcViewController presentViewController:dstViewController animated:NO completion:NULL]; // present VC
                     }];
}


@end
