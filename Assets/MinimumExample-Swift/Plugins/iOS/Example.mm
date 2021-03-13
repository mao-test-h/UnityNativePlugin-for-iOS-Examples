#import <Foundation/Foundation.h>

// 2019.3からはこちらをimportする必要がある
#import <UnityFramework/UnityFramework-Swift.h>

// MARK:- extern "C" (Cリンケージで宣言)

#ifdef __cplusplus
extern "C" {
#endif

// NOTE: この関数が実際にUnity(C#)から呼び出される
int printHelloWorld() {

    // `Example.swift`で実装した`Example.printHelloWorld`を呼び出す。呼び出し時の構文はObjC形式となる。
    // NOTE: クラスメソッド(静的関数)として実装しているので、クラスをインスタンス化せずに直接呼び出せる
    return [Example printHelloWorld];
}

#ifdef __cplusplus
}
#endif
