//
//  ViewController.h
//  MineSweeper2
//
//  Created by shima jinsei on 2014/09/28.
//  Copyright (c) 2014年 Jinsei Shima. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverView.h"

@interface ViewController : UIViewController<SampleDelegate>{
    NSTimer *timer;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *levelStepper;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *timeStepper;
//@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

- (IBAction)stepperAction:(id)sender;
//- (IBAction)timeAction:(id)sender;


@property int life;

@end
