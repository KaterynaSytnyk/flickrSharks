//
//  ParsingManager.h
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SharkPhoto;
@class Acronym;

@interface ParsingManager : NSObject

+ (instancetype)sharedManager;

- (NSDictionary *)dictionaryContainingInfoForAcronymSearch:(Acronym *)acronym;

- (NSArray *)acronymMeaningsArrayFromDictionary:(NSDictionary *)acronymMeaningsListDictionary;


@end
