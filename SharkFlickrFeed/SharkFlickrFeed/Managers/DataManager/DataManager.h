//
//  DataManager.h
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalConstants.h"

@class SharkPhoto;

@interface DataManager : NSObject

+ (instancetype)sharedManager;

//KS: returns an array of AcronymMeanings from Acronym supplied
//- (void)searchAcronymMeaningsWithAcronym:(Acronym *)acronym
//                          successHandler:(AcronymMeaningSearchSuccessHandler)successHandler
//                            errorHandler:(DefaultErrorHandler)errorHandler;

@end
