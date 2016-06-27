//
//  DataManager.h
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalConstants.h"
#import <UIKit/UIKit.h>

@class SharkPhoto;

@interface DataManager : NSObject

+ (instancetype)sharedManager;

//KS: returns an array of SharkPhotos
- (void)getSharkPhotosWithSuccessHandler:(SharkPhotosFeedSuccessHandler)successHandler
                            errorHandler:(DefaultErrorHandler)errorHandler;

//KS: updates SharkPhoto will full details
- (void)loadSharkPhotoDetails:(SharkPhoto *)sharkPhoto
           withSuccessHandler:(DefaultSuccessHandler)successHandler
                 errorHandler:(DefaultErrorHandler)errorHandler;

- (void)loadImageForSharkPhoto:(SharkPhoto *)sharkPhoto
          successHandler:(ImageLoadSuccessHandler)successHandler
            errorHandler:(DefaultErrorHandler)errorHandler;

//KS: TODO - instead of isLarge create an enum for photo sizes
- (void)loadImageForSharkPhoto:(SharkPhoto *)sharkPhoto
                       isLarge:(BOOL)isLarge
                successHandler:(ImageLoadSuccessHandler)successHandler
                  errorHandler:(DefaultErrorHandler)errorHandler;

@end
