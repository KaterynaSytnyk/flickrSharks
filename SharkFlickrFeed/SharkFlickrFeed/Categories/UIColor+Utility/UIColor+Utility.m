//
//  UIColor+Utility.m
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

#pragma mark - Custom Colors

+ (UIColor *)ac_indigo {
    static UIColor *ac_indigo;
    
    if (!ac_indigo) {
        ac_indigo = [UIColor ac_colorWithHex:0x381c66];
    }
    
    return ac_indigo;
}

+ (UIColor *)ac_gray {
    static UIColor *ac_gray;
    
    if (!ac_gray) {
        ac_gray = [UIColor ac_colorWithHex:0xbcbec0];
    }
    
    return ac_gray;
}


+ (UIColor *)ac_darkGreen {
    static UIColor *ac_darkGreen;
    
    if (!ac_darkGreen) {
        ac_darkGreen = [UIColor ac_colorWithHex:0x419442];
    }
    
    return ac_darkGreen;
}


+ (UIColor *)ac_lightGreen {
    static UIColor *ac_lightGreen;
    
    if (!ac_lightGreen) {
        ac_lightGreen = [UIColor ac_colorWithHex:0x72df00];
    }
    
    return ac_lightGreen;
}


+ (UIColor *)ac_cyan {
    static UIColor *ac_cyan;
    
    if (!ac_cyan) {
        ac_cyan = [UIColor ac_colorWithHex:0x27c1d5];
    }
    
    return ac_cyan;
}


+ (UIColor *)ac_violet {
    static UIColor *ac_violet;
    
    if (!ac_violet) {
        ac_violet = [UIColor ac_colorWithHex:0x9135b8];
    }
    
    return ac_violet;
}


+ (UIColor *)ac_blue {
    static UIColor *ac_blue;
    
    if (!ac_blue) {
        ac_blue = [UIColor ac_colorWithHex:0x6866e9];
    }
    
    return ac_blue;
}

+ (UIColor *)ac_white {
    return [UIColor whiteColor];
}

+ (UIColor *)ac_lightGrayColor {
    return [self ac_colorWithIntegerRed:211 green:211 andBlue:211];
}

+ (UIColor *)ac_lightGrayColorDisabled {
    return [self ac_colorWithIntegerRed:204 green:204 andBlue:204];
}


+ (UIColor *)ac_red {
    return [UIColor redColor];
}

+ (UIColor *)ac_darkViolet {
    return [self ac_colorWithIntegerRed:56 green:28 andBlue:102];
}

#pragma mark - Color Utility Methods

+ (UIColor *)ac_colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue {
    return [[UIColor alloc] initWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0
                                  green:((float)((hexValue & 0xFF00) >> 8)) / 255.0
                                   blue:((float)(hexValue & 0xFF)) / 255.0
                                  alpha:alphaValue];
}


+ (UIColor *)ac_colorWithHex:(NSInteger)hexValue {
    return [UIColor ac_colorWithHex:hexValue alpha:1.0];
}


+ (UIColor *)ac_colorWithIntegerRed:(NSInteger)redValue
                              green:(NSInteger)greenValue
                               blue:(NSInteger)blueValue
                           andAlpha:(CGFloat)alpha {
    return [[UIColor alloc] initWithRed:((float)(redValue / 255.0))
                                  green:((float)(greenValue / 255.0))
                                   blue:((float)(blueValue / 255.0))
                                  alpha:alpha];
}


+ (UIColor *)ac_colorWithIntegerRed:(NSInteger)redValue
                              green:(NSInteger)greenValue
                            andBlue:(NSInteger)blueValue {
    return [self ac_colorWithIntegerRed:redValue
                                  green:greenValue
                                   blue:blueValue
                               andAlpha:1.0];
}


@end
