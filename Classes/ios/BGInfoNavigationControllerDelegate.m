//
//  BGInfoNavigationControllerDelegate.m
//  Lilly Poison
//
//  Created by Benedicte Raae on 04.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "BGInfoNavigationControllerDelegate.h"
#import "BGInfoViewController.h"

@implementation BGInfoNavigationControllerDelegate

- (id) init
{
    self = [super init];
    if(self)
    {
        self.infoDict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"InfoPage" ofType:@"plist"]];
    }
    
    return self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    [infoButton addTarget:self action:@selector(infoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
}

- (void)infoButtonAction: (id)sender  {
    
    UINavigationController *infoViewController = [BGInfoViewController infoViewInNavigationControllerWithDict:self.infoDict];
    
    UIButton *infoButton = (UIButton *) sender;
    
    [infoButton.window.rootViewController presentViewController:infoViewController animated:YES completion:nil];
}

@end
