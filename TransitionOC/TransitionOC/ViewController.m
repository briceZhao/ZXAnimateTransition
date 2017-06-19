//
//  ViewController.m
//  TransitionOC
//
//  Created by briceZhao on 2017/6/14.
//  Copyright © 2017年 azazie. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "DetailAnimateCell.h"
#import "TransitionAnimator.h"

@interface ViewController () <UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.navigationController.delegate = self;
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (operation == UINavigationControllerOperationPush) {
        return [[TransitionAnimator alloc]init];
    }
    else {
        return nil;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]) {
        DetailViewController *detailVC = segue.destinationViewController;
        detailVC.image = self.selectedCell.imageView.image;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailAnimateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DetailAnimateCellId" forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedCell = (DetailAnimateCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [self performSegueWithIdentifier:@"detail" sender:nil];
}



@end
