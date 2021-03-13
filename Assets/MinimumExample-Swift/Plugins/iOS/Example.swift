import Foundation

// NOTE: ObjCに公開する物はアクセスレベルを`public` or `open`に設定する必要あり

public class Example: NSObject {

    // ObjCに公開するメソッドには`@objc`を付ける

    /// ログに"Hello World"と出力して2を返す。
    /// NOTE: ここではクラスメソッド(静的関数)として実装
    ///
    /// - Returns: 2固定
    @objc public static func printHelloWorld() -> Int {
        // ログ出力
        print("Hello World")

        // 戻り値を返す
        return 2
    }
}
