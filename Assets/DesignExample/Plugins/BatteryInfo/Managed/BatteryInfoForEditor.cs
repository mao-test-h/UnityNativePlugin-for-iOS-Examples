#if UNITY_EDITOR
using UnityEngine;

namespace BatteryInfo
{
    /// <summary>
    /// Editor向けの`IBatteryInfo`の実装
    /// </summary>
    public sealed class BatteryInfoForEditor : IBatteryInfo
    {
        public BatteryInfoForEditor()
        {
            Debug.Log("Editorで実行");
        }

        // NOTE: Editor実行時は常に1を返す
        float IBatteryInfo.GetBatteryLevel() => 1f;
    }
}
#endif
