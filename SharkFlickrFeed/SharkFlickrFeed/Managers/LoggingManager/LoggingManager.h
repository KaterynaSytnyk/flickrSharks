//
//  LoggingManager.h
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoggingManager : NSObject

+ (instancetype)sharedManager;
- (void)startLogging;

@end
