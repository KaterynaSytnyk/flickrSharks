//
//  DataManager.m
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import "DataManager.h"
#import "NSString+Utility.h"
#import "FlickrNetworkManager.h"

@interface DataManager ()

@property (copy, nonatomic) NSString *localizedAcronymSearchErrorMessage;
@property (copy, nonatomic) NSString *localizedAcronymSearchNoResultsMessage;

@end

@implementation DataManager

#pragma mark - Inits

+ (instancetype)sharedManager {
    static DataManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [DataManager new];
        
        [sharedManager localizeStrings];
    });
    return sharedManager;
}

#pragma mark - Setup

- (void)localizeStrings {
    self.localizedAcronymSearchErrorMessage = NSLocalizedString(@"Acronym search failed. Please try again.", @"Error message for the case when acronym meanings search fails.");
    self.localizedAcronymSearchNoResultsMessage = NSLocalizedString(@"Acronym search returned no results. Please try again.", @"Error message for the case when acronym meanings search returned no results.");
}

#pragma mark - Data methods

//KS: returns an array of SharkPhotos
- (void)getSharkPhotosWithSuccessHandler:(SharkPhotosFeedSuccessHandler)successHandler
                            errorHandler:(DefaultErrorHandler)errorHandler {
    
}


@end
