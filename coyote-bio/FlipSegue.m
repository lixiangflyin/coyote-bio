// Copyright (c) 2013, Daniel Andersen (dani_ande@yahoo.dk)
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// 1. Redistributions of source code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
// 3. The name of the author may not be used to endorse or promote products derived
//    from this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
// ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
// (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
// ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
// (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
// SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#import "FlipSegue.h"
#import "SegueStatusListener.h"

@implementation FlipSegue

- (void)perform {
    UIViewController<SegueStatusListener> *srcViewController = [self sourceViewController];
    UIViewController<SegueStatusListener> *dstViewController = [self destinationViewController];
    
    UIView *srcView = [srcViewController view];
    UIView *dstView = [dstViewController view];
    
    dstView.transform = srcView.transform;
    dstView.bounds = srcView.bounds;

    UIWindow *window = srcView.window;
    
    [srcViewController transitionAwayFrom];
    [dstViewController beginTransition:srcViewController];

    [UIView transitionFromView:srcView toView:dstView duration:1.5f options:UIViewAnimationOptionTransitionFlipFromTop completion:^(BOOL finished) {
        [window setRootViewController:dstViewController];
        [dstViewController finishedTransition:srcViewController];
    }];
}

@end
