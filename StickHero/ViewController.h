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
    CGFloat width,height;
    Stick *stick;
    Stick *prevStick;
    Hero *hero;
    StageBlock *stage1;
    StageBlock *stage2;
    StageBlock *stage3;
    
    int best;
    int score;
    UILabel *bestScore;
    UILabel *bestScoreLabel;
    UILabel *curScore;
    UILabel *curScoreLabel;
    UIButton *restart;
    UILabel *myScore;
    UIButton *myScore_;
    UILabel *help;
}

+ (NSInteger)getRandomNumber:(NSInteger)max;
- (void)initUI;


@end

