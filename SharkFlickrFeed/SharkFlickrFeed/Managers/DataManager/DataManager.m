//
//  DataManager.m
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import "DataManager.h"
#import "NSString+Utility.h"
#import "ParsingManager.h"


//KS: sample request: http://www.nactem.ac.uk/software/acromine/dictionary.py?sf=FBI

static NSString *const BaseServerURLString = @"http://www.nactem.ac.uk/software/acromine";
static NSString *const AcronymSearchResource = @"dictionary.py";

@interface DataManager ()

//@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
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
        
//        NSURL *baseURL = [NSURL URLWithString:BaseServerURLString];
//        sharedManager.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
//        sharedManager.sessionManager.requestSerializer = [AFJSONRequestSerializer new];
//        sharedManager.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [sharedManager localizeStrings];
    });
    return sharedManager;
}

#pragma mark - Setup

- (void)localizeStrings {
    self.localizedAcronymSearchErrorMessage = NSLocalizedString(@"Acronym search failed. Please try again.", @"Error message for the case when acronym meanings search fails.");
    self.localizedAcronymSearchNoResultsMessage = NSLocalizedString(@"Acronym search returned no results. Please try again.", @"Error message for the case when acronym meanings search returned no results.");
}

#pragma mark - Data

- (void)searchAcronymMeaningsWithAcronym:(Acronym *)acronym
                          successHandler:(AcronymMeaningSearchSuccessHandler)successHandler
                            errorHandler:(DefaultErrorHandler)errorHandler {
    
//    if ([NSString ac_isNilOrEmptyString:acronym.acronymString]) {
//        if (errorHandler) {
//            errorHandler(self.localizedAcronymSearchErrorMessage);
//        }
//    }
//    
//    NSDictionary *params = [[ParsingManager sharedManager] dictionaryContainingInfoForAcronymSearch:acronym];
//    
//    __weak typeof(self) weakSelf = self;
//    
//    [self.sessionManager GET:AcronymSearchResource parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        
//        NSArray *serializedData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//        id serializedFirstObject = serializedData.firstObject;
//        
//        if (![serializedFirstObject isKindOfClass:[NSDictionary class]]) {
//            if (errorHandler) {
//                errorHandler(weakSelf.localizedAcronymSearchNoResultsMessage);
//            }
//            return;
//        }
//        
//        NSArray *acronymMeanings = [[ParsingManager sharedManager] acronymMeaningsArrayFromDictionary:serializedFirstObject];
//        
//        if (!acronymMeanings) {
//            if (errorHandler) {
//                errorHandler(weakSelf.localizedAcronymSearchNoResultsMessage);
//            }
//            return;
//        }
//        
//        if (successHandler) {
//            successHandler(acronymMeanings);
//        }
//        
//    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//        NSLog(@"Failed network call for acronym meanings search: %@", error.localizedDescription);
//        
//        if (errorHandler) {
//            errorHandler(weakSelf.localizedAcronymSearchErrorMessage);
//        }
//    }];
}

@end
