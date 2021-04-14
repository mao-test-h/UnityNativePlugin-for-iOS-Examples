#import <UIKit/UIKit.h>

// NOTE: 実態はUnityがiOSビルドで出力するプロジェクト中に含まれる`UnityAppController.mm`と言うソースにある
extern UIViewController* UnityGetGLViewController();


// MARK:- interface (クラスの宣言部)

/// ネイティブのシェア機能の呼び出し
@interface NativeShare : NSObject

/// テキストのシェア
/// @param text シェアする文字列
/// @param vc 対象のViewController
+ (void)shareText:(NSString*)text viewController:(UIViewController*)vc;

@end


// MARK:- implementation (クラスの実装部)

@implementation NativeShare

+ (void)shareText:(NSString*)text viewController:(UIViewController*)vc {

    // NOTE: UIActivityViewControllerでシェア
    // ref: https://developer.apple.com/documentation/uikit/uiactivityviewcontroller?language=objc

    NSArray* array = @[text];
    UIActivityViewController* avc = [[UIActivityViewController alloc] initWithActivityItems:array applicationActivities:nil];
    [vc presentViewController:avc animated:TRUE completion:nil];
}

@end


// MARK:- extern "C" (Cリンケージで宣言)

#ifdef __cplusplus
extern "C" {
#endif

// NOTE: C#から渡される文字列はcharのポインタ型として渡される
void shareText(char* textPtr) {

    // NSStringへの変換
    NSString* text = [NSString stringWithCString:textPtr encoding:NSUTF8StringEncoding];

    // NOTE: Unity上からViewControllerを取得するには`UnityGetGLViewController()`を使う
    UIViewController* vc = UnityGetGLViewController();
    [NativeShare shareText:text viewController:vc];
}

#ifdef __cplusplus
}
#endif
