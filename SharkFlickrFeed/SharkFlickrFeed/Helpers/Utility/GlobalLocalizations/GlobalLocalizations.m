//
//  GlobalLocalizations.m
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import "GlobalLocalizations.h"

@implementation GlobalLocalizations


+ (NSString *)localizedGlobalSearch {
    return NSLocalizedString(@"Search", @"String for global use throughout the application, for a button that performs search.");
}

+ (NSString *)localizedGlobalConnectionLost {
    return NSLocalizedString(@"Connection lost", "Error message for internet operation");
}

+ (NSString *)localizedGlobalNoInternet {
    return NSLocalizedString(@"No internet connection available", "Error message for internet operation");
}

+ (NSString *)localizedGlobalErrorHasOccurredPleaseTryAgain {
    return NSLocalizedString(@"Oops, an unexpected error has occurred.", "Error message for internet operation");
}

+ (NSString *)localizedGlobalOk {
    return NSLocalizedString(@"Ok", @"String for global use throughout the application");
}


@end
