//
//  ViewController.m
//  MineSweeper2
//
//  Created by shima jinsei on 2014/09/28.
//  Copyright (c) 2014年 Jinsei Shima. All rights reserved.
//

#import "ViewController.h"
#import "OverView.h"

//#define BOM 18

@interface ViewController (){
    UILabel *label;
    UILabel *b_label;
    
    UISlider *sl;
    UIToolbar *_tb;
    UIView *popView;
    
}

@property OverView *overView;
@property UIButton *button;
//@property float time;
@end



@implementation ViewController

int ROW = 6;
int LINE = 6;
int BOM = 8;
int d_BOM = 8;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self lifeReset];
    
    //下にマスを配置する
    [self makeMas];
    
    //爆弾数を表示
    [self setLabel];
    
    //爆弾のリセットを行うボタンの配置
    [self resetButton];
    
    //リセットボタンと設定ボタンの配置
    //[self setSettingButton];

}


//設定ボタンの配置
-(void)setSettingButton{
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(0,0,50,50);
    button.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*0.15);
    UIImage *img = [UIImage imageNamed:@"nikoniko.png"];  // ボタンにする画像を生成する
    [button setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
    [button addTarget:self action:@selector(resetButtonPushed:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
}


//爆弾ラベルの配置
-(void)setLabel{
    label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 10,200, 50);
    label.center = CGPointMake(self.view.frame.size.width/2+100, self.view.frame.size.height*0.15);
    label.textColor = [UIColor blackColor];
    label.font = [UIFont fontWithName:@"AppleGothic" size:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"爆弾数：%d",BOM];
    [self.view addSubview:label];
}

//爆弾ラベルの更新
-(void)labelReset{
    label.text = [NSString stringWithFormat:@"爆弾数：%d",BOM];
}
-(void)b_labelReset{
    b_label.text = [NSString stringWithFormat:@"爆弾数：%d",d_BOM];
}



//リセットボタンの配置（ニコニコマーク）
-(void)resetButton{
    UIButton *button = [[UIButton alloc]init];
    button.frame = CGRectMake(0,0,60,60);
    button.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*0.15);
    
    UIImage *img = [UIImage imageNamed:@"resetButton2.png"];  // ボタンにする画像を生成する
    [button setBackgroundImage:img forState:UIControlStateNormal];  // 画像をセットする
    
    [button addTarget:self action:@selector(resetButtonPushed:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:button];
    
    
    
    UIButton *setButton = [[UIButton alloc]init];
    setButton.frame = CGRectMake(0,0,60,60);
    setButton.center = CGPointMake(self.view.frame.size.width*0.92, self.view.frame.size.height*0.15);
    UIImage *setimg = [UIImage imageNamed:@"settingButton2.png"];  // ボタンにする画像を生成する
    [setButton setBackgroundImage:setimg forState:UIControlStateNormal];  // 画像をセットする
    [setButton addTarget:self action:@selector(settingButtonPushed:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:setButton];
    
    d_BOM = BOM;
    
}

//リセットボタン（ニコニコマーク）をおした時の動作
-(void)resetButtonPushed:(UIButton*)button{
    [self lifeReset];
    [self viewRemove];
    [self makeMas];
    [self labelReset];
}


//設定ボタンをおした時の動作（ポップアップ画面の表示）
-(void)settingButtonPushed:(UIButton*)button{
    _tb = [[UIToolbar alloc] init];
    _tb.frame = self.view.frame;
    _tb.barStyle = UIBarStyleBlack;
    _tb.translucent = YES;
    _tb.alpha = 0.6;
    _tb.tag = 2000;
    [self.view addSubview:_tb];

    
    popView = [[UIView alloc]init];
    popView.frame = CGRectMake(0,0,self.view.frame.size.width*0.7,self.view.frame.size.height*0.3);
    popView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    popView.layer.cornerRadius = 20.0;
    popView.backgroundColor = [UIColor colorWithRed:0.349 green:0.82 blue:0.67 alpha:1.0];
    [self.view addSubview:popView];
    
    [self setPopLabel];
    [self setSlider];
    [self setgoButton];
}


//スライダーの配置
-(void)setSlider{
    sl = [[UISlider alloc]initWithFrame:CGRectMake(0, 0, popView.frame.size.width*0.7, 20)];
    sl.center = CGPointMake(popView.frame.size.width/2, popView.frame.size.height*0.5);
    sl.minimumValue = 1.0;  // 最小値を0に設定
    sl.maximumValue = ROW*LINE-1;  // 最大値を500に設定
    sl.value = (float)BOM;  // 初期値を250に設定
    // 値が変更された時にhogeメソッドを呼び出す
    [sl addTarget:self action:@selector(sliding:) forControlEvents:UIControlEventValueChanged];
    [popView addSubview:sl];
}

// Sliderの移動時のメソッド
-(void)sliding:(UISlider*)slider{
    d_BOM = sl.value;
    [self b_labelReset];
}


//ポップアップの設定画面
-(void)setPopLabel{
    UILabel *poplabel = [[UILabel alloc]init];
    poplabel.frame = CGRectMake(0,0,popView.frame.size.width,100);
    poplabel.center = CGPointMake(popView.frame.size.width/2, popView.frame.size.height*0.15);
    poplabel.text = @"爆弾の数を変更できます。";
    poplabel.textAlignment = NSTextAlignmentCenter;
    poplabel.font = [UIFont fontWithName:@"AppleGothic" size:22];
    poplabel.textColor = [UIColor whiteColor];
    [popView addSubview:poplabel];
    
    b_label = [[UILabel alloc] init];
    b_label.frame = CGRectMake(10, 10,200, 50);
    b_label.center = CGPointMake(popView.frame.size.width/2, popView.frame.size.height*0.4);
    b_label.textColor = [UIColor blackColor];
    b_label.font = [UIFont fontWithName:@"AppleGothic" size:18];
    b_label.textAlignment = NSTextAlignmentCenter;
    b_label.text = [NSString stringWithFormat:@"爆弾数：%d",BOM];
    b_label.textColor = [UIColor whiteColor];

    [popView addSubview:b_label];
    
}

-(void)setgoButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIFont *font = [UIFont fontWithName:@"Hiragino Kaku Gothic Pro" size:24];
    button.titleLabel.font = font;
    button.frame = CGRectMake(0,0,100,50);
    button.center = CGPointMake(popView.frame.size.width/2, popView.frame.size.height*0.8);
    [button setTitle:@"変更" forState:UIControlStateNormal];
    button.layer.cornerRadius = 8.0;
    UIColor *color = [UIColor colorWithRed:0.349 green:0.82 blue:0.67 alpha:1.0];[UIColor colorWithRed:0.349 green:0.82 blue:0.67 alpha:1.0];
    
    [button setTitleColor:color forState:UIControlStateNormal ];
    button.backgroundColor = [UIColor whiteColor];
    [button addTarget:self action:@selector(goButtonPushed:) forControlEvents:UIControlEventTouchDown];
    [popView addSubview:button];
}

-(void)goButtonPushed:(UIButton*)button{
    BOM = d_BOM;//goボタンが押された時にボムの更新
    [_tb removeFromSuperview];
    [popView removeFromSuperview];
    //リセットボタンの動作
    [self lifeReset];
    [self viewRemove];
    [self labelReset];
    [self makeMas];
}




//下に配置するマス
-(void)makeMas{
    
    int width = self.view.frame.size.width;
    int box_width = (width-10*(LINE+1))/(LINE+1);
    int nowTag = 0;//捜査時の現在の位置
    int count = 0;//近隣の爆弾数
    int rand[BOM];//爆弾の場所を格納する配列
    int rands=0;//一時的に乱数を保持する変数
    int flag=0;//乱数の重なりを判別するフラグ
    
    //繰り返しのない乱数を作る
    for(int i=0;i<BOM;i++){
        rands = arc4random()%(LINE*ROW);//1~マス数の間の乱数
        for(int j=0;j<i;j++){//これまでの出目と重なっていないか調べる
            if(rands == rand[j]){
                flag = 1;
                break;
            }
        }
        
        if(flag != 1 && rands!=0){//重なりがない場合に乱数を代入する
            rand[i] = rands;
        }else{//重なりがある場合はもう一回、同じiで繰り返す
            i -= 1;
            flag = 0;
            //continue;
        }
    }
    
    for (int a=0; a<BOM; a++) {
        NSLog(@"BOM:%d",rand[a]);
    }
    NSLog(@" ");
    
    //隣接する爆弾数を計算する
    for(int i=0;i<ROW;i++){
        for(int j=0;j<LINE;j++){
            nowTag = i*ROW+j;
            
            //現在のタグの周囲に爆弾がないかを調べる
            for(int j=0;j<BOM;j++){
                if(nowTag-1 == rand[j] && nowTag%LINE != 0)count++;//左
                if(nowTag+1 == rand[j] && nowTag%LINE != LINE-1)count++;//右
                
                if(nowTag-LINE-1 == rand[j] && nowTag%LINE != 0)count++;//左上
                if(nowTag-LINE == rand[j])count++;//上
                if(nowTag-LINE+1 == rand[j] && nowTag%LINE != LINE-1)count++;//右上
                
                if(nowTag+LINE-1 == rand[j] && nowTag%LINE != 0)count++;//左下
                if(nowTag+LINE == rand[j] && i < ROW)count++;//下
                if(nowTag+LINE+1 == rand[j] && nowTag%LINE != LINE-1)count++;//右下
                
                if(nowTag == rand[j]) flag = 1;
                NSLog(@"nowTag:%d rand:%d",nowTag,rand[j]);
            }
            
            _button = [[UIButton alloc]init];
            _button.frame = CGRectMake((5+box_width/2)*(2*j+1), (5+box_width/2)*(2*i+1)+200, box_width, box_width);
            [ _button setTitleColor:[ UIColor blackColor ] forState:UIControlStateNormal ];
            _button.backgroundColor = [UIColor clearColor];
            _button.tag = ROW*i+j+1+200;//後で削除するため（+200はoverViewとの区別）
            
            //上に重ねるViewを作成
            _overView = [[OverView alloc]init];
            _overView.frame = CGRectMake((5+box_width/2)*(2*j+1),(5+box_width/2)*(2*i+1)+200,box_width,box_width);
            _overView.tag = ROW*i+j+1;
            _overView.delegate = self;
            _overView.alpha = 1.0;
            

            if(flag != 1){//爆弾でないマス
                [_button setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
            }else{//爆弾のマス
                _overView.flag = 1;//flagプロパティを1にするとタップした時アラートを表示
                flag = 0;
                _button.backgroundColor = [UIColor redColor];
            }
            
            [self.view addSubview:_button];
            [self.view addSubview:_overView];
            count = 0;
        }
    }
}


//押したViewを削除するメソッド
-(void)viewRemove{
    for(int i=0;i<ROW;i++){
        for(int j=0;j<LINE;j++){
            //タグを指定して画面から削除
            [[self.view viewWithTag:ROW*i+j+1] removeFromSuperview];//overViewを削除
            [[self.view viewWithTag:ROW*i+j+1+200] removeFromSuperview];//buttonを削除＋200することで差別化
        }
    }
    [self lifeReset];
}


//lifeの初期設定
-(void)lifeReset{
    _life = ROW*LINE-BOM;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//stepperを選択した時の処理
- (IBAction)stepperAction:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    switch (segment.selectedSegmentIndex) {
        case 0: // 6*6が選択されたとき
            [self viewRemove];
            ROW = 6;
            LINE = 6;
            BOM = 8;
            [self makeMas];
            [self lifeReset];
            [self labelReset];
            break;
            
        case 1: // 9*9が選択されたとき
            [self viewRemove];
            ROW = 9;
            LINE = 9;
            BOM = 18;
            [self makeMas];
            [self lifeReset];
            [self labelReset];
            break;
            
        case 2: // 12*12が選択されたとき
            [self viewRemove];
            ROW = 12;
            LINE = 12;
            BOM = 32;
            [self makeMas];
            [self lifeReset];
            [self labelReset];
            break;
            
        default:
            break;
    }
}


/**
 * デリゲートメソッドその1を実装（マスをリセット）
 */
- (void)sampleMethod1
{
    [self lifeReset];
    [self viewRemove];
    [self makeMas];
    //[self setLabel];
    [self labelReset];
}

/**
 * デリゲートメソッドその2を実装（Title画面に遷移）
 */
- (void)sampleMethod2
{
    //ここに画面遷移を記述(タイトル画面に戻る)
    //[self dismissViewControllerAnimated:YES completion:nil];
}


/**
 * デリゲートメソッドその3を実装
 */
- (void)sampleMethod3
{
    //ここに画面遷移を記述
    _life -= 1;
    NSLog(@"life:%d",_life);
    if(_life <= 0){
        //OverView *view = [[OverView alloc]init];
        [self setAlert];
    }
}



-(void)setAlert{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Game Clear!"
                          message:@"おめでとう。クリアです"
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"もう一度", nil];
    // アラートビューを表示
    [alert show];
}

/**
 * アラートのボタンが押されたとき
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0: // もう一度が押されたとき
            //[self test];//ViewControllerのマスをリセットする
            
            [self lifeReset];
            [self viewRemove];
            [self makeMas];
            [self labelReset];
            
            NSLog(@"もう一度");
            break;
            
        default: // キャンセルが押されたとき
            [self lifeReset];
            [self viewRemove];
            [self makeMas];
            [self labelReset];
            
            NSLog(@"Cancel");
            break;
    }
}




- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    switch (touch.view.tag) {
        case 2000:
            // タグが1のビュー
            [touch.view removeFromSuperview];
            [popView removeFromSuperview];
            [self labelReset];
            break;
            
        default:
            break;
    }
}


@end
