//
//  ViewController.h
//  StickHero
//
//  Created by OurEDA on 15/5/4.
//  Copyright (c) 2015年 com.OurEDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stick.h"
#import "Hero.h"
#import "StageBlock.h"

const int TOUCHES_STARTED = 0;
const int TOUCHES_ENDED   = 1;
const int UPDATING_UI     = 2;

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


@end

