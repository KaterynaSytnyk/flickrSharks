//
//  SharkPhotoCollectionViewController.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "SharkPhotoCollectionViewController.h"
#import "SharkPhotoCollectionViewCell.h"
#import "BouncePresentAnimationController.h"
#import "ShrinkDismissAnimationController.h"
#import "SharkPhotoDetailsViewController.h"

static NSString *const reuseIdentifier = @"SharkPhoto";
static NSInteger const collectionViewNumberOfColumns = 3;

@interface SharkPhotoCollectionViewController () <UIViewControllerTransitioningDelegate>

@property (strong, nonatomic) NSMutableArray *sharkPhotos;

@property (strong, nonatomic) BouncePresentAnimationController *bounceAnimationController;
@property (strong, nonatomic) ShrinkDismissAnimationController *shrinkDismissAnimationController;

@end

@implementation SharkPhotoCollectionViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupCollectionView];
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
    // Register cell classes
    [self.collectionView registerClass:[SharkPhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
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


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.sharkPhotos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SharkPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.sharkPhoto = self.sharkPhotos[indexPath.row];
    
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



@end
