//
//  NSString+Utility.m
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

- (NSString *)sh_trimmedOfWhitespace {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+ (BOOL)sh_isNilOrEmptyString:(NSString *)string {
    if (!string || ![string isKindOfClass:[NSString class]] || [string isKindOfClass:[NSNull class]] || [string sh_trimmedOfWhitespace].length == 0)
        return YES;
    
    return NO;
}


@end
