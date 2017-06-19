//
//  TransitionPopAnimator.m
//  TransitionOC
//
//  Created by briceZhao on 2017/6/19.
//  Copyright © 2017年 azazie. All rights reserved.
//

#import "TransitionPopAnimator.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "DetailAnimateCell.h"

@implementation TransitionPopAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //1、获取动画源控制器和目标控制器
    DetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    ViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = transitionContext.containerView;
    
    //2、创造一个avaterImageView的截图，并把avaterImageView 和 cell.imageView 都隐藏，让人感觉移动的就是avaterImageView
    UIView *snapshotView = [fromVC.avaterImageView snapshotViewAfterScreenUpdates:NO];
    snapshotView.frame = [container convertRect:fromVC.avaterImageView.frame fromView:fromVC.view];
    fromVC.avaterImageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.selectedCell.imageView.hidden = YES;
    
    [container insertSubview:toVC.view belowSubview:fromVC.view];
    [container addSubview:snapshotView];
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        snapshotView.frame = [container convertRect:toVC.selectedCell.imageView.frame fromView:toVC.selectedCell];
        fromVC.view.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        toVC.selectedCell.imageView.hidden = NO;
        fromVC.avaterImageView.hidden = NO;
        [snapshotView removeFromSuperview];
        
        [transitionContext completeTransition:YES];
    }];
}

@end
