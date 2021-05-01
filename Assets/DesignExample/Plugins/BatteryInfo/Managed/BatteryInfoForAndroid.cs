#if UNITY_ANDROID
using UnityEngine;

namespace BatteryInfo
{
    /// <summary>
    /// Android向けの`IBatteryInfo`の実装
    /// </summary>
    public sealed class BatteryInfoForAndroid : IBatteryInfo
    {
        readonly AndroidJavaClass _javaClass;

        public BatteryInfoForAndroid()
        {
            Debug.Log("Androidで実行");
            _javaClass = new AndroidJavaClass("com.samples.utility.BatteryInfo");
        }

        float IBatteryInfo.GetBatteryLevel()
            => _javaClass.CallStatic<float>("getBatteryLevel");
    }
}
#endif
