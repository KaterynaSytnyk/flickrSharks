//
//  ImageNetworkManager.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/26/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "ImageNetworkManager.h"




@implementation ImageNetworkManager

#pragma mark - Init

+ (ImageNetworkManager *)shared {
    static ImageNetworkManager *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [ImageNetworkManager new];
    });
    return shared;
}


- (void)loadImageWithURL:(NSString *)imageURL
          successHandler:(ImageLoadSuccessHandler)successHandler
            errorHandler:(DefaultErrorHandler)errorHandler {
    
   NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:imageURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            if (errorHandler) {
                errorHandler (@"Image Download Failed");
            }
        } else {
            UIImage *image = [UIImage imageWithData:data];
            if (image) {
                    if (successHandler) {
                        successHandler(image);
                    }
            } else {
                if (errorHandler) {
                    errorHandler(@"Couldn't create image from data");
                }
            }
        }
    }];
    
    [dataTask resume];
}


@end
