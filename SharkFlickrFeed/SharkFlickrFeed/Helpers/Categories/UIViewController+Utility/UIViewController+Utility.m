//
//  UIViewController+Utility.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/25/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "UIViewController+Utility.h"
#import "MBProgressHUD.h"
#import "GlobalLocalizations.h"

@implementation UIViewController (Utility)

- (void)showHideProgressHUD:(BOOL)show {
    @try {
        if (show) {
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        } else {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }
    @catch (NSException *exception) {
        NSLog(exception, @"MBProgressHUD threw an exception");
    }
}


- (void)showAlertWithLocalizedTitle:(NSString *)localizedTitle localizedMessage:(NSString *)localizedMessage {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:localizedTitle
                                                                   message:localizedMessage
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    
    [alert addAction:[UIAlertAction actionWithTitle:[GlobalLocalizations localizedGlobalOk]
                                              style:(UIAlertActionStyleDefault) handler:nil]];
    
    [[self viewControllerForPresentingAlerts] presentViewController:alert animated:YES completion:nil];
}


- (UIViewController *)viewControllerForPresentingAlerts {
    if (self.navigationController) {
        return self.navigationController;
    }
    return self;
}

@end
