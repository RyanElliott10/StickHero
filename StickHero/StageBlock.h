//
//  StageBlock.h
//  StickHero
//
//  Forked from OurEDA on 2/7/2019.
//  Copyright (c) 2019 Ryan Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StageBlock : NSObject{
    CGPoint start;
    CGFloat width;
    UIView *stageView;
}

@property BOOL isMoving;

- (StageBlock *)initWithPositionInView:(CGPoint)point :(UIView *)aView;
- (void)move:(CGFloat)distance;
- (CGPoint)start;
- (CGFloat)width;
- (void)resetWidth:(StageBlock*)stage;
- (void)destroy;
@end
