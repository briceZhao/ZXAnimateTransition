//
//  DetailViewController.h
//  TransitionOC
//
//  Created by briceZhao on 2017/6/14.
//  Copyright © 2017年 azazie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) UIImage *image;

@property (weak, nonatomic, readonly) IBOutlet UIImageView *avaterImageView;

@end
