//
//  ImageCacheManager.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/26/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "ImageCacheManager.h"

@interface ImageCacheManager ()

@property (nonatomic, strong) NSCache *imageCache;

@end

@implementation ImageCacheManager

#pragma mark - Inits

+ (instancetype)sharedManager {
    static ImageCacheManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [ImageCacheManager new];
        sharedManager.imageCache = [NSCache new];
    });
    return sharedManager;
}

#pragma mark - Cache Management

- (void)cacheImage:(UIImage *)image forKey:(NSString *)key {
     [self.imageCache setObject:image forKey:key];
}

- (UIImage *)getCachedImageForKey:(NSString *)key {
    return [self.imageCache objectForKey:key];
}

//KS: TODO - add mechanism for clearing cache


@end
