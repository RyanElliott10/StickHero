//
//  Stick.h
//  StickHero
//
//  Created by OurEDA on 15/5/5.
//  Copyright (c) 2015年 com.OurEDA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Stick : NSObject{
    CGFloat length;
    BOOL canIncrease;
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
- (CGFloat)length;
- (CGPoint)start;
- (void)destroy;

@end
