//
//  ViewController.h
//  StickHero
//
//  Forked from OurEDA on 2/7/2019.
//  Copyright (c) 2019 Ryan Elliott. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stick.h"
#import "Hero.h"
#import "StageBlock.h"

@interface ViewController : UIViewController {
    BOOL acceptingTouches;
    int lastState;
    int score;
    CGFloat width,height;
    
    Stick *stick;
    Stick *prevStick;
    Hero *hero;
    StageBlock *stage1;
    StageBlock *stage2;
    StageBlock *stage3;
    
    UILabel *curScore;
    UILabel *myScore;
    UILabel *help;
    UIButton *myScore_;
}

+ (NSInteger)getRandomNumber:(NSInteger)max;
- (void)initUI;

@end
