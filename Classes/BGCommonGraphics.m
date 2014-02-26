//
//  BGCommonGraphics.m
//  bGraphicCommonStuff
//
//  Created by Benedicte Raae on 04.04.13.
//  Copyright (c) 2013 bGraphic. All rights reserved.
//

#import "BGCommonGraphics.h"

static NSString * const kBGBackgroundImage = @"BG-background.png";

@implementation BGCommonGraphics

+ (UIImageView *) backgroundView;
{
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kBGBackgroundImage]];
    backgroundView.alpha = 0.6;
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    
    return backgroundView;
}

+ (void) addBackgroundToView:(UIView *) view
{
    UIView *backgroundView = [BGCommonGraphics backgroundView];
    
    // if ios7 or later, offset the background by the height of the status bar
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7
    CGFloat offset = [UIApplication sharedApplication].statusBarFrame.size.height;
    backgroundView.frame = CGRectMake(view.bounds.origin.x, view.bounds.origin.y + offset, view.bounds.size.width, view.bounds.size.height - offset);
#else
    backgroundView.frame = view.bounds;
#endif
    
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;

    [view insertSubview:backgroundView atIndex:0];
}

@end
