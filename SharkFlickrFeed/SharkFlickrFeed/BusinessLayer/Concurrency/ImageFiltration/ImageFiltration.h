//
//  ImageFiltration.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/26/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import "SharkPhoto.h"

// a delegate to notify the caller once its operation is finished.
@protocol ImageFiltrationDelegate;

@interface ImageFiltration : NSOperation

@property (nonatomic, weak) id <ImageFiltrationDelegate> delegate;
@property (nonatomic, readonly, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readonly, strong) SharkPhoto *photoRecord;

- (id)initWithPhotoRecord:(SharkPhoto *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageFiltrationDelegate>)theDelegate;

@end

@protocol ImageFiltrationDelegate <NSObject>

- (void)imageFiltrationDidFinish:(ImageFiltration *)filtration;

@end
