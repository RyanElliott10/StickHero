//
//  Stick.m
//  StickHero
//
//  Created by OurEDA on 15/5/5.
//  Copyright (c) 2015年 com.OurEDA. All rights reserved.
//

#import "Stick.h"

@implementation Stick
@synthesize start;
@synthesize visiablity;

- (Stick *)initWithPointInView:(CGPoint)point :(UIView *) aView{
    start = point;
    length = 0;
    canIncrease = YES;
    visiablity = YES;
    stickView = [[UIView alloc] initWithFrame:CGRectMake(start.x, start.y, 2, length)];
    stickView.backgroundColor = [UIColor blackColor];
    [aView addSubview:stickView];
    return self;
}

- (void)increaseLength {
    if (canIncrease) {
        start.y -= 2.0;
        length += 2.0;
        [UIView animateWithDuration:0.0
                              delay:0
                            options:UIViewAnimationOptionTransitionFlipFromLeft
                         animations:^{
                             stickView.frame=CGRectMake(start.x, start.y, 2, length);
                         } completion:^(BOOL finish) {
                             [self increaseLength];
                         }
        ];
    }
    stickView.layer.anchorPoint = CGPointMake(0,1);
    return;
}

- (void)stopIncreaseLength {
    canIncrease = NO;
}

- (void)fallDown {
    CABasicAnimation* rotationAnimation= [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:  M_PI*0.5 ];
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    rotationAnimation.duration = 1;
    rotationAnimation.repeatCount = 1;
    rotationAnimation.cumulative = NO;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    [stickView.layer addAnimation:rotationAnimation forKey:@"Rotation"];
}

- (void)disappear {
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         stickView.frame = CGRectMake( start.x , start.y+length, 2, 0);
                     } completion:^(BOOL finish) {
                         start.y = start.y+length;
                         length = 0;
                        [self switchIncreaseStatus];
                         visiablity = NO;
                     }];
}

- (void)switchIncreaseStatus {
    canIncrease = ~canIncrease;
}

- (CGFloat)length {
    return length;
}

- (void)destory {
    [stickView removeFromSuperview];
}
@end
