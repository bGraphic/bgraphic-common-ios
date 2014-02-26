//
//  BGInfoViewController.h
//  bGraphicInfoPage
//
//  Created by Benedicte Raae on 04.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface BGInfoViewController : UIViewController <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSDictionary *infoDict;

@property (strong, nonatomic) IBOutlet UILabel *infoText;
@property (strong, nonatomic) IBOutlet UIButton *rateAppButton;
@property (strong, nonatomic) IBOutlet UIButton *shareButton;
@property (strong, nonatomic) IBOutlet UIButton *supportButton;
@property (strong, nonatomic) IBOutlet UIButton *moreAppsButton;

- (IBAction)rateAppAction:(id)sender;
- (IBAction)shareAction:(id)sender;
- (IBAction)supportAction:(id)sender;
- (IBAction)blogAction:(id)sender;
- (IBAction)moreAppsAction:(id)sender;
- (IBAction)twitterAction:(id)sender;

- (IBAction)closeInfoAction:(id)sender;


+ (BGInfoViewController *) infoViewWithDict:(NSDictionary *) infoDict;

@end
