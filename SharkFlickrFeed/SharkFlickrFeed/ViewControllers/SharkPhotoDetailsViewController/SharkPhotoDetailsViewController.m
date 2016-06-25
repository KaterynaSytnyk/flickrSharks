//
//  SharkPhotoDetailsViewController.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "SharkPhotoDetailsViewController.h"
#import "SharkPhoto.h"
#import "DataManager.h"

@interface SharkPhotoDetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *sharkImageView;

@end

@implementation SharkPhotoDetailsViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
   
}

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (self.sharkPhoto) {
        self.sharkImageView.image = self.sharkPhoto.largeImage;
    } else {
        self.sharkImageView.image = self.sharkPhoto.thumbnail;
        
    }
    
//    // 1
//    if(self.flickrPhoto.largeImage) {
//        self.imageView.image = self.flickrPhoto.largeImage;
//    } else {
//        // 2
//        self.imageView.image = self.flickrPhoto.thumbnail;
//        // 3
//        [Flickr loadImageForPhoto:self.flickrPhoto thumbnail:NO
//                  completionBlock:^(UIImage *photoImage, NSError *error) {
//                      if(!error) {
//                          // 4
//                          dispatch_async(dispatch_get_main_queue(), ^{
//                              self.imageView.image =
//                              self.flickrPhoto.largeImage;
//                          });
//                      }
//                  }];
//    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
