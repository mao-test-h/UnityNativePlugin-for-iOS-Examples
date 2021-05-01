package com.samples.utility;

import android.content.Context;
import android.content.Intent;
import android.os.BatteryManager;
import android.app.Activity;
import android.content.IntentFilter;

import com.unity3d.player.UnityPlayer;

public final class BatteryInfo
{
    /**
     * バッテリーレベル(残量)を[0.0 ~ 1.0]の範囲で返す
     */
    public static float getBatteryLevel(){
        final Intent batteryStatus = getBatteryStatus();
        final float level = (float) batteryStatus.getIntExtra(BatteryManager.EXTRA_LEVEL, -1);
        final float scale = (float) batteryStatus.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        return level / scale;
    }

    private static Intent getBatteryStatus(){
        final Activity activity = UnityPlayer.currentActivity;
        final Context context = activity.getApplicationContext();
        final IntentFilter ifilter = new IntentFilter(Intent.ACTION_BATTERY_CHANGED);
        return context.registerReceiver(null, ifilter);
    }
}
