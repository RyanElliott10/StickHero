//
//  Hero.h
//  StickHero
//
//  Forked from OurEDA on 2/7/2019.
//  Copyright (c) 2019 Ryan Elliott. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "StageBlock.h"

@interface Hero : NSObject{
    CGPoint center;
    CGPoint position;
    UIImageView *heroView;
}

@property BOOL isAlive;
@property BOOL isWalking;

- (void)destroy;
- (void)go:(CGFloat)distance;
- (void)fall;
- (BOOL)goForwardFrom:(StageBlock *)stage1 to:(StageBlock *)stage2 withDistance:(CGFloat)distance maxDistance:(CGFloat)maxDistanceCanGo stickLength:(CGFloat)stickLength;
- (CGPoint)center;
- (Hero *)initWithPositionInView:(CGPoint)point :(UIView *)aView;

@end
