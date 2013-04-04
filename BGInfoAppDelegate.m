//
//  BGAppDelegate.m
//  bGraphicInfoPage
//
//  Created by Benedicte Raae on 04.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "BGInfoAppDelegate.h"
#import "BGInfoViewController.h"

@implementation BGInfoAppDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    //    UIBarButtonItem *infoButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    infoButton.contentEdgeInsets = (UIEdgeInsets){.right=10, .left=-10};
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
}

- (void)infoButtonAction {
    NSDictionary *infoDict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"InfoPage" ofType:@"plist"]];
    
    BGInfoViewController *infoViewController = [BGInfoViewController infoViewWithDict:infoDict];
    
    [self.window.rootViewController presentViewController:infoViewController animated:YES completion:nil];
}

@end
