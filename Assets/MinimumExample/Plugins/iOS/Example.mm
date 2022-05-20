#import <Foundation/Foundation.h>

// MARK:- interface (クラスの宣言部)

@interface Example : NSObject

/// ログに"Hello World"と出力して2を返す。
/// NOTE: ここではクラスメソッド(静的関数)として実装
+ (int32_t)printHelloWorld;

@end


// MARK:- implementation (クラスの実装部)

@implementation Example

+ (int32_t)printHelloWorld {
    // ログ出力
    NSLog(@"Hello World");

    // 戻り値を返す
    return 2;
}

@end


// MARK:- extern "C" (Cリンケージで宣言)

#ifdef __cplusplus
extern "C" {
#endif

// NOTE: この関数が実際にUnity(C#)から呼び出される
int32_t printHelloWorld() {

    // 上記で宣言・実装した`Example.printHelloWorld`を呼び出す。呼び出し時の構文はObjC形式となる。
    // NOTE: クラスメソッド(静的関数)として実装しているので、クラスをインスタンス化せずに直接呼び出せる
    return [Example printHelloWorld];
}

#ifdef __cplusplus
}
#endif
