//
//  SharkPhotoDetailsViewController.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalConstants.h"

@class SharkPhoto;

@interface SharkPhotoDetailsViewController : UIViewController

@property (strong, nonatomic) SharkPhoto *sharkPhoto;
@property (copy, nonatomic) DefaultCompletionBlock cancelHandler;

@end
