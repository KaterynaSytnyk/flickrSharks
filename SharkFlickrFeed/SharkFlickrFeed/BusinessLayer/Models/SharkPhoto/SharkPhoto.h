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


@end
