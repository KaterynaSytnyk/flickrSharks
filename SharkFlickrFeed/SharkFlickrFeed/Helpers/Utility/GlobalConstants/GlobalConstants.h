//
//  GlobalConstants.h
//  AcronymList
//
//  Created by Kateryna Sytnyk on 12/16/15.
//  Copyright © 2015 KaterynaSytnyk. All rights reserved.
//

#ifndef GlobalConstants_h
#define GlobalConstants_h

#import <UIKit/UIKit.h>

typedef void(^DefaultCompletionBlock)(void);
typedef void(^DefaultSuccessHandler)(void);
typedef void(^DefaultErrorHandler)(NSString *localizedErrorMessage);
typedef void(^ImageLoadSuccessHandler)(UIImage *image);
typedef void(^SharkPhotosFeedSuccessHandler)(NSArray *sharkPhotos);

#endif /* GlobalConstants_h */
