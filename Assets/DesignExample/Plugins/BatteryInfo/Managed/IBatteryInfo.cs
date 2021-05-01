namespace BatteryInfo
{
    public interface IBatteryInfo
    {
        /// <summary>
        /// バッテリーレベル(残量)を[0.0 ~ 1.0]の範囲で返す
        /// </summary>
        float GetBatteryLevel();
    }
}
