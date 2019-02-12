//
//  Stick.h
//  StickHero
//
//  Forked from OurEDA on 2/7/2019.
//  Copyright (c) 2019 Ryan Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Stick : NSObject{
    BOOL canIncrease;
    CGFloat length;
    UIView *stickView;
}

@property CGPoint start;
@property BOOL visiablity;
@property BOOL isMoving;

- (Stick *)initWithPointInView:(CGPoint)point :(UIView *)aView;
- (void)increaseLength;
- (void)stopIncreaseLength;
- (void)fallDown;
- (void)disappear;
- (void)switchIncreaseStatus;
- (void)move:(CGFloat)distance;
- (void)destroy;
- (CGFloat)length;
- (CGPoint)start;

@end
