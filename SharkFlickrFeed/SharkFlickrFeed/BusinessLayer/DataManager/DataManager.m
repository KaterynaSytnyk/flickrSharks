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
#import "ImageCacheManager.h"
#import "SharkPhoto.h"
#import "ImageNetworkManager.h"

@interface DataManager ()

@property (copy, nonatomic) NSString *localizedPhotoSearchErrorMessage;
@property (copy, nonatomic) NSString *localizedPhotoSearchNoResultsMessage;

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
    self.localizedPhotoSearchErrorMessage = NSLocalizedString(@"Photo search failed. Please try again.", @"Error message for the case when photo search fails.");
    self.localizedPhotoSearchNoResultsMessage = NSLocalizedString(@"Photo search returned no results. Please try again.", @"Error message for the case when photo search returned no results.");
}

#pragma mark - Data methods

- (void)getSharkPhotosWithSuccessHandler:(SharkPhotosFeedSuccessHandler)successHandler
                            errorHandler:(DefaultErrorHandler)errorHandler {
    
    [[FlickrNetworkManager sharedManager] getSharkPhotosWithSuccessHandler:successHandler errorHandler:errorHandler];
    
}

- (void)loadSharkPhotoDetails:(SharkPhoto *)sharkPhoto
           withSuccessHandler:(DefaultSuccessHandler)successHandler
                 errorHandler:(DefaultErrorHandler)errorHandler {
 
    //KS: TODO - call network to get full photo details including user, tags, etc
}

- (void)loadImageForSharkPhoto:(SharkPhoto *)sharkPhoto
                successHandler:(ImageLoadSuccessHandler)successHandler
                  errorHandler:(DefaultErrorHandler)errorHandler {
    
    NSString *imageURLString = sharkPhoto.thumbnailImageURL;
    
    if ([NSString sh_isNilOrEmptyString:imageURLString]) {
        if (errorHandler) {
            errorHandler(@"No thumbnail URL");
        }
        return;
    }
    
    //KS: Check if this image is already saved in Cache - if it is - return righ away and don't trigger a network call
    UIImage *cachedImage = [[ImageCacheManager sharedManager] getCachedImageForKey:imageURLString];
    if (cachedImage) {
        sharkPhoto.thumbnail = cachedImage;
        if (successHandler) {
            successHandler(cachedImage);
        }
    } else {
        //KS: load the image from the network
        [[ImageNetworkManager shared] loadImageWithURL:imageURLString
                                        successHandler:^(UIImage *image) {
                                            [[ImageCacheManager sharedManager] cacheImage:image forKey:imageURLString];
                                            
                                            sharkPhoto.thumbnail = image;
                                            sharkPhoto.largeImage = image;
                                            
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if (successHandler) {
                                                    successHandler(image);
                                                }
                                            });
                                            
                                        } errorHandler:^(NSString *localizedErrorMessage) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if (errorHandler) {
                                                    errorHandler(@"Image download failed");
                                                }
                                            });
                                        }];
    }
    
}


@end
