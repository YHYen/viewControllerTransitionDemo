//
//  SwipeUpInteractiveTransition.m
//  viewControllerTransitionDemo
//
//  Created by 顏逸修 on 2023/4/22.
//

#import "SwipeUpInteractiveTransition.h"

@interface SwipeUpInteractiveTransition ()

@property (assign, nonatomic) BOOL shouldComplete;
@property (strong, nonatomic) UIViewController *presentingVC;

@end

@implementation SwipeUpInteractiveTransition

- (void)writeToViewController:(nonnull UIViewController *)viewController {
    self.presentingVC = viewController;
    [self prepareGestureRecognizerInView:viewController.view];
}

- (void) prepareGestureRecognizerInView: (UIView *) view {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
    [view addGestureRecognizer:panGesture];
}

- (CGFloat) completionSpeed {
    return 1 - self.percentComplete;
}

- (void) handleGesture: (UIPanGestureRecognizer *) panGestureRecognizer {
    CGPoint translation = [panGestureRecognizer translationInView:panGestureRecognizer.view.superview];
    
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            // 1. Mark the interacting flag. Uesd when supplying it in delegate.
            NSLog(@"Press begin");
            self.interacting = YES;
            [self.presentingVC dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged: {
            // 2. Calculate the percentage of gesture
            NSLog(@"Press changed");
            CGFloat fraction = translation.y / 400.0;
            // Limit it between 0 and 1
            fraction = fminf(fmaxf(fraction, 0.0), 1.0);
            self.shouldComplete = (fraction > 0.5);
            
            [self updateInteractiveTransition:fraction];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            // 3. Gesture over. Check if the transition should happen or not
            NSLog(@"Press cancel");
            self.interacting = NO;
            if (!self.shouldComplete || panGestureRecognizer.state == UIGestureRecognizerStateCancelled) {
                [self cancelInteractiveTransition];
            } else {
                [self finishInteractiveTransition];
            }
            break;
        }
        default:
            break;
        }
    }
}

@end
