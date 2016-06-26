//
//  ParsingManager.h
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SharkPhoto;

@interface ParsingManager : NSObject

+ (instancetype)sharedManager;

- (NSDictionary *)dictionaryForSharkFeedSearchWithPage:(NSInteger)page;
- (NSArray *)sharkPhotosArrayFromDictionary:(NSDictionary *)sharkPhotosListDictionary;

@end
