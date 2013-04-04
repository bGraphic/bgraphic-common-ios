//
//  BGInfoViewController.m
//  bGraphicInfoPage
//
//  Created by Benedicte Raae on 04.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "BGInfoViewController.h"
#import "TestFlight.h"

@interface BGInfoViewController ()
-(BOOL)openUrl:(NSString *)urlString;
@end

@implementation BGInfoViewController

@synthesize infoDict = _infoDict;
@synthesize infoText = _infoText;
@synthesize rateAppButton = _rateAppButton;
@synthesize shareButton = _shareButton;
@synthesize supportButton = _supportButton;
@synthesize moreAppsButton = _moreAppsButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setRateAppButton:nil];
    [self setShareButton:nil];
    [self setSupportButton:nil];
    [self setMoreAppsButton:nil];
    [self setInfoText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationIsPortrait(interfaceOrientation));
}

- (void) setInfoDict:(NSDictionary *)infoDict
{
    if(infoDict)
        _infoDict = infoDict;
    
//    [self.infoText setText:NSLocalizedStringFromTable(@"info_text", @"Localizable-info", nil)];
//    
//    [self.rateAppButton setTitle:NSLocalizedString(@"rate_app", nil) forState:UIControlStateNormal];
//    [self.shareButton setTitle:NSLocalizedString(@"share_app", nil) forState:UIControlStateNormal];
//    [self.supportButton setTitle:NSLocalizedString(@"support", nil) forState:UIControlStateNormal];
//    [self.moreAppsButton setTitle:NSLocalizedString(@"more_apps", nil) forState:UIControlStateNormal];
}

- (IBAction)rateAppAction:(id)sender {
    NSString *rateAppUrl = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@", [self.infoDict objectForKey:@"app_id"]];
    
    [TestFlight passCheckpoint:@"RATE"];
    
    [self openUrl:rateAppUrl];
}

- (IBAction)shareAction:(id)sender {
    NSString *shareAppUrl = [NSString stringWithFormat:@"http://itunes.apple.com/app/id%@", [self.infoDict objectForKey:@"app_id"]];
    NSString *body = [NSString stringWithFormat:NSLocalizedString(@"share_mail_body", nil), shareAppUrl];
    
    [self sendMailTo:nil withTitle:NSLocalizedString(@"share_mail_title", nil) andBody:body];
}

- (IBAction)supportAction:(id)sender {
    [self sendMailTo:[self.infoDict objectForKey:@"support_mail"] withTitle:NSLocalizedString(@"support_mail_title", nil) andBody:nil];
}

- (IBAction)blogAction:(id)sender {
    [TestFlight passCheckpoint:@"BLOG"];
    
    [self openUrl:[self.infoDict objectForKey:@"blog_link"]];
}

- (IBAction)moreAppsAction:(id)sender {
    [TestFlight passCheckpoint:@"MORE APPS"];
    
    NSString *moreAppsUrl
    = [NSString stringWithFormat:@"itms-apps://itunes.com/apps/%@", [self.infoDict objectForKey:@"store_id"]];
    
    [self openUrl:moreAppsUrl];
}

- (IBAction)twitterAction:(id)sender {
    NSString *twitterUrl = [NSString stringWithFormat:@"twitter:///user?screen_name=%@", [self.infoDict objectForKey:@"twitter_user"]];
    
    [TestFlight passCheckpoint:@"TWITTER"];
    
    if(![self openUrl:twitterUrl]) {
        twitterUrl = [NSString stringWithFormat:@"http://twitter.com/%@", [self.infoDict objectForKey:@"twitter_user"]];
        [self openUrl:twitterUrl];
    }
}

- (IBAction)closeInfoAction:(id)sender {
    [self dismissModalViewControllerAnimated:TRUE];
}

-(BOOL)openUrl:(NSString *)urlString {
    if(!urlString)
        return false;
    
    UIApplication *appDelegate = [UIApplication sharedApplication];
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    if ([appDelegate openURL:url]) {
        return true;
    } else {
        return false;
    }
}

-(void)sendMailTo:(NSString *)recipient withTitle:(NSString *)title andBody:(NSString *)body  {
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	
    picker.mailComposeDelegate = self;
    
    if(recipient != nil) {
        [picker setToRecipients:[[NSArray alloc] initWithObjects:recipient, nil]];
    }
    
    if(title != nil) {
        [picker setSubject:title];
    }
    
    if(body != nil) {
    	[picker setMessageBody:body isHTML:YES];
    }
	
	
	[self presentViewController:picker animated:true completion:^{
        if(![recipient isEqualToString:[self.infoDict objectForKey:@"support_mail"]]) {
            [TestFlight passCheckpoint:@"SHARED"];
        }
    }];
    
    picker = nil;
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"e-mail_error_alert_title", nil) message:NSLocalizedString(@"e-mail_error_alert_message", nil) delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
            [controller dismissModalViewControllerAnimated:YES];
			break;
		case MFMailComposeResultSaved:
            [controller dismissModalViewControllerAnimated:YES];
			break;
		case MFMailComposeResultSent:
            [controller dismissModalViewControllerAnimated:YES];
			break;
		default:
            [alert show];
			break;
	}
    
}

+ (BGInfoViewController *) infoViewWithDict:(NSDictionary *) infoDict
{
    BGInfoViewController *infoViewController = [[BGInfoViewController alloc] initWithNibName:@"BGInfoViewController" bundle:[NSBundle mainBundle]];

    infoViewController.infoDict = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"InfoPage" ofType:@"plist"]];
    
    return infoViewController;
}


@end
