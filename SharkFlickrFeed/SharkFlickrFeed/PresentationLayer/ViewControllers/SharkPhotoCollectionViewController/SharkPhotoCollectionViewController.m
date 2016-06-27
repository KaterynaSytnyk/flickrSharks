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
#import "PendingOperations.h"
#import "ImageDownloader.h"
#import "ImageFiltration.h"

static NSString *const sharkPhotoReuseIdentifier = @"SharkPhotoCell";
static NSString *const noPhotoReuseIdentifier = @"NoPhotoCell";
static NSInteger const collectionViewNumberOfColumns = 3;

static NSString *const CurrentMessage = @"Loading Sharks..";

@interface SharkPhotoCollectionViewController () <UIViewControllerTransitioningDelegate,ImageDownloaderDelegate, ImageFiltrationDelegate>

@property (strong, nonatomic) NSMutableArray *sharkPhotos;

// This property is used to track pending operations.
@property (nonatomic, strong) PendingOperations *pendingOperations;

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
        weakSelf.sharkPhotos = [NSMutableArray arrayWithArray:sharkPhotos];
        [weakSelf.collectionView reloadData];
        
    } errorHandler:^(NSString *localizedErrorMessage) {
        
        [weakSelf showHideProgressHUD:NO];
        [weakSelf showAlertWithLocalizedTitle:@"Error" localizedMessage:localizedErrorMessage];
    }];
}

- (void)didReceiveMemoryWarning {
    [self cancelAllOperations];
    [super didReceiveMemoryWarning];
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

- (PendingOperations *)pendingOperations {
    if (!_pendingOperations) {
        _pendingOperations = [PendingOperations new];
    }
    return _pendingOperations;
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

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //KS: calculating size of the cell so that it's always square and the collection view has "collectionViewNumberOfColumns"
    CGFloat photoCellWidth = (collectionView.bounds.size.width - collectionViewLayout.minimumInteritemSpacing * collectionViewNumberOfColumns)/collectionViewNumberOfColumns;
    
    return CGSizeMake(photoCellWidth, photoCellWidth);
}

- (void) willTransitionToTraitCollection:(UITraitCollection *)newCollection withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super willTransitionToTraitCollection:newCollection withTransitionCoordinator:coordinator];
    
    
    __weak typeof(self) weakSelf = self;
    
    //KS: TODO - finish this up, don't need to reload each time
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [weakSelf.collectionView.collectionViewLayout invalidateLayout];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        [weakSelf.collectionView reloadData];
        
    }];
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SharkDetails"]) {
        SharkPhotoDetailsViewController *toVC = (SharkPhotoDetailsViewController *)segue.destinationViewController;
        
        NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [indexPaths objectAtIndex:0];
        
        toVC.transitioningDelegate = self;
        toVC.navigationController.navigationBarHidden = NO;
        
        __weak typeof(self) weakSelf = self;
        toVC.cancelHandler = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
        
        if (indexPath) {
            SharkPhoto *photo = self.sharkPhotos[indexPath.row];
            toVC.sharkPhoto = photo;
        }
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

#pragma mark - THIS IS NOT COMPLETED YET!!!
#pragma mark - Operations

// pass in an instance of SharkPhoto that requires operations, along with its indexPath.
- (void)startOperationsForPhotoRecord:(SharkPhoto *)record atIndexPath:(NSIndexPath *)indexPath {
    
    // inspect it to see whether it has an image; if so, then ignore it.
    if (!record.hasImage) {
        
        // If it does not have an image, start downloading the image by calling startImageDownloadingForRecord:atIndexPath:.
        //do the same for filtering operations: if the image has not yet been filtered, call startImageFiltrationForRecord:atIndexPath:
        [self startImageDownloadingForRecord:record atIndexPath:indexPath];
        
    }
    
    if (!record.isFiltered) {
        [self startImageFiltrationForRecord:record atIndexPath:indexPath];
    }
}


- (void)startImageDownloadingForRecord:(SharkPhoto *)record atIndexPath:(NSIndexPath *)indexPath {
    
    // check for the particular indexPath to see if there is already an operation in downloadsInProgress for it. If so, ignore it.
    if (![self.pendingOperations.downloadsInProgress.allKeys containsObject:indexPath]) {
        // Start downloading
        ImageDownloader *imageDownloader = [[ImageDownloader alloc] initWithPhotoRecord:record atIndexPath:indexPath delegate:self];
        [self.pendingOperations.downloadsInProgress setObject:imageDownloader forKey:indexPath];
        [self.pendingOperations.downloadQueue addOperation:imageDownloader];
    }
}


- (void)startImageFiltrationForRecord:(SharkPhoto *)record atIndexPath:(NSIndexPath *)indexPath {

    if (![self.pendingOperations.filtrationsInProgress.allKeys containsObject:indexPath]) {
        
        // Start filtration
        ImageFiltration *imageFiltration = [[ImageFiltration alloc] initWithPhotoRecord:record atIndexPath:indexPath delegate:self];
        
        // check to see if this particular indexPath has a pending download; if so, make this filtering operation dependent on that. Otherwise, no need for dependency.
        ImageDownloader *dependency = [self.pendingOperations.downloadsInProgress objectForKey:indexPath];
        if (dependency) {
            [imageFiltration addDependency:dependency];
        }
        
        [self.pendingOperations.filtrationsInProgress setObject:imageFiltration forKey:indexPath];
        [self.pendingOperations.filtrationQueue addOperation:imageFiltration];
    }
}

#pragma mark - ImageDownloader delegate


- (void)imageDownloaderDidFinish:(ImageDownloader *)downloader {
    
    // check for the indexPath of the operation, whether it is a download, or filtration.
    NSIndexPath *indexPath = downloader.indexPathInTableView;
    
    // get hold of the SharkPhoto instance.
    SharkPhoto *theRecord = downloader.photoRecord;
    
    // replace the updated SharkPhoto in the main data source (sharkPhotos array).
    [self.sharkPhotos replaceObjectAtIndex:indexPath.row withObject:theRecord];
    
    // update UI
    [self.collectionView reloadItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
    // remove the operation from downloadsInProgress (or filtrationsInProgress).
    [self.pendingOperations.downloadsInProgress removeObjectForKey:indexPath];
}


#pragma mark - ImageFiltration delegate


- (void)imageFiltrationDidFinish:(ImageFiltration *)filtration {
    NSIndexPath *indexPath = filtration.indexPathInTableView;
    SharkPhoto *theRecord = filtration.photoRecord;
    
    [self.sharkPhotos replaceObjectAtIndex:indexPath.row withObject:theRecord];
    [self.collectionView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [self.pendingOperations.filtrationsInProgress removeObjectForKey:indexPath];
}


#pragma mark - UIScrollView delegate
//KS: TODO - uncomment when finished adding concurrency

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    // As soon as the user starts scrolling, we want to suspend all operations and take a look at what the user wants to see.
//    [self suspendAllOperations];
//}
//
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    // If the value of decelerate is NO, that means the user stopped dragging the table view. Therefore we want to resume suspended operations, cancel operations for offscreen cells, and start operations for onscreen cells.
//    if (!decelerate) {
//        [self loadImagesForOnscreenCells];
//        [self resumeAllOperations];
//    }
//}
//
//
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    // table view stopped scrolling
//    [self loadImagesForOnscreenCells];
//    [self resumeAllOperations];
//}



#pragma mark - Cancelling, suspending, resuming queues / operations


- (void)suspendAllOperations {
    [self.pendingOperations.downloadQueue setSuspended:YES];
    [self.pendingOperations.filtrationQueue setSuspended:YES];
}


- (void)resumeAllOperations {
    [self.pendingOperations.downloadQueue setSuspended:NO];
    [self.pendingOperations.filtrationQueue setSuspended:NO];
}


- (void)cancelAllOperations {
    [self.pendingOperations.downloadQueue cancelAllOperations];
    [self.pendingOperations.filtrationQueue cancelAllOperations];
}


- (void)loadImagesForOnscreenCells {
    
    // Get a set of visible rows.
    NSSet *visibleRows = [NSSet setWithArray:[self.collectionView indexPathsForVisibleItems]];
    
    // Get a set of all pending operations (download and filtration).
    NSMutableSet *pendingOperations = [NSMutableSet setWithArray:[self.pendingOperations.downloadsInProgress allKeys]];
    [pendingOperations addObjectsFromArray:[self.pendingOperations.filtrationsInProgress allKeys]];
    
    NSMutableSet *toBeCancelled = [pendingOperations mutableCopy];
    NSMutableSet *toBeStarted = [visibleRows mutableCopy];
    
    // Rows (or indexPaths) that need an operation = visible rows ñ pendings.
    [toBeStarted minusSet:pendingOperations];
    
    // Rows (or indexPaths) that their operations should be cancelled = pendings ñ visible rows.
    [toBeCancelled minusSet:visibleRows];
    
    // Loop through those to be cancelled, cancel them, and remove their reference from PendingOperations.
    for (NSIndexPath *anIndexPath in toBeCancelled) {
        
        ImageDownloader *pendingDownload = [self.pendingOperations.downloadsInProgress objectForKey:anIndexPath];
        [pendingDownload cancel];
        [self.pendingOperations.downloadsInProgress removeObjectForKey:anIndexPath];
        
        ImageFiltration *pendingFiltration = [self.pendingOperations.filtrationsInProgress objectForKey:anIndexPath];
        [pendingFiltration cancel];
        [self.pendingOperations.filtrationsInProgress removeObjectForKey:anIndexPath];
    }
    toBeCancelled = nil;
    
    // Loop through those to be started, and call startOperationsForPhotoRecord:atIndexPath: for each.
    for (NSIndexPath *anIndexPath in toBeStarted) {
        
        SharkPhoto *recordToProcess = [self.sharkPhotos objectAtIndex:anIndexPath.row];
        [self startOperationsForPhotoRecord:recordToProcess atIndexPath:anIndexPath];
    }
    toBeStarted = nil;
    
}



@end
