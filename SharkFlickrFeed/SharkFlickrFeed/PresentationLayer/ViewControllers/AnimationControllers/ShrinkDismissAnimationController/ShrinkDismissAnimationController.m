//
//  ShrinkDismissAnimationController.m
//  SharkFlickrFeed
//
//  Created by Kateryna Sytnyk on 6/24/16.
//  Copyright © 2016 KaterynaSytnyk. All rights reserved.
//

#import "ShrinkDismissAnimationController.h"

@implementation ShrinkDismissAnimationController

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return 1.0;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    // 1. obtain state from the context
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toViewController];
    
    // 2. obtain the container view
    UIView *containerView = [transitionContext containerView];
    
    // 3. set initial state
    toViewController.view.frame = finalFrame;
    toViewController.view.alpha = 0.5;
    
    // 4. add the view
    [containerView addSubview:toViewController.view];
    [containerView sendSubviewToBack:toViewController.view];
    
    // 1. Determine the intermediate and final frame for the from view
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect shrunkenFrame = CGRectInset(fromViewController.view.frame, fromViewController.view.frame.size.width/4, fromViewController.view.frame.size.height/4);
    CGRect fromFinalFrame = CGRectOffset(shrunkenFrame, 0, screenBounds.size.height);
    
    // create a snapshot
    UIView *intermediateView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    intermediateView.frame = fromViewController.view.frame;
    [containerView addSubview:intermediateView];
    
    // remove the real view
    [fromViewController.view removeFromSuperview];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // animate with keyframes
    [UIView animateKeyframesWithDuration:duration
                                   delay:0.0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  // 2a. keyframe one
                                  [UIView addKeyframeWithRelativeStartTime:0.0
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    intermediateView.frame = shrunkenFrame;
                                                                    toViewController.view.alpha = 0.5;
                                                                }];
                                  // 2b. keyframe two
                                  [UIView addKeyframeWithRelativeStartTime:0.5
                                                          relativeDuration:0.5
                                                                animations:^{
                                                                    intermediateView.frame = fromFinalFrame;
                                                                    toViewController.view.alpha = 1.0;
                                                                }];
                              }
                              completion:^(BOOL finished) {
                                  // 3. inform the context of completion
                                  [intermediateView removeFromSuperview];
                                  [transitionContext completeTransition:YES];
                              }];
    
}

@end
