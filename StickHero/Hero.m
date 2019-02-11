//
//  Hero.m
//  StickHero
//
//  Created by OurEDA on 15/5/5.
//  Copyright (c) 2015年 com.OurEDA. All rights reserved.
//

#import "Hero.h"

@implementation Hero
@synthesize isAlive;
@synthesize isWalking;

- (Hero *)initWithPositionInView:(CGPoint)point :(UIView*)aView {
    isAlive = YES;
    isWalking = NO;
    center = point;
    position = CGPointMake(point.x - point.y / 28.0, point.y - point.y / 8.0);
    
    heroView = [[UIImageView alloc] initWithFrame:CGRectMake(position.x, position.y, position.y / 7.0, position.y / 7.0)];
    [heroView setImage:[UIImage imageNamed:@"hero"]];
    [aView addSubview:heroView];
    return self;
}

- (BOOL)goForwardFrom:(StageBlock *)stage1 :(StageBlock *)stage2 :(CGFloat)distance :(CGFloat)maxDistanceCanGo :(CGFloat)stickLength {
    CGFloat minLength = stage2.start.x - (stage1.start.x + stage1.width);
    CGFloat maxLength = stage2.start.x + stage2.width - (stage1.start.x + stage1.width);
    CGFloat dist = stickLength > maxDistanceCanGo ? maxDistanceCanGo : distance;
    BOOL perfect = false;
    if (stickLength < minLength || stickLength > maxLength) {
        dist = stickLength + stage1.width;
    }
    if ((stickLength >= ((minLength + maxLength) / 2) - 5) && (stickLength <= ((minLength + maxLength) / 2) + 5)) {
        // Add bonus point for "perfect" plank
        perfect = true;
    }
    
    [UIView animateWithDuration:1.0
                          delay:1.0
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         isWalking = YES;
                         position.x += dist;
                         center.x += dist;
                         heroView.frame=CGRectMake(position.x, position.y, heroView.frame.size.width, heroView.frame.size.height);
                     } completion:^(BOOL finish) {
                         isWalking = NO;
                         if (stickLength < minLength || stickLength > maxLength) {
                             isAlive = NO;
                             [self fall];
                         }
                         heroView.frame=CGRectMake(position.x, position.y, heroView.frame.size.width, heroView.frame.size.height);
                     }];
    return perfect;
}

- (void)go:(CGFloat)distance {
    isWalking = YES;
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         position.x -= distance;
                         center.x -= distance;
                         heroView.frame=CGRectMake(position.x, position.y, heroView.frame.size.width, heroView.frame.size.height);
                     } completion:^(BOOL finish){
                         isWalking = NO;
                     }
     ];
}

- (void)fall {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:UIViewAnimationOptionTransitionFlipFromTop
                     animations:^{
                         position.y += 500;
                         center.y += 500;
                         heroView.frame = CGRectMake(position.x, position.y, heroView.frame.size.width, heroView.frame.size.height);
                     } completion:^(BOOL finish) {
                     }];
}

- (CGPoint)center {
    return center;
}

- (void)destroy {
    [heroView removeFromSuperview];
}
@end
