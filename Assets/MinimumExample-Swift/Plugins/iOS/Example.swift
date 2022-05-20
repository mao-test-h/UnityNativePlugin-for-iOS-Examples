import Foundation

public class Example {
    /// ログに"Hello World"と出力して2を返す。
    /// NOTE: ここではクラスメソッド(静的関数)として実装
    ///
    /// - Returns: 2固定
    public static func printHelloWorld() -> Int32 {
        // ログ出力
        print("Hello World")

        // 戻り値を返す
        return 2
    }
}

// `@_cdecl("[メソッド名]")`を使うことでCの関数として定義することが可能

// NOTE: この関数が実際にUnity(C#)から呼び出される
@_cdecl("printHelloWorld")
public func printHelloWorld() -> Int32 {

    // ↑で実装している`Example.printHelloWorld`を呼び出すだけ。
    // NOTE: クラスメソッド(静的関数)として実装しているので、クラスをインスタンス化せずに直接呼び出せる
    return Example.printHelloWorld()
}
