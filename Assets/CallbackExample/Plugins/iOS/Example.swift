import Foundation

// NOTE: C#側で定義している以下のデリゲート型に対応する関数ポインタ
// > delegate void SampleCallbackDelegate(Int32 num);
//
// ちなみに`@convention(c)`はC言語の関数ポインタ形式であることを指す
public typealias SampleCallbackDelegate = @convention(c) (Int32) -> Void


public class Example {

    // メンバ変数
    // NOTE: `registerSampleCallback`から渡されるC#のコールバックを持つ
    private var sampleCallbackDelegate: SampleCallbackDelegate? = nil

    /// コールバックの登録
    ///
    /// NOTE:
    /// メンバ変数`sampleCallbackDelegate`にC#から渡されるコールバックを登録
    /// (C#風に言い換えるとデリゲート型のフィールドにメソッドを渡すイメージ)
    func registerSampleCallback(_ delegate: @escaping SampleCallbackDelegate) {
        sampleCallbackDelegate = delegate
    }

    /// `sampleCallbackDelegate`に登録してあるコールバックを呼び出す
    func callSampleCallback() {
        sampleCallbackDelegate?(2);
    }
}


// `@_cdecl("[メソッド名]")`を使うことでCの関数として定義することが可能
// NOTE: 以下にある`@_cdecl`を付けている関数が実際にUnity(C#)から呼び出される

// C#から渡されるコールバックをインスタンスに登録
@_cdecl("registerSampleCallback")
public func registerSampleCallback(_ instancePtr: UnsafeRawPointer, _ delegate: @escaping SampleCallbackDelegate) {

    // NOTE: こういう感じに直接呼び出すこともできる
    //delegate(1)

    // インスタンスに登録
    let instance = Unmanaged<Example>.fromOpaque(instancePtr).takeUnretainedValue()
    instance.registerSampleCallback(delegate)
}

// インスタンスに登録したコールバックを呼び出し
@_cdecl("callSampleCallback")
public func callSampleCallback(_ instancePtr: UnsafeRawPointer) {
    let instance = Unmanaged<Example>.fromOpaque(instancePtr).takeUnretainedValue()
    instance.callSampleCallback()
}

// インスタンスの生成・解放

// インスタンス化
// NOTE: 戻り値のポインタをC#側でIntPtrなどで保持し、インスタンスメソッドの呼び出し時に渡して使う
@_cdecl("createExample")
public func createExample() -> UnsafeRawPointer {
    let instance = Example()
    let unmanaged = Unmanaged<Example>.passRetained(instance)
    return UnsafeRawPointer(unmanaged.toOpaque())
}

// 解放
@_cdecl("releaseExample")
public func releaseExample(_ instancePtr: UnsafeRawPointer) {
    let unmanaged = Unmanaged<Example>.fromOpaque(instancePtr)
    unmanaged.release()
}
