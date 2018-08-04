//
//  TitleViewController.h
//  MineSweeper2
//
//  Created by shima jinsei on 2014/09/30.
//  Copyright (c) 2014年 Jinsei Shima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *startButton;
- (IBAction)startButtonAction:(id)sender;
@end
