using System.Runtime.InteropServices;
using UnityEngine;

namespace MinimumExample.iOS
{
    /// <summary>
    /// ObjectiveC++コードで実装した`Example`クラスのP/Invokeクラス
    /// </summary>
    public static class ExampleBridge
    {
        /// <summary>
        /// ログに"Hello World"と出力
        /// </summary>
        /// <returns>true固定</returns>
        /// <remarks>
        /// 実際に他のC#コードから呼び出されるのはこちら。
        ///
        /// NOTE: 敢えて別関数に分けている理由としては、`PrintHelloWorldImpl`を直接呼び出してしまうと
        ///       UnityEditor含めた他のプラットフォームからの呼び出しの際に不都合が生じるため。
        /// </remarks>
        public static int PrintHelloWorld()
        {
#if !UNITY_EDITOR && UNITY_IOS
            // iOS実機上からの呼び出し
            return PrintHelloWorldImpl();
#else
            // それ以外のプラットフォームからの呼び出し (Editor含む)
            Debug.Log("Hello World (iOS以外からの呼び出し)");
            return 1;
#endif
        }

        /// <summary>
        /// iOSネイティブプラグインの呼び出し箇所 
        /// </summary>
        /// <remarks>
        /// NOTE: .mmの「extern "C"」内で宣言した関数をここで呼び出す
        /// - iOSのプラグインは静的に実行ファイルにリンクされるので、`DllImport`にはライブラリ名として「__Internal」を指定する必要がある
        /// - `EntryPoint`に.mm側で宣言されている名前を渡すことで、C#側のメソッド名は別名を指定可能
        ///     - EntryPointを使わない場合はC#側も.mm側と同名に合わせる必要がある
        /// </remarks>
        [DllImport("__Internal", EntryPoint = "printHelloWorld")]
        static extern int PrintHelloWorldImpl();
    }
}
