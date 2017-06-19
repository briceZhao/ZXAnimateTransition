//
//  TransitionAnimator.m
//  TransitionOC
//
//  Created by briceZhao on 2017/6/14.
//  Copyright © 2017年 azazie. All rights reserved.
//

#import "TransitionAnimator.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "DetailAnimateCell.h"

@implementation TransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    //1. 获取动画源控制器和目标控制器
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    DetailViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *container = transitionContext.containerView;
    
    //2. 创建一个imageView的截图，并把cell.imageView隐藏，造成让用户以为移动的就是imageView的假象
    UIView *snapshotView = [fromVC.selectedCell.imageView snapshotViewAfterScreenUpdates:NO];
    
    snapshotView.frame = [container convertRect:fromVC.selectedCell.imageView.frame fromView:fromVC.selectedCell];
    
    fromVC.selectedCell.imageView.hidden = YES;
    
    //3. 设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    
    //4. 都添加到containerView中，注意顺序不能错了
    [container addSubview:toVC.view];
    [container addSubview:snapshotView];
    
    //5. 执行动画
    //[toVC.avaterImageView layoutIfNeeded];
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        
        snapshotView.frame = toVC.avaterImageView.frame;
        
        toVC.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        fromVC.selectedCell.imageView.hidden = NO;
        toVC.avaterImageView.image = toVC.image;
        [snapshotView removeFromSuperview];
        
        // MARK: - 必须要在动画完成后执行此方法:（让系统管理navigation）
        [transitionContext completeTransition:YES];
    }];
    
}

@end
