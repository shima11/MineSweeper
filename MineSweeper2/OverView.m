//
//  OverView.m
//  MineSweeper2
//
//  Created by shima jinsei on 2014/09/28.
//  Copyright (c) 2014年 Jinsei Shima. All rights reserved.
//

#import "OverView.h"
#import "ViewController.h"

@implementation OverView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor grayColor];
        
    }
    return self;
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"overview touch");
    //フェードアウト
    [UIView beginAnimations:@"fadeOut" context:nil];
    //イージング指定
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    //アニメーション秒数を指定
    [UIView setAnimationDuration:0.2];
    //目標のアルファ値を指定
    self.alpha = 0;
    //アニメーション実行
    [UIView commitAnimations];
    
    [self life];
    
    if(_flag == 1){//爆弾の時にアラートを表示
        // アラートビューを作成
        // キャンセルボタンを表示しない場合はcancelButtonTitleにnilを指定
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Game Over!"
                              message:@"残念ながら爆破してしまいました。"
                              delegate:self
                              cancelButtonTitle:nil
                              otherButtonTitles:@"もう一度", nil];
        
        // アラートビューを表示
        [alert show];

    }
    

}

/**
 * アラートのボタンが押されたとき
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: // もう一度が押されたとき
            [self test];//ViewControllerのマスをリセットする
            NSLog(@"もう一度");
            break;
            
        default: 
            break;
    }
}

/**
 * デリゲートメソッドを呼び出す
 */
- (void)test
{
    // デリゲート先がちゃんと「sampleMethod1」というメソッドを持っているか?
    if ([self.delegate respondsToSelector:@selector(sampleMethod1)]) {
        [self.delegate sampleMethod1];
    }
}


-(void)backTitle{
    if([self.delegate respondsToSelector:@selector(sampleMethod2)]){
        [self.delegate sampleMethod2];
    }
}

-(void)life{
    if([self.delegate respondsToSelector:@selector(sampleMethod3)]){
        [self.delegate sampleMethod3];
    }
}


@end
