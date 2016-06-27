//
//  NoPhotoCollectionViewCell.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/25/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "NoPhotoCollectionViewCell.h"

@interface NoPhotoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;


@end

@implementation NoPhotoCollectionViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        UIView *bgView = [[UIView alloc] initWithFrame:self.backgroundView.frame];
        bgView.backgroundColor = [UIColor blueColor]; //KS: TODO - use UIColor and UIFont categories instead
        bgView.layer.borderColor = [[UIColor whiteColor] CGColor];
        bgView.layer.borderWidth = 4;
        self.selectedBackgroundView = bgView;
    }
    return self;
}

- (void)setMessage:(NSString *)message {
    if (![_message isEqualToString:message]) {
        _message = message;
    }
    
    self.messageLabel.text = message;
}

@end
