//
//  NSString+Utility.m
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

- (NSString *)ac_trimmedOfWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+ (BOOL)ac_isNilOrEmptyString:(NSString *)string {
    if (!string || ![string isKindOfClass:[NSString class]] || [string isKindOfClass:[NSNull class]] || [string ac_trimmedOfWhitespace].length == 0)
        return YES;
    
    return NO;
}


@end
