#import <Foundation/Foundation.h>

// MARK:- interface (クラスの宣言部)

@interface Example : NSObject

// メンバ変数に値を設定
- (void)setMember:(int32_t)value;

// ログに"Hello World"と出力してメンバ変数(_member)に設定された値を返す
- (int32_t)printHelloWorldWithMember;

@end


// MARK:- implementation (クラスの実装部)

@implementation Example {

    // メンバ変数
    int32_t _member;
}

// イニシャライザ(インスタンスの初期化)
- (instancetype)init {
    self = [super init];
    if (self) {
        _member = 0;
    }

    return self;
}

- (void)setMember:(int32_t)value {
    _member = value;
}

- (int32_t)printHelloWorldWithMember {
    // ログ出力
    NSLog(@"Hello World : [%d]", _member);

    // 戻り値を返す
    return _member;
}

@end


// MARK:- extern "C" (Cリンケージで宣言)
// NOTE: ここで外部宣言している関数が実際にUnity(C#)から呼び出される

#ifdef __cplusplus
extern "C" {
#endif

// インスタンス化
// NOTE: 戻り値のポインタをC#側でIntPtrなどで保持し、インスタンスメソッドの呼び出し時に渡して使う
Example* createExample() {
    Example* instance = [[Example alloc] init];
    CFRetain((CFTypeRef) instance);
    return instance;
}

// 解放
void releaseExample(Example* instance) {
    CFRelease((CFTypeRef) instance);
}

// 以下はインスタンスメソッドの呼び出し
// NOTE: 第一引数にはインスタンス化した際に保持しているポインタを渡す

void setMember(Example* instance, int32_t value) {
    [instance setMember:value];
}

int32_t printHelloWorldWithMember(Example* instance) {
    return [instance printHelloWorldWithMember];
}

#ifdef __cplusplus
}
#endif
