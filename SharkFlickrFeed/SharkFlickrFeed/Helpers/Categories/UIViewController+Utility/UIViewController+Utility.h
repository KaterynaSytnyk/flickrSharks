//
//  UIViewController+Utility.h
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/25/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Utility)

/*
 * Shows / hides a progress indicator within the view, managing whether user interaction is enabled / disabled appropriately.
 */
- (void)showHideProgressHUD:(BOOL)show;

/**
 * Shows UIAlertViewController with title and message and OK button
 */
- (void)showAlertWithLocalizedTitle:(NSString *)localizedTitle localizedMessage:(NSString *)localizedMessage;


@end
