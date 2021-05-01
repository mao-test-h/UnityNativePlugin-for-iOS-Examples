using System;
using BatteryInfo;
using UnityEngine;
using UnityEngine.UI;

namespace DesignExample
{
    /// <summary>
    /// 最小構成のサンプル呼び出し
    /// </summary>
    sealed class Example : MonoBehaviour
    {
        [SerializeField] Text _batteryLebel = default;

        IBatteryInfo _batteryInfo;

        void Start()
        {
            // プラットフォームに応じて実装を差し替える
            // NOTE: サンプルなので雑に分岐しているが、実際にやるならDI経由で注入しても良いかもしれない
#if UNITY_EDITOR
            _batteryInfo = new BatteryInfoForEditor();
#elif UNITY_IOS
            _batteryInfo = new BatteryInfoForIOS();
#elif UNITY_ANDROID
            _batteryInfo = new BatteryInfoForAndroid();
#else
            // 非対応プラットフォームなら投げておく
            throw new NotImplementedException();
#endif
        }

        void Update()
        {
            var batteryLevel = (int) (100 * _batteryInfo.GetBatteryLevel());
            _batteryLebel.text = $"{batteryLevel}%";
        }
    }
}
