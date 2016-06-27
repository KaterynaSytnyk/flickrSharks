//
//  ImageDownloader.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/26/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import <Foundation/Foundation.h>

// Importing SharkPhoto so that we can independently set the image property of a SharkPhoto once it is successfully downloaded. If downloading fails, set its failed value to YES.
#import "SharkPhoto.h"

//Declaring a delegate so that you can notify the caller once the operation is finished.
@protocol ImageDownloaderDelegate;

@interface ImageDownloader : NSOperation

@property (nonatomic, assign) id <ImageDownloaderDelegate> delegate;

//declaring indexPathInTableView for convenience so that once the operation is finished, the caller has a reference to where this operation belongs to.
@property (nonatomic, readonly, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readonly, strong) SharkPhoto *photoRecord;

// declaring a designated initializer.
- (id)initWithPhotoRecord:(SharkPhoto *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>) theDelegate;

@end

@protocol ImageDownloaderDelegate <NSObject>

// Pass the whole class as an object back to the caller so that the caller can access both indexPathInTableView and photo.
// we need to cast the operation to NSObject and return it on the main thread so the delegate method can't have more than one argument.
- (void)imageDownloaderDidFinish:(ImageDownloader *)downloader;

@end
