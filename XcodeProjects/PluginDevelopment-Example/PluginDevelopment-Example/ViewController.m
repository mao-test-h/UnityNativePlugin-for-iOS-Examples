#import "ViewController.h"
#import "NativeShare.h"

// MARK:- implementation (クラスの実装部)

@implementation ViewController

/// NOTE: Viewがロードされた後に呼び出される処理
/// ref: https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload?language=objc
- (void)viewDidLoad {
    [super viewDidLoad];

    // Storyboard上に配置されているボタン(ここで言うsampleと言う名のボタン)に対してタップイベントを登録
    // NOTE: ここでは直ぐ下で定義している`tapButton`と言う関数を登録している
    // NOTE: ObjCのプロパティにアクセスする際にはプレフィックスに`_`を付ける必要がある
    [_sampleButton addTarget:self
                      action:@selector(tapButton:)
            forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapButton:(UIButton*)button {

    // 渡す文字列
    NSString* text = @"ネイティブアプリからの呼び出し";

    // Unity向けのネイティブプラグインを呼び出し
    [NativeShare shareText:text viewController:self];
}

@end
