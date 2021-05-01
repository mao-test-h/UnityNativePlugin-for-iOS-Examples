#import <UIKit/UIKit.h>

// MARK:- extern "C" (Cリンケージで宣言)

#ifdef __cplusplus
extern "C" {
#endif

// バッテリーレベル(残量)を[0.0 ~ 1.0]の範囲で返す
float getBatteryLevel() {

    UIDevice* currentDevice = [UIDevice currentDevice];

    // NOTE: バッテリーレベルを取得するなら`batteryMonitoringEnabled`を有効にする必要がある
    // ref: https://developer.apple.com/documentation/uikit/uidevice/1620045-batterymonitoringenabled?language=objc
    currentDevice.batteryMonitoringEnabled = true;

    // ref: https://developer.apple.com/documentation/uikit/uidevice/1620042-batterylevel?language=objc
    return currentDevice.batteryLevel;
}

#ifdef __cplusplus
}
#endif
