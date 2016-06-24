//
//  NSString+Utility.h
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

/** KS
 *	Trims an existing NSString of whitespace.
 *
 *	@return	NSString trimmed of whitespace.
 */
- (NSString *)ac_trimmedOfWhitespace;


/** KS
 *	Returns a BOOL indicating if a string is empty or nil
 *
 *	@return	flag indicating if the current string is empty (i.e. contains no chars, or only contains whitespace)
 */
+ (BOOL)ac_isNilOrEmptyString:(NSString*)string;

@end
