//
//  SecondViewController.m
//  viewControllerTransitionDemo
//
//  Created by 顏逸修 on 2023/4/22.
//

#import "SecondViewController.h"

@interface SecondViewController ()
@property (strong, nonatomic) IBOutlet UIButton *goBackButton;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dismissButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [dismissButton setTitle:@"Dismiss Me" forState:UIControlStateNormal];
    dismissButton.backgroundColor = [UIColor blueColor];
    dismissButton.tintColor = [UIColor whiteColor];
    [dismissButton addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:dismissButton];
    
    // [self.view addSubview:_goBackButton];
    
    
    
}

- (IBAction)goBackButtonPressed:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(secondViewControllerDidClickedDismissButton:)]) {
        [self.delegate passDataToMainController:@"Data From Second VC!!"];
        [self.delegate secondViewControllerDidClickedDismissButton:self];
    }
}


- (void) dismissButtonPressed: (id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(secondViewControllerDidClickedDismissButton:)]) {
        [self.delegate passDataToMainController:@"Data From Second VC!!"];
        [self.delegate secondViewControllerDidClickedDismissButton:self];
    }
}





@end
