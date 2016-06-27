//
//  SharkPhoto.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SharkPhoto : NSObject

@property (strong, nonatomic) UIImage *thumbnail;
@property (strong, nonatomic) UIImage *largeImage;

@property (strong, nonatomic) NSString *photoTitle;
@property (strong, nonatomic) NSString *thumbnailImageURL;
@property (strong, nonatomic) NSString *largeImageURL;


@property (nonatomic, strong) NSString *name;  // To store the name of image
@property (nonatomic, strong) UIImage *image; // To store the actual image
@property (nonatomic, strong) NSURL *URL; // To store the URL of the image

@property (nonatomic, readonly) BOOL hasImage; // Return YES if image is downloaded.
@property (nonatomic, getter = isFiltered) BOOL filtered; // Return YES if image is sepia-filtered
@property (nonatomic, getter = isFailed) BOOL failed; // Return Yes if image failed to be downloaded


@end
