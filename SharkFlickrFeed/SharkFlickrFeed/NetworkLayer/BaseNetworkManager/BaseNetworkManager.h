//
//  BaseNetworkManager.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/25/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParsingManager.h"
#import "AFHTTPSessionManager.h"
#import "GlobalConstants.h"

typedef void(^DataTaskErrorHandler)(NSURLSessionDataTask *task, NSError *error);
typedef void(^DataTaskSuccessHandler)(NSURLSessionDataTask *task, id responseObject);
typedef void(^UploadTaskCompletionHandler)(NSURLResponse *response, id responseObject, NSError *error);
typedef void(^DownloadTaskCompletionHandler)(NSURLResponse *response, id responseObject, NSError *error);

@interface BaseNetworkManager : NSObject

@property (strong, nonatomic, readonly) AFHTTPSessionManager *sessionManager;

+ (BaseNetworkManager *)shared;

- (DataTaskErrorHandler)taskErrorHandlerWithDefaultHandler:(DefaultErrorHandler)defaultErrorHandler;
- (DataTaskSuccessHandler)taskSuccessHandlerWithDefaultHandler:(DefaultSuccessHandler)defaultSuccessHandler;
- (UploadTaskCompletionHandler)uploadTaskCompletionHandlerWithSuccessHandler:(void(^)(id))successHandler
                                                         defaultErrorHandler:(DefaultErrorHandler)defaultErrorHandler;

- (NSString *)localizedErrorMessageForError:(NSError *)error;
+ (NSString *)localizedErrorMessageForError:(NSError *)error;

- (NSString *)getFullURLWithRelativeURL:(NSString *)relativeURLString;

@end
