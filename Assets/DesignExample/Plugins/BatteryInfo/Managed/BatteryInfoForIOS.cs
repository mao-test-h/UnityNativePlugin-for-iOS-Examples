#if UNITY_IOS
using System.Runtime.InteropServices;
using UnityEngine;

namespace BatteryInfo
{
    /// <summary>
    /// iOS向けの`IBatteryInfo`の実装
    /// </summary>
    public sealed class BatteryInfoForIOS : IBatteryInfo
    {
        public BatteryInfoForIOS()
        {
            Debug.Log("iOSで実行");
        }

        float IBatteryInfo.GetBatteryLevel() => GetBatteryLevelNative();

        #region P/Invoke

        /// <summary>
        /// バッテリーレベル(残量)を[0.0 ~ 1.0]の範囲で返す
        /// </summary>
        [DllImport("__Internal", EntryPoint = "getBatteryLevel")]
        static extern float GetBatteryLevelNative();

        #endregion P/Invoke
    }
}
#endif
