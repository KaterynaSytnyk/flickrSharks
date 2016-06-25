//
//  UIFont+Utility.m
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import "UIFont+Utility.h"

static NSString *const ProximaNovaRegular = @"ProximaNova-Regular";
static NSString *const ProximaNovaBold = @"ProximaNova-Bold";


@implementation UIFont (Utility)

+ (UIFont *)sh_standardTextFont {
    return [UIFont fontWithName:ProximaNovaRegular size:14.0f];
}

+ (UIFont *)sh_searchFieldFont {
    return [UIFont fontWithName:ProximaNovaRegular size:20.f];
}


@end
