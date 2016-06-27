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
#import "UIViewController+Utility.h"

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
    
    if (self.sharkPhoto.largeImage) {
        self.sharkImageView.image = self.sharkPhoto.largeImage;
    } else {
        self.sharkImageView.image = self.sharkPhoto.thumbnail;
        
        __weak typeof(self) weakSelf = self;
        
        [self showHideProgressHUD:YES];
        [[DataManager sharedManager] loadImageForSharkPhoto:self.sharkPhoto isLarge:YES successHandler:^(UIImage *image) {
            [weakSelf showHideProgressHUD:NO];
            weakSelf.sharkImageView.image = image;
            
        } errorHandler:^(NSString *localizedErrorMessage) {
            NSLog(@"%@", localizedErrorMessage);
            [weakSelf showHideProgressHUD:NO];
            [weakSelf showAlertWithLocalizedTitle:@"Error" localizedMessage:@"Failed loading full sized photo"];
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelTapped:(id)sender {
    if (self.cancelHandler) {
        self.cancelHandler();
    }
}


@end
