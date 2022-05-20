using System;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.UI;

namespace InstanceMethodExample
{
    /// <summary>
    /// インスタンス化及びインスタンスメソッドの呼び出しサンプル
    /// </summary>
    sealed class Example : MonoBehaviour
    {
        [SerializeField] Button _buttonHelloWorld = default;
        [SerializeField] InputField _inputField = default;

        IntPtr _instance = IntPtr.Zero;

        void Start()
        {
            _buttonHelloWorld.onClick.AddListener(() =>
            {
#if !UNITY_EDITOR && UNITY_IOS
                // プラグインの呼び出し
                var ret = PrintHelloWorldWithMember(_instance);
                Debug.Log($"戻り値: {ret}");
#else
                // それ以外のプラットフォームからの呼び出し (Editor含む)
                Debug.Log("Hello World (iOS以外からの呼び出し)");
#endif
            });

            _inputField.onEndEdit.AddListener(text =>
            {
                if (int.TryParse(text, out var num))
                {
#if !UNITY_EDITOR && UNITY_IOS
                    // プラグインの呼び出し
                    SetMember(_instance, num);
#else
                    Debug.Log($"{num} (iOS以外からの呼び出し)");
#endif
                }
            });

#if !UNITY_EDITOR && UNITY_IOS
            _instance = CreateExample();
#endif
        }

        void OnDestroy()
        {
            if (_instance != IntPtr.Zero)
            {
                ReleaseExample(_instance);
            }
        }

        #region P/Invoke

        // ObjectiveC++コードで実装した`Example`クラスのP/Invoke

        // ネイティブコード側にあるExampleクラスのインスタンス化
        // NOTE: 戻り値はインスタンスのポインタ
        [DllImport("__Internal", EntryPoint = "createExample")]
        static extern IntPtr CreateExample();

        // インスタンスの解放
        [DllImport("__Internal", EntryPoint = "releaseExample")]
        static extern void ReleaseExample(IntPtr instance);

        // `setMember`の呼び出し
        [DllImport("__Internal", EntryPoint = "setMember")]
        static extern void SetMember(IntPtr instance, Int32 value);

        // `printHelloWorldWithMember`の呼び出し
        [DllImport("__Internal", EntryPoint = "printHelloWorldWithMember")]
        static extern Int32 PrintHelloWorldWithMember(IntPtr instance);

        #endregion P/Invoke
    }
}
