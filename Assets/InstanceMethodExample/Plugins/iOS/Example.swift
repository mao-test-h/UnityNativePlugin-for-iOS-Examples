import Foundation

public class Example {

    // メンバ変数
    private var member: Int32 = 0

    /// メンバ変数に値を設定
    func setMember(with value: Int32) {
        member = value
    }

    /// ログに"Hello World"と出力してメンバ変数(`self.member`)に設定された値を返す
    func printHelloWorldWithMember() -> Int32 {
        // ログ出力
        print("Hello World : [\(member)]")

        // 戻り値を返す
        return member
    }
}

// `@_cdecl("[メソッド名]")`を使うことでCの関数として定義することが可能
// NOTE: 以下にある`@_cdecl`を付けている関数が実際にUnity(C#)から呼び出される

// インスタンス化
// NOTE: 戻り値のポインタをC#側でIntPtrなどで保持し、インスタンスメソッドの呼び出し時に渡して使う
@_cdecl("createExample")
public func createExample() -> UnsafeRawPointer {
    let instance = Example()

    // `Unmanaged`を利用することで参照型をARC(自動参照カウント)の管理下から外すことが可能
    // → 以下の処理は自前で参照カウンタをインクリメントしつつ、インスタンスのポインタを返している
    let unmanaged = Unmanaged<Example>.passRetained(instance)

    // `Unmanaged.toOpaque`でOpaque pointerを取得可能
    // ただし、型が`UnsafeMutableRawPointer`なので、一応は意図を明示的にするために`UnsafeRawPointer`に変換している。
    // (P/Invokeに於いてはあまり意味は無いかもだが..)
    return UnsafeRawPointer(unmanaged.toOpaque())
}

// 解放
@_cdecl("releaseExample")
public func releaseExample(_ instancePtr: UnsafeRawPointer) {
    // Opaque pointerは`fromOpaque`に渡すことでUnmanaged型に変換可能
    let unmanaged = Unmanaged<Example>.fromOpaque(instancePtr)

    // `createExample()`でインクリメントした参照カウンタをデクリメントすることで解放
    unmanaged.release()
}

// 以下はインスタンスメソッドの呼び出し
// NOTE: 第一引数にはインスタンス化した際に保持しているポインタを渡す

@_cdecl("setMember")
public func setMember(_ instancePtr: UnsafeRawPointer, _ value: Int32) {
    // `Unmanaged<T>.takeUnretainedValue`でUnmanaged型をインスタンスに戻すことが可能
    // ここではメソッドを呼び出したいだけであり、参照カウンタはそのままで居て欲しいので`takeUnretainedValue`を利用している
    // NOTE: 逆にインスタンスに戻す際に参照カウンタをインクリメントしたい場合には`takeRetainedValue`が使える
    let instance = Unmanaged<Example>.fromOpaque(instancePtr).takeUnretainedValue()
    instance.setMember(with: value)
}

@_cdecl("printHelloWorldWithMember")
public func printHelloWorldWithMember(_ instancePtr: UnsafeRawPointer, _ value: Int32) -> Int32 {
    // `setMember`と同上
    let instance = Unmanaged<Example>.fromOpaque(instancePtr).takeUnretainedValue()
    return instance.printHelloWorldWithMember()
}
