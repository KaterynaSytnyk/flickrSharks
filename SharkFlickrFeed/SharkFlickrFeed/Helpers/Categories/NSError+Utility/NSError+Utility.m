//
//  NSError+Utility.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/25/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "NSError+Utility.h"

static NSString *const SHErrorLocalizedTitleKey = @"SHErrorLocalizedTitleKey";

@implementation NSError (Utility)


+ (NSError *)sh_createCustomDomainErrorWithCode:(NSUInteger)code andTitle:(NSString *)title andDescription:(NSString *)description withFailureReason:(NSString *)failureReason andRecoverySuggestion:(NSString *)recovery {
    NSDictionary *userInfo = @{
                               SHErrorLocalizedTitleKey: NSLocalizedString(title, @"Error message title"),
                               NSLocalizedDescriptionKey: NSLocalizedString(description, nil),
                               NSLocalizedFailureReasonErrorKey: NSLocalizedString(failureReason, nil),
                               NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString(recovery, nil)
                               };
    return [NSError errorWithDomain:self.sh_customErrorDomain code:code userInfo:userInfo];
}


+ (NSError *)sh_createCustomDomainErrorWithTitle:(NSString *)title andDescription:(NSString *)description {
    NSDictionary *userInfo = @{
                               SHErrorLocalizedTitleKey: NSLocalizedString(title, @"Error message title"),
                               NSLocalizedDescriptionKey: NSLocalizedString(description, nil)
                               };
    return [NSError errorWithDomain:self.sh_customErrorDomain code:-100 userInfo:userInfo];
}


+ (NSString *)sh_customErrorDomain {
    return [[NSBundle mainBundle] bundleIdentifier];
}

- (NSString *)sh_errorTitle {
    if (![self.domain isEqualToString:[NSError sh_customErrorDomain]]) {
        return nil;
    }
    
    return (self.userInfo)[SHErrorLocalizedTitleKey];
}

- (NSString *)sh_errorDescription {
    return (self.userInfo)[NSLocalizedDescriptionKey];
}

@end
