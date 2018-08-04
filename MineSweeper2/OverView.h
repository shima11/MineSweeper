//
//  OverView.h
//  MineSweeper2
//
//  Created by shima jinsei on 2014/09/28.
//  Copyright (c) 2014年 Jinsei Shima. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ViewController.h"

// デリゲートを定義
@protocol SampleDelegate <NSObject>
// デリゲートメソッドを宣言
// （宣言だけしておいて，実装はデリゲート先でしてもらう）
- (void)sampleMethod1;
- (void)sampleMethod2;
- (void)sampleMethod3;
@end


@interface OverView : UIView

@property int flag;
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;


// デリゲート先で参照できるようにするためプロパティを定義しておく
@property (nonatomic, assign) id<SampleDelegate> delegate;
// デリゲートメソッドを呼ぶメソッド
- (void)test;
-(void)setAlert;

@end
