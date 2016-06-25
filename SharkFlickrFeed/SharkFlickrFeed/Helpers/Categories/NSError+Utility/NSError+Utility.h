//
//  NSError+Utility.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/25/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSError (Utility)

/** KS:
 * Returns Custom Error domain
 */

+ (NSString *)sh_customErrorDomain;

/**
 *  Creates a custom error.
 *
 *  @param code          NUInteger denoting error code to use.
 *  @param title         NSString denoting error title to use.
 *  @param description   NSString describing the error (will be localized inside the method).
 *  @param failureReason NSString indicating reason for error (will be localized inside the method).
 *  @param recovery      NSString suggesting a recovery approach (will be localized inside the method).
 *
 *  @return NSError for use within the app.
 */
+ (NSError *)sh_createCustomDomainErrorWithCode:(NSUInteger)code
                                       andTitle:(NSString *)title
                                 andDescription:(NSString *)description
                              withFailureReason:(NSString *)failureReason
                          andRecoverySuggestion:(NSString *)recovery;


/**
 *  Creates a custom error - for simplified use
 *
 *  @param title         NSString denoting error title to use.
 *  @param description   NSString describing the error (will be localized inside the method).
 *
 *  @return NSError for use within the app.
 */
+ (NSError *)sh_createCustomDomainErrorWithTitle:(NSString *)title
                                  andDescription:(NSString *)description;

/**
 *  Returns Custom Error Title of the NSError (only if it's custom domain)
 */
- (NSString *)sh_errorTitle;


/**
 *  Returns Error Description of the NSError. It's just a shortcut for the description
 */
- (NSString *)sh_errorDescription;



@end
