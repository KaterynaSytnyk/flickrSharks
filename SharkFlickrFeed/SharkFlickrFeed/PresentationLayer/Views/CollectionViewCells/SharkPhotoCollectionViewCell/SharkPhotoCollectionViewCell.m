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
#import "NSString+Utility.h"
#import "DataManager.h"

@interface SharkPhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *sharkImageView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *cellActivityIndicator;


@end

@implementation SharkPhotoCollectionViewCell

#pragma mark - Accessors

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *bgView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
        bgView.backgroundColor = [UIColor blueColor];
        bgView.layer.borderColor = [[UIColor whiteColor] CGColor];
        bgView.layer.borderWidth = 4;
        self.selectedBackgroundView = bgView;
    }
    return self;
}

- (void)setSharkPhoto:(SharkPhoto *)sharkPhoto {
    if (_sharkPhoto != sharkPhoto) {
        _sharkPhoto = sharkPhoto;
        
        [self loadImageForSharkPhoto:sharkPhoto];
    }
}

- (void)loadImageForSharkPhoto:(SharkPhoto *)sharkPhoto {
    self.sharkImageView.image = nil;
    self.cellActivityIndicator.hidden = NO;
    [self.cellActivityIndicator startAnimating];
    
    __weak typeof(self) weakSelf = self;
    
    [[DataManager sharedManager] loadImageForSharkPhoto:sharkPhoto successHandler:^(UIImage *image) {
        [weakSelf.cellActivityIndicator stopAnimating];
        weakSelf.cellActivityIndicator.hidden = YES;
        weakSelf.sharkImageView.image = image;
        
    } errorHandler:^(NSString *localizedErrorMessage) {
        NSLog(@"%@", localizedErrorMessage);
        [weakSelf.cellActivityIndicator stopAnimating];
        weakSelf.cellActivityIndicator.hidden = YES;
        weakSelf.sharkImageView.image = [UIImage imageNamed:@"Broken"];
    }];
}



- (void)prepareForReuse {
   //KS:TODO - stop downloading
    self.sharkImageView.image = nil;
}

@end
