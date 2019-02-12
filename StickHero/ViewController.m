//
//  ViewController.m
//  StickHero
//
//  Forked from OurEDA on 2/7/2019.
//  Copyright (c) 2019 Ryan Elliott. All rights reserved.
//

#import "ViewController.h"
#import <Skillz/Skillz.h>

@interface ViewController ()

@end

@implementation ViewController

const int TOUCHES_STARTED = 0;
const int TOUCHES_ENDED   = 1;
const int UPDATING_UI     = 2;

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma -mark touches

- (BOOL)isMoving {
    return stage1.isMoving || stage2.isMoving || stage3.isMoving || stick.isMoving || prevStick.isMoving;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (acceptingTouches && lastState != TOUCHES_ENDED) {
        [stick increaseLength];
        lastState = TOUCHES_STARTED;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (acceptingTouches && lastState == TOUCHES_STARTED) {
        [stick stopIncreaseLength];
        lastState = TOUCHES_ENDED;
        [self updateUI];
    }
}

#pragma -mark progress

+ (NSInteger)getRandomNumber:(NSInteger)max {
    if ([[Skillz skillzInstance] tournamentIsInProgress]) {
        return [Skillz getRandomNumberWithMin:0
                                       andMax:max];
    } else {
        return arc4random_uniform((uint32_t)max);
    }
}

- (void)loadLabels {
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info"
                                                     ofType:@"plist"];
    acceptingTouches = YES;
    
    // Buttons and labels
    help = [[UILabel alloc] initWithFrame:CGRectMake(0, height * 0.1, width, height * 0.1)];
    help.text = @"Press and hold to play";
    help.alpha = 0.8;
    [help setTextAlignment:NSTextAlignmentCenter];
    help.textColor = [UIColor whiteColor];
    [help.layer setCornerRadius:10.0];
    [self.view addSubview:help];
    
    myScore_= [[UIButton alloc] initWithFrame:CGRectMake(width * 0.35, height * 0.2, width * 0.3, width * 0.2)];
    myScore_.backgroundColor = [UIColor grayColor];
    myScore_.alpha = 0.2;
    [myScore_.layer setCornerRadius:10.0];
    myScore = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.35, height * 0.2, width * 0.3, width * 0.2)];
    myScore.text = [NSString stringWithFormat:@"%d",score];
    [myScore setTextAlignment:NSTextAlignmentCenter];
    myScore.textColor = [UIColor whiteColor];
    myScore.font =  [UIFont boldSystemFontOfSize:50.0];
    [self.view addSubview:myScore_];
    [self.view addSubview:myScore];
}

- (void)initUI {
    [self loadLabels];
    CGPoint point = CGPointMake(width * 0.1, height * 2 / 3.0);
    hero = [[Hero alloc] initWithPositionInView:point
                                               :self.view];
    stage1 = [[StageBlock alloc] initWithPositionInView:point
                                                       :self.view];
    stick = [[Stick alloc] initWithPointInView:CGPointMake(point.x + [stage1 width], point.y)
                                              :self.view];
    CGFloat randomWidth = (CGFloat)([ViewController getRandomNumber:INT_MAX] % (100) + [stage1 width] + 100);
    point.x += randomWidth;
    stage2 = [[StageBlock alloc] initWithPositionInView:point
                                                       :self.view];
}

- (void)updateUI {
    acceptingTouches = NO;
    lastState = UPDATING_UI;
    
    [stick fallDown];
    BOOL bonusPoint = [hero goForwardFrom:stage1
                                       to:stage2
                             withDistance:stage2.start.x - hero.center.x + stage2.width - 35
                              maxDistance:width - [hero center].x
                              stickLength:stick.length];
    while(hero.isWalking) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode
                                 beforeDate:[NSDate distantFuture]];
    }
    
    if (bonusPoint) {
        score++;
    }
    
    hero.isAlive ? [self updateWithHeroAlive] : [self updateWithHeroDead];
    acceptingTouches = YES;
}

- (void)updateWithHeroAlive {
    CGFloat distance = [stage2 start].x - [stage1 start].x;
    CGFloat randomWidth = (CGFloat)([ViewController getRandomNumber:INT_MAX] % 200);
    stage3 = [[StageBlock alloc] initWithPositionInView:CGPointMake(width + randomWidth, height * 2 / 3.0)
                                                       :self.view];
    score++;
    myScore.text = [NSString stringWithFormat:@"%d", score];
    
    while (([stage3 start].x - distance > width) || ([stage3 start].x + [stage3 width] > width+distance) || ([stage3 start].x - [stage2 start].x < 0.1 * width)) {
        randomWidth = (CGFloat)([ViewController getRandomNumber:INT_MAX] % 200);
        stage3 = [[StageBlock alloc] initWithPositionInView:CGPointMake(width + randomWidth, height * 2 / 3.0)
                                                           :self.view];
    }
    
    [hero go:distance];
    [stage1 move:distance];
    [stage2 move:distance];
    [stage3 move:distance];
    [prevStick move:distance];
    [stick move:distance];
    
    while([self isMoving]) {
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode
                                beforeDate:[NSDate distantFuture]];
    }
    
    stage1 = stage2;
    stage2 = stage3;
    [prevStick disappear];
    [prevStick destroy];
    prevStick = stick;
    CGPoint point = CGPointMake(width * 0.1, height * 2 / 3.0);
    stick = [[Stick alloc] initWithPointInView:CGPointMake(point.x+[stage1 width], point.y)
                                              :self.view];
}

- (void)updateWithHeroDead {
    NSNumber *playerScore = [NSNumber numberWithInt:score];
    [[Skillz skillzInstance] displayTournamentResultsWithScore:playerScore
                                                withCompletion:^{
                                                    score = 0;
                                                    [self.view addSubview:curScore];
                                                    [myScore removeFromSuperview];
                                                    [myScore_ removeFromSuperview];
                                                    [stage1 destroy];
                                                    [stage2 destroy];
                                                    [stage3 destroy];
                                                    [prevStick destroy];
                                                    [stick destroy];
                                                    [hero destroy];
                                                }];
}

- (void)restartGame:(id)sender {
    [self destroyAll];
    [self removeAllFromSuperview];
    [self initUI];
    myScore.text = [NSString stringWithFormat:@"%d",score];
    [self.view addSubview:myScore_];
    [self.view addSubview:myScore];
}

- (void)destroyAll {
    [prevStick destroy];
    [stick destroy];
    [stage1 destroy];
    [stage2 destroy];
    [stage3 destroy];
    [hero destroy];
    stick = nil;
    stage1 = nil;
    stage2 = nil;
    hero = nil;
}

- (void)removeAllFromSuperview {
    [curScore removeFromSuperview];
}

#pragma -mark tools

- (void)waitUntil:(BOOL*)flag {
    if (flag) {
        [self waitUntil:flag ];
    }
}

@end
