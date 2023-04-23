//
//  SecondViewController.h
//  viewControllerTransitionDemo
//
//  Created by 顏逸修 on 2023/4/22.
//

#import <UIKit/UIKit.h>
@class SecondViewController;

NS_ASSUME_NONNULL_BEGIN

@protocol SecondViewControllerDelegate <NSObject>

- (void) secondViewControllerDidClickedDismissButton: (SecondViewController *)secondViewController;
- (void) passDataToMainController: (NSString *) passData;

@end

@interface SecondViewController : UIViewController

@property (weak, nonatomic) id<SecondViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
