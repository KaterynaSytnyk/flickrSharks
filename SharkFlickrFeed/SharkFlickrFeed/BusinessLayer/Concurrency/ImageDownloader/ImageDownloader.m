//
//  ImageDownloader.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/26/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "ImageDownloader.h"

@interface ImageDownloader ()
@property (nonatomic, readwrite, strong) NSIndexPath *indexPathInTableView;
@property (nonatomic, readwrite, strong) SharkPhoto *photoRecord;
@end


@implementation ImageDownloader

- (id)initWithPhotoRecord:(SharkPhoto *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>)theDelegate {
    
    if (self = [super init]) {
        self.delegate = theDelegate;
        self.indexPathInTableView = indexPath;
        self.photoRecord = record;
    }
    return self;
}

#pragma mark -
#pragma mark - Downloading image

// regularly checking for isCancelled, to make sure the operation terminates as soon as possible.
- (void)main {
    
    @autoreleasepool {
        
        if (self.isCancelled)
            return;
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL:self.photoRecord.URL];
        
        if (self.isCancelled) {
            imageData = nil;
            return;
        }
        
        if (imageData) {
            UIImage *downloadedImage = [UIImage imageWithData:imageData];
            self.photoRecord.image = downloadedImage;
        }
        else {
            self.photoRecord.failed = YES;
        }
        
        imageData = nil;
        
        if (self.isCancelled)
            return;
        
        // cast the operation to NSObject, and notify the caller on the main thread.
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageDownloaderDidFinish:) withObject:self waitUntilDone:NO];
        
    }
}

@end
