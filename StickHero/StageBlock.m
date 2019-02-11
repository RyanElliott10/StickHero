//
//  StageBlock.m
//  StickHero
//
//  Created by OurEDA on 15/5/5.
//  Copyright (c) 2015年 com.OurEDA. All rights reserved.
//

#import "StageBlock.h"

@implementation StageBlock
@synthesize isMoving;

- (StageBlock *)initWithPositionInView:(CGPoint)point :(UIView *)aView {
    start = point;
    width = (CGFloat)(arc4random()%100 + 10);
    stageView = [[UIView alloc] initWithFrame:CGRectMake(start.x, start.y, width, point.y/2.0)];
    stageView.backgroundColor = [UIColor blackColor];
    isMoving = NO;
    [aView addSubview:stageView];
    return self;
}

- (void)move:(CGFloat)distance {
    isMoving = YES;
    [UIView animateWithDuration:1
                          delay:0.00
                        options:UIViewAnimationOptionTransitionFlipFromRight
                     animations:^{
                         start.x -= distance;
                         stageView.frame=CGRectMake(start.x ,start.y, width, stageView.frame.size.height);
                     } completion:^(BOOL finish) {
                         isMoving = NO;
                     }];
}

- (CGPoint)start {
    return start;
}
- (CGFloat)width {
    return width;
}

- (void)resetWidth:(StageBlock*)stage {
    stageView.frame = CGRectMake(start.x, start.y, [stage width], stageView.frame.size.height);
}

- (void)destroy {
    [stageView removeFromSuperview];
}

@end
