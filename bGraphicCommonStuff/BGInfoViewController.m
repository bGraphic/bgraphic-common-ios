//
//  BGInfoViewController.m
//  bGraphicInfoPage
//
//  Created by Benedicte Raae on 04.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "BGInfoViewController.h"
#import "TestFlight.h"
#import "BGCommonGraphics.h"

static NSString * const kBGAppStoreID = @"522152533";
static NSString * const kBGtwitterHandler = @"bGraphic_apps";
static NSString * const kBGSupportMail = @"support@bgraphic.no";

static NSString * const kBGAppBaseUrl = @"http://itunes.apple.com/app/id%@";
static NSString * const kBGAppReviewBaseUrl = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@";
static NSString * const kBGDevAppStoreBaseUrl = @"itms-apps://ax.itunes.apple.com/artist/id%@";
static NSString * const kBGTwitterHttpBaseUrl = @"http://twitter.com/%@";
static NSString * const kBGTwitterAppBaserUrl = @"twitter:///user?screen_name=%@";

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
    
    [self.infoText setText:NSLocalizedString(@"info_text", nil)];
    
    [self.rateAppButton setTitle:NSLocalizedString(@"rate_app", nil) forState:UIControlStateNormal];
    [self.shareButton setTitle:NSLocalizedString(@"share_app", nil) forState:UIControlStateNormal];
    [self.supportButton setTitle:NSLocalizedString(@"support", nil) forState:UIControlStateNormal];
    [self.moreAppsButton setTitle:NSLocalizedString(@"more_apps", nil) forState:UIControlStateNormal];
    
    [BGCommonGraphics addBackgroundToView:self.view];
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
}

- (IBAction)rateAppAction:(id)sender {
    NSString *rateAppUrl = [NSString stringWithFormat:kBGAppReviewBaseUrl, [self.infoDict objectForKey:@"app_id"]];
    
    [TestFlight passCheckpoint:@"RATE"];
    
    [self openUrl:rateAppUrl];
}

- (IBAction)shareAction:(id)sender {
    NSString *shareAppUrl = [NSString stringWithFormat:kBGAppBaseUrl, [self.infoDict objectForKey:@"app_id"]];
    NSString *body = [NSString stringWithFormat:NSLocalizedString(@"share_mail_body", nil), shareAppUrl];
    
    [self sendMailTo:nil withTitle:NSLocalizedString(@"share_mail_title", nil) andBody:body];
}

- (IBAction)supportAction:(id)sender {
    [self sendMailTo:kBGSupportMail withTitle:NSLocalizedString(@"support_mail_title", nil) andBody:nil];
}

- (IBAction)blogAction:(id)sender {
    [TestFlight passCheckpoint:@"WEB"];
    
    [self openUrl:[self.infoDict objectForKey:@"web_link"]];
}

- (IBAction)moreAppsAction:(id)sender {
    [TestFlight passCheckpoint:@"MORE APPS"];
    
    NSString *moreAppsUrl
    = [NSString stringWithFormat:kBGDevAppStoreBaseUrl, kBGAppStoreID];
    
    [self openUrl:moreAppsUrl];
}

- (IBAction)twitterAction:(id)sender {
    NSString *twitterUrl = [NSString stringWithFormat:kBGTwitterHttpBaseUrl, kBGtwitterHandler];
    
    [TestFlight passCheckpoint:@"TWITTER"];
    
    if(![self openUrl:twitterUrl]) {
        twitterUrl = [NSString stringWithFormat:kBGTwitterAppBaserUrl, kBGtwitterHandler];
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
