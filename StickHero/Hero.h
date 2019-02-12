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
    UIImageView *heroView;
    CGPoint center;
    CGPoint position;
}

@property BOOL isAlive;
@property BOOL isWalking;

- (Hero *)initWithPositionInView:(CGPoint)point :(UIView *)aView;
- (void)go:(CGFloat)distance;
- (BOOL)goForwardFrom:(StageBlock *)stage1 to:(StageBlock *)stage2 withDistance:(CGFloat)distance maxDistance:(CGFloat)maxDistanceCanGo stickLength:(CGFloat)stickLength;
- (void)fall;
- (CGPoint)center;
- (void)destroy;
@end
