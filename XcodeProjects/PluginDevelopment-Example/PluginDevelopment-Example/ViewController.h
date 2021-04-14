#import <UIKit/UIKit.h>

// MARK:- interface (クラスの宣言部)

/// Main.storyboardに紐付いているViewController
@interface ViewController : UIViewController

/// Storyboard上に配置されている"Sample"と言う名前のボタンの参照
@property(weak, nonatomic) IBOutlet UIButton* sampleButton;

@end
