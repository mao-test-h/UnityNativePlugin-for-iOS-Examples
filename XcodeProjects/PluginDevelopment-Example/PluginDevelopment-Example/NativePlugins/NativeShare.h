#ifndef TextShare_h
#define TextShare_h

#import <UIKit/UIKit.h>

// MARK:- interface (クラスの宣言部)

/// ネイティブのシェア機能の呼び出し
@interface NativeShare : NSObject

/// テキストのシェア
/// @param text シェアする文字列
/// @param vc 対象のViewController
+ (void)shareText:(NSString*)text viewController:(UIViewController*)vc;

@end

#endif /* TextShare_h */
