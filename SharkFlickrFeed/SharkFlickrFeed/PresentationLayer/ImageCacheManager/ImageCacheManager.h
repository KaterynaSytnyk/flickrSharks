//
//  ImageCacheManager.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/26/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageCacheManager : NSObject

/*
 * KS: Manager responsible for saving Image Cache - saving and retrieving from Cache, etc
 * Details of actual caching are encapsulated within the manager and changing Caching provider shoudln't effect
 * other parts of the application
 */
+ (instancetype)sharedManager;


- (void)cacheImage:(UIImage *)image forKey:(NSString *)key;
- (UIImage *)getCachedImageForKey:(NSString *)key;

@end
