//
//  SwipeUpInteractiveTransition.h
//  viewControllerTransitionDemo
//
//  Created by 顏逸修 on 2023/4/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (assign, nonatomic) BOOL interacting;

- (void) writeToViewController: (UIViewController *) viewController;

@end

NS_ASSUME_NONNULL_END
