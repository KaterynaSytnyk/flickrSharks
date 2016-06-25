//
//  FlickrNetworkManager.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "FlickrNetworkManager.h"
#import "ParsingManager.h"

static NSString *const FlickrAPIKey = @"949e98778755d1982f537d56236bbb42";
static NSString *const AcronymSearchResource = @"dictionary.py";


@interface FlickrNetworkManager ()

@property (nonatomic, strong) NSURLSession *session;

@end


@implementation FlickrNetworkManager

#pragma mark - Inits

+ (instancetype)sharedManager {
    static FlickrNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [FlickrNetworkManager new];
       // [sharedManager setupSession];
    });
    return sharedManager;
}

- (void)setupSession {
    // create session, setup self as delegate for downloads
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.allowsCellularAccess = NO;
    
    //        NSURL *baseURL = [NSURL URLWithString:BaseServerURLString];
    //        sharedManager.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    //        sharedManager.sessionManager.requestSerializer = [AFJSONRequestSerializer new];
    //        sharedManager.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    
//    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//    configuration.allowsCellularAccess = false
//    configuration.URLCache?.diskCapacity
//    configuration.URLCache?.memoryCapacity
//    let smallCache = NSURLCache(memoryCapacity: 512000, diskCapacity: 2000000, diskPath: nil)
//    configuration.URLCache = smallCache
//    configuration.URLCache?.diskCapacity
//    configuration.URLCache?.memoryCapacity
//    let session = NSURLSession(configuration: configuration)
    
   // self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];

}

#pragma mark - Network Calls

- (void)getSharkPhotosWithSuccessHandler:(SharkPhotosFeedSuccessHandler)successHandler
                            errorHandler:(DefaultErrorHandler)errorHandler {
    
}

//- (void)searchAcronymMeaningsWithAcronym:(Acronym *)acronym
//                          successHandler:(AcronymMeaningSearchSuccessHandler)successHandler
//                            errorHandler:(DefaultErrorHandler)errorHandler {
//    
//        if ([NSString ac_isNilOrEmptyString:acronym.acronymString]) {
//            if (errorHandler) {
//                errorHandler(self.localizedAcronymSearchErrorMessage);
//            }
//        }
//    
//        NSDictionary *params = [[ParsingManager sharedManager] dictionaryContainingInfoForAcronymSearch:acronym];
//    
//        __weak typeof(self) weakSelf = self;
//    
//        [self.sessionManager GET:AcronymSearchResource parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//    
//            NSArray *serializedData = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
//            id serializedFirstObject = serializedData.firstObject;
//    
//            if (![serializedFirstObject isKindOfClass:[NSDictionary class]]) {
//                if (errorHandler) {
//                    errorHandler(weakSelf.localizedAcronymSearchNoResultsMessage);
//                }
//                return;
//            }
//    
//            NSArray *acronymMeanings = [[ParsingManager sharedManager] acronymMeaningsArrayFromDictionary:serializedFirstObject];
//    
//            if (!acronymMeanings) {
//                if (errorHandler) {
//                    errorHandler(weakSelf.localizedAcronymSearchNoResultsMessage);
//                }
//                return;
//            }
//    
//            if (successHandler) {
//                successHandler(acronymMeanings);
//            }
//    
//        } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
//            NSLog(@"Failed network call for acronym meanings search: %@", error.localizedDescription);
//            
//            if (errorHandler) {
//                errorHandler(weakSelf.localizedAcronymSearchErrorMessage);
//            }
//        }];
//}

@end
