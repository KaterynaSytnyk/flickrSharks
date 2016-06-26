//
//  SharkPhotoCollectionViewController.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "SharkPhotoCollectionViewController.h"
#import "SharkPhotoCollectionViewCell.h"
#import "NoPhotoCollectionViewCell.h"
#import "BouncePresentAnimationController.h"
#import "ShrinkDismissAnimationController.h"
#import "SharkPhotoDetailsViewController.h"
#import "SharkPhoto.h"
#import "DataManager.h"
#import "UIViewController+Utility.h"

static NSString *const sharkPhotoReuseIdentifier = @"SharkPhotoCell";
static NSString *const noPhotoReuseIdentifier = @"NoPhotoCell";
static NSInteger const collectionViewNumberOfColumns = 3;

static NSString *const CurrentMessage = @"Loading Sharks..";

@interface SharkPhotoCollectionViewController () <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) NSArray *sharkPhotos;

@property (strong, nonatomic) BouncePresentAnimationController *bounceAnimationController;
@property (strong, nonatomic) ShrinkDismissAnimationController *shrinkDismissAnimationController;

@end

@implementation SharkPhotoCollectionViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    __weak typeof(self) weakSelf = self;
    
    [self showHideProgressHUD:YES];
    
    [[DataManager sharedManager] getSharkPhotosWithSuccessHandler:^(NSArray *sharkPhotos) {
        [weakSelf showHideProgressHUD:NO];
        weakSelf.sharkPhotos = sharkPhotos;
        [weakSelf.collectionView reloadData];
        
    } errorHandler:^(NSString *localizedErrorMessage) {
        
        [weakSelf showHideProgressHUD:NO];
        [weakSelf showAlertWithLocalizedTitle:@"Error" localizedMessage:localizedErrorMessage];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    self.sharkPhotos = nil;
    
    // TODO - flush image cache (when implemented) in case of memory warning
}

#pragma mark - Accessors 

- (BouncePresentAnimationController *)bounceAnimationController {
    if (!_bounceAnimationController) {
        _bounceAnimationController = [BouncePresentAnimationController new];
    }
    
    return _bounceAnimationController;
}

- (ShrinkDismissAnimationController *)shrinkDismissAnimationController {
    if (!_shrinkDismissAnimationController) {
        _shrinkDismissAnimationController = [ShrinkDismissAnimationController new];
    }
    
    return _shrinkDismissAnimationController;
}


#pragma mark - Custom Setup

- (void)setupCollectionView {
    //KS: TODO - add custom styling etc
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSInteger count = self.sharkPhotos.count?:1;
    
    return count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell;
    
    if (self.sharkPhotos.count) {
        SharkPhotoCollectionViewCell *sharkCell = [collectionView dequeueReusableCellWithReuseIdentifier:sharkPhotoReuseIdentifier forIndexPath:indexPath];
        sharkCell.sharkPhoto = self.sharkPhotos[indexPath.row];
        cell = sharkCell;
    } else {
        NoPhotoCollectionViewCell *noPhotoCell = [collectionView dequeueReusableCellWithReuseIdentifier:noPhotoReuseIdentifier forIndexPath:indexPath];
        noPhotoCell.message = CurrentMessage;
        cell = noPhotoCell;
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //KS: calculating size of the cell so that it's always square and the collection view has "collectionViewNumberOfColumns"
    CGFloat photoCellWidth = (collectionView.bounds.size.width - collectionViewLayout.minimumInteritemSpacing * collectionViewNumberOfColumns)/collectionViewNumberOfColumns;
    
    return CGSizeMake(photoCellWidth, photoCellWidth);
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SharkDetails"]) {
        SharkPhotoDetailsViewController *toVC = (SharkPhotoDetailsViewController *)segue.destinationViewController;
        
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        toVC.transitioningDelegate = self;
        
        if (indexPath) {
            toVC.sharkPhoto = self.sharkPhotos[indexPath.row];
        }
        
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}


#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    return self.bounceAnimationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    
    return self.shrinkDismissAnimationController;
}



@end
