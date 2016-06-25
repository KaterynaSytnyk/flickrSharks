//
//  SharkPhotoCollectionViewCell.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "SharkPhotoCollectionViewCell.h"
#import "SharkPhoto.h"
#import "UIColor+Utility.h"

@interface SharkPhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sharkImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cellActivityIndicator;


@end

@implementation SharkPhotoCollectionViewCell

#pragma mark - Accessors

- (void)setSharkPhoto:(SharkPhoto *)sharkPhoto {
    if (_sharkPhoto != sharkPhoto) {
        _sharkPhoto = sharkPhoto;
        self.sharkImageView.image = sharkPhoto.thumbnail;
        [self.cellActivityIndicator stopAnimating];
    }
}

- (void)prepareForReuse {
   //KS:TODO - stop downloading
    self.sharkImageView.image = nil;
    [self.cellActivityIndicator startAnimating];
    
}

@end
