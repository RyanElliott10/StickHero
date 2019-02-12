//
//  Stick.m
//  StickHero
//
//  Forked from OurEDA on 2/7/2019.
//  Copyright (c) 2019 Ryan Elliott. All rights reserved.
//

#import "Stick.h"

@implementation Stick
@synthesize start;
@synthesize visiablity;
@synthesize isMoving;

- (Stick *)initWithPointInView:(CGPoint)point :(UIView *) aView{
    start = point;
    length = 0;
    canIncrease = YES;
    visiablity = YES;
    stickView = [[UIView alloc] initWithFrame:CGRectMake(start.x, start.y, 2, length)];
    stickView.backgroundColor = [UIColor redColor];
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
    stickView.layer.anchorPoint = CGPointMake(0, 1);
    return;
}

- (void)stopIncreaseLength {
    canIncrease = NO;
}

- (void)fallDown {
    CABasicAnimation* rotationAnimation= [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:  M_PI * 0.5 ];
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
                         stickView.frame = CGRectMake(start.x , start.y + length, 2, 0);
                     } completion:^(BOOL finish) {
                         start.y = start.y + length;
                         length = 0;
                         [self switchIncreaseStatus];
                         visiablity = NO;
                     }];
}

- (void)move:(CGFloat)distance {
    isMoving = YES;
    [UIView animateWithDuration:1
                          delay:0.00
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                         start.x -= distance;
                         stickView.frame = CGRectMake(start.x, start.y, 2, stickView.frame.size.height);
                     } completion:^(BOOL finish) {
                         isMoving = NO;
                     }];
}

- (void)switchIncreaseStatus {
    canIncrease = ~canIncrease;
}

- (CGFloat)length {
    return length;
}

- (void)destroy {
    [stickView removeFromSuperview];
}

@end
