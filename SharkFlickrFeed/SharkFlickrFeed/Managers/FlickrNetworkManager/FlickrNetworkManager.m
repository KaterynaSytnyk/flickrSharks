//
//  FlickrNetworkManager.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "FlickrNetworkManager.h"



@implementation FlickrNetworkManager

#pragma mark - Inits

+ (instancetype)sharedManager {
    static FlickrNetworkManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [FlickrNetworkManager new];
    });
    return sharedManager;
}



@end
