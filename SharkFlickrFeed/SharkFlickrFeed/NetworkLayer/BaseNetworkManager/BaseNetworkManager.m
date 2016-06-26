//
//  BaseNetworkManager.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/25/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "BaseNetworkManager.h"
#import "NSError+Utility.h"
#import "GlobalLocalizations.h"
#import "NSString+Utility.h"

static NSString *const ServerTopLevelErrorMessageKey = @"error";
static NSString *const BaseServerURLString = @"https://api.flickr.com/services/rest";

@interface BaseNetworkManager ()

@property (strong, nonatomic, readwrite) AFHTTPSessionManager *sessionManager;

@end

@implementation BaseNetworkManager

#pragma mark - Init

+ (BaseNetworkManager *)shared {
    static BaseNetworkManager *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [BaseNetworkManager new];
    });
    return shared;
}

#pragma mark - Accessors

- (AFHTTPSessionManager *)sessionManager
{
    if (!_sessionManager)
    {
        NSURL *baseURL = [NSURL URLWithString:BaseServerURLString];
        
        _sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        _sessionManager.requestSerializer = [AFJSONRequestSerializer new];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer new];
        _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        [_sessionManager.reachabilityManager startMonitoring];
    }
    
    return _sessionManager;
}

#pragma mark - Tasks

- (DataTaskErrorHandler)taskErrorHandlerWithDefaultHandler:(DefaultErrorHandler)defaultErrorHandler {
    
    __weak typeof(self) weakSelf = self;
    
    DataTaskErrorHandler errorHandler = ^(NSURLSessionDataTask *task, NSError *error){
        
        [weakSelf handleError:error httpURLResponse:(NSHTTPURLResponse *)task.response withDefaultErrorHandler:defaultErrorHandler];
    };
    
    return errorHandler;
}

- (DataTaskSuccessHandler)taskSuccessHandlerWithDefaultHandler:(DefaultSuccessHandler)defaultSuccessHandler {
    
    DataTaskSuccessHandler successHandler =^(NSURLSessionDataTask *task, id responseObject) {
        if (defaultSuccessHandler) {
            defaultSuccessHandler();
        }
    };
    
    return successHandler;
}

- (UploadTaskCompletionHandler)uploadTaskCompletionHandlerWithSuccessHandler:(void(^)(id))successHandler
                                                         defaultErrorHandler:(DefaultErrorHandler)defaultErrorHandler {
    
    __weak typeof(self) weakSelf = self;
    
    UploadTaskCompletionHandler completionHandler = ^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            [weakSelf handleError:error httpURLResponse:(NSHTTPURLResponse *)response withDefaultErrorHandler:defaultErrorHandler];
        } else {
            if (successHandler) {
                successHandler(responseObject);
            }
        }
    };
    
    return completionHandler;
}

- (void)handleError:(NSError *)error httpURLResponse:(NSHTTPURLResponse *)response withDefaultErrorHandler:(DefaultErrorHandler)defaultErrorHandler {
    
    DefaultErrorHandler InvokeErrorHandlerBlock = ^(NSString *localizedErrorMessage) {
        if (defaultErrorHandler) {
            defaultErrorHandler(localizedErrorMessage);
        }
    };
    
    //KS: TODO - add more custom error handling here
    NSString *localizedErrorMessage = [self.class localizedErrorMessageForResponse:response error:error];
    InvokeErrorHandlerBlock(localizedErrorMessage);
}


#pragma mark - Error Handling

+ (NSString *)localizedErrorMessageForError:(NSError *)error {
    return [self localizedErrorMessageForResponse:nil error:error];
}

- (NSString *)localizedErrorMessageForError:(NSError *)error {
    
    return [self.class localizedErrorMessageForError:error];
}

+ (NSString *)localizedErrorMessageForResponse:(NSHTTPURLResponse *)response error:(NSError *)error {
    
    //KS: detect error by error domain
    if (error) {
        if ([error.domain isEqualToString:NSURLErrorDomain]) {
            if (error.code == NSURLErrorNetworkConnectionLost) {
                return [GlobalLocalizations localizedGlobalConnectionLost];
            } else if (error.code == NSURLErrorNotConnectedToInternet) {
                return [GlobalLocalizations localizedGlobalNoInternet];
            }
        } else if ([error.domain isEqualToString:[NSError sh_customErrorDomain]]) {
            return [error sh_errorTitle];
        } else if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
            NSDictionary *serializedData = [NSJSONSerialization JSONObjectWithData:errorData options:kNilOptions error:nil];
            if (serializedData && [serializedData isKindOfClass:[NSDictionary class]]) {
                NSString *errorMessage = serializedData[ServerTopLevelErrorMessageKey];
                if (errorMessage) {
                    return errorMessage;
                }
            }
        }
    }
    
    //KS: error handling by http status code
    if (response) {
        NSInteger httpStatusCode = response.statusCode;
        
        if ((httpStatusCode >=400 && httpStatusCode <= 500)) {
            return [GlobalLocalizations localizedGlobalErrorHasOccurredPleaseTryAgain];
        }
        
        //KS: Add more custom status codes here
        //KS: https://www.flickr.com/services/api/flickr.photos.search.html
    }
    
    //KS: can't define the exact error. Return default error message.
    return [GlobalLocalizations localizedGlobalErrorHasOccurredPleaseTryAgain];
}

- (NSString *)getFullURLWithRelativeURL:(NSString *)relativeURLString {
    if ([NSString sh_isNilOrEmptyString:relativeURLString]) {
        return nil;
    }
    
    return [NSString stringWithFormat:@"%@%@", self.sessionManager.baseURL, relativeURLString];
}



@end
