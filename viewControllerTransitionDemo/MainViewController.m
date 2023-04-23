//
//  ViewController.m
//  viewControllerTransitionDemo
//
//  Created by 顏逸修 on 2023/4/22.
//

#import "MainViewController.h"
#import "SecondViewController.h"
#import "SecondPresentAnimation.h"
#import "SwipeUpInteractiveTransition.h"
#import "NormalDismissAnimation.h"

@interface MainViewController () <SecondViewControllerDelegate, UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) IBOutlet UIButton *presentButton;

@property (strong, nonatomic) SecondPresentAnimation *secondPresentAnimation;
@property (strong, nonatomic) SwipeUpInteractiveTransition *swipeUpInteractiveTransition;
@property (strong, nonatomic) NormalDismissAnimation *nornalDismissAnimation;
@property (strong, nonatomic) NSString *data;

@end

@implementation MainViewController


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
        _secondPresentAnimation = [SecondPresentAnimation new];
        _swipeUpInteractiveTransition = [SwipeUpInteractiveTransition new];
        _nornalDismissAnimation = [NormalDismissAnimation new];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
        [button setTitle:@"Click me" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
}

-(void) buttonClicked:(id)sender
{
    SecondViewController *sec = [[UIStoryboard storyboardWithName:@"Second" bundle:nil] instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    if (@available(iOS 13.0, *)) {
        sec.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    
    sec.delegate = self;
    sec.transitioningDelegate = self;
    [self.swipeUpInteractiveTransition writeToViewController:sec];
    [self presentViewController:sec animated:YES completion:nil];
}

- (IBAction)presentButtonPressed:(id)sender {
    SecondViewController *sec = [[UIStoryboard storyboardWithName:@"Second" bundle:nil] instantiateViewControllerWithIdentifier:@"SecondViewController"];
    
    if (@available(iOS 13.0, *)) {
        sec.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    sec.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    sec.delegate = self;
    [self presentViewController:sec animated:YES completion:nil];
}

#pragma mark - Second View Controller Delegate

-(void)secondViewControllerDidClickedDismissButton:(SecondViewController *)secondViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)passDataToMainController:(NSString *)passData {
    _data = passData;
    NSLog(@"😎 Passing Data From Second View Controller : %@",self.data);
}

#pragma mark - UIViewControllerTransitioningDelegate Delegate

//- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
//    return self.secondPresentAnimation;
//}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self.nornalDismissAnimation;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    NSLog(@"Swipe delegate");
    return self.swipeUpInteractiveTransition.interacting ? self.swipeUpInteractiveTransition: nil;
}


@end
