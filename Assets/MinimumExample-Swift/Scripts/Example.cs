using System;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.UI;

namespace MinimumExample
{
    /// <summary>
    /// 最小構成のサンプル呼び出し
    /// </summary>
    sealed class Example : MonoBehaviour
    {
        [SerializeField] Button _buttonHelloWorld = default;

        void Start()
        {
            _buttonHelloWorld.onClick.AddListener(() =>
            {
#if !UNITY_EDITOR && UNITY_IOS
                // プラグインの呼び出し
                var ret = PrintHelloWorld();
                Debug.Log($"戻り値: {ret}");
#else
                // それ以外のプラットフォームからの呼び出し (Editor含む)
                Debug.Log("Hello World (iOS以外からの呼び出し)");
#endif
            });
        }

        #region P/Invoke

        // Swiftで実装した`Example`クラスのP/Invoke

        /// <summary>
        /// `printHelloWorld`の呼び出し
        /// </summary>
        /// <remarks>
        /// NOTE: Example.swiftの`@_cdecl`で定義した関数をここで呼び出す
        /// - iOSのプラグインは静的に実行ファイルにリンクされるので、`DllImport`にはライブラリ名として「__Internal」を指定する必要がある
        /// - `EntryPoint`にSwift側で定義されている名前を渡すことでC#側のメソッド名は別名を指定可能
        /// </remarks>
        [DllImport("__Internal", EntryPoint = "printHelloWorld")]
        static extern Int32 PrintHelloWorld();


        // NOTE: ちなみに`EntryPoint`を指定しない場合は、以下のようにC#側もSwiftで定義されている関数名と同名に合わせる必要がある
        // [DllImport("__Internal")]
        // static extern int printHelloWorld();

        #endregion P/Invoke
    }
}
