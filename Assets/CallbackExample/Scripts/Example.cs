using System;
using System.Runtime.InteropServices;
using UnityEngine;
using UnityEngine.UI;

namespace CallbackExample
{
    /// <summary>
    /// コールバックの登録・呼び出しサンプル
    /// </summary>
    sealed class Example : MonoBehaviour
    {
        [SerializeField] Button _buttonCall = default;

        IntPtr _instance = IntPtr.Zero;

        void Start()
        {
            _buttonCall.onClick.AddListener(() =>
            {
#if !UNITY_EDITOR && UNITY_IOS
                // プラグインの呼び出し
                CallSampleCallback(_instance);
#else
                // それ以外のプラットフォームからの呼び出し (Editor含む)
                Debug.Log("iOS以外からの呼び出し");
#endif
            });


#if !UNITY_EDITOR && UNITY_IOS
            _instance = CreateExample();
            // インスタンスにコールバックを登録しておく
            RegisterSampleCallback(_instance, SampleCallback);
#endif
        }

        void OnDestroy()
        {
            if (_instance != IntPtr.Zero)
            {
                ReleaseExample(_instance);
            }
        }


        #region P/Invoke Callback

        // 登録するメソッド(ここで言う`SampleCallback`)と同じフォーマットのデリゲート
        // NOTE: ネイティブコード側で定義している以下の関数ポインタに対応する
        // > typedef void (* sampleCallbackDelegate)(int);
        delegate void SampleCallbackDelegate(int num);


        // 実際にネイティブコードから呼び出されるメソッド
        // NOTE: iOS(正確に言うとAOT)の場合には「staticメソッドな上で`MonoPInvokeCallbackAttribute`を付ける必要がある」
        [AOT.MonoPInvokeCallbackAttribute(typeof(SampleCallbackDelegate))]
        static void SampleCallback(int num)
        {
            Debug.Log($"ネイティブコードから呼び出された : {num}");
        }

        #endregion P/Invoke Callback


        #region P/Invoke

        // ObjectiveC++コードで実装した`Example`クラスのP/Invoke

        // `registerSampleCallback`の呼び出し
        [DllImport("__Internal", EntryPoint = "registerSampleCallback")]
        static extern int RegisterSampleCallback(IntPtr instance, SampleCallbackDelegate callback);

        // `callSampleCallback`の呼び出し
        [DllImport("__Internal", EntryPoint = "callSampleCallback")]
        static extern int CallSampleCallback(IntPtr instance);


        // ネイティブコード側にあるExampleクラスのインスタンス化
        // NOTE: 戻り値はインスタンスのポインタ
        [DllImport("__Internal", EntryPoint = "createExample")]
        static extern IntPtr CreateExample();

        // インスタンスの解放
        [DllImport("__Internal", EntryPoint = "releaseExample")]
        static extern void ReleaseExample(IntPtr instance);

        #endregion P/Invoke
    }
}
