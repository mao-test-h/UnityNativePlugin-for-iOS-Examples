#import <Foundation/Foundation.h>

// MARK:- 関数ポインタ

// NOTE: C#側で定義している以下のデリゲート型に対応する関数ポインタ
// > delegate void SampleCallbackDelegate(int num);
typedef void (* sampleCallbackDelegate)(int);


// MARK:- interface (クラスの宣言部)

@interface Example : NSObject

// コールバックの登録
// NOTE: メンバ変数`_sampleCallbackDelegate`にC#から渡されるコールバックを登録
//       (C#風に言い換えるとデリゲート型のフィールドにメソッドを渡すイメージ)
- (void)registerSampleCallback:(sampleCallbackDelegate)delegate;

// `_sampleCallbackDelegate`に登録してあるコールバックを呼び出す
- (void)callSampleCallback;

@end


// MARK:- implementation (クラスの実装部)

@implementation Example {

    // メンバ変数
    // NOTE: `registerSampleCallback`から渡されるC#のコールバックを持つ
    sampleCallbackDelegate _sampleCallbackDelegate;
}

// イニシャライザ(インスタンスの初期化)
- (instancetype)init {
    self = [super init];
    if (self) {
        _sampleCallbackDelegate = NULL;
    }

    return self;
}

- (void)registerSampleCallback:(sampleCallbackDelegate)delegate {
    _sampleCallbackDelegate = delegate;
}

- (void)callSampleCallback {
    // コールバックが登録されているなら呼び出し
    if (_sampleCallbackDelegate != NULL) {
        _sampleCallbackDelegate(2);
    }
}

@end


// MARK:- extern "C" (Cリンケージで宣言)
// NOTE: ここで外部宣言している関数が実際にUnity(C#)から呼び出される

#ifdef __cplusplus
extern "C" {
#endif

// C#から渡されるコールバックをそのまま呼び出し
void callSampleCallbackDirect(sampleCallbackDelegate delegate) {
    delegate(1);
}

// C#から渡されるコールバックをインスタンスに登録
void registerSampleCallback(Example* instance, sampleCallbackDelegate delegate) {
    [instance registerSampleCallback:delegate];
}

// インスタンスに登録したコールバックを呼び出し
void callSampleCallback(Example* instance) {
    [instance callSampleCallback];
}

// インスタンスの生成・解放

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

#ifdef __cplusplus
}
#endif
