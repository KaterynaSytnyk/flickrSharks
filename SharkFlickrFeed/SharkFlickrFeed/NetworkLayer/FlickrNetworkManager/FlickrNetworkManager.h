//
//  FlickrNetworkManager.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseNetworkManager.h"

@interface FlickrNetworkManager : BaseNetworkManager

+ (instancetype)sharedManager;

- (void)getSharkPhotosWithSuccessHandler:(SharkPhotosFeedSuccessHandler)successHandler
                            errorHandler:(DefaultErrorHandler)errorHandler;

@end
