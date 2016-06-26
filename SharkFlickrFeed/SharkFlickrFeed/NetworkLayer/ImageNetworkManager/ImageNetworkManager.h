//
//  ImageNetworkManager.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/26/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "BaseNetworkManager.h"

@interface ImageNetworkManager : BaseNetworkManager

+ (ImageNetworkManager *)shared;

- (void)loadImageWithURL:(NSString *)imageURL
          successHandler:(ImageLoadSuccessHandler)successHandler
            errorHandler:(DefaultErrorHandler)errorHandler;

@end
