using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.UI;

namespace PluginDevelopmentExample
{
    /// <summary>
    /// シェア機能の呼び出しサンプル
    /// </summary>
    sealed class Example : MonoBehaviour
    {
        [SerializeField] InputField _inputField = default;

        void Start()
        {
            _inputField.onEndEdit.AddListener(text =>
            {
#if !UNITY_EDITOR && UNITY_IOS
                // プラグインの呼び出し
                ShareText(text);
#else
                // それ以外のプラットフォームからの呼び出し (Editor含む)
                Debug.Log($"{text} (iOS以外からの呼び出し)");
#endif
            });
        }

        #region P/Invoke

        // ObjectiveC++コードで実装した`NativeShare`クラスのP/Invoke

        /// <summary>
        /// テキストのシェア
        /// </summary>
        /// <param name="text">シェアするテキスト</param>
        /// <remarks>
        /// NOTE: 引数に渡す文字列はそのままstring型で問題ない。ネイティブコード側でcharのポインタ型に解釈される。
        /// </remarks>
        [DllImport("__Internal", EntryPoint = "shareText")]
        static extern void ShareText(string text);

        #endregion P/Invoke
    }
}
