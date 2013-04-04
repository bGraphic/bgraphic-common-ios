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
    
    return backgroundView;
}

@end
