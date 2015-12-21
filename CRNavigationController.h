//
//  CRNavigationViewController.h
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#import <UIKit/UIKit.h>

@interface CRNavigationController : UIViewController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;

- (void)crpushViewController:(UIViewController *)controller animated:(BOOL)animated;
- (void)crpopRootViewControllerAnimated:(BOOL)animated;
- (void)crpopViewControllerAnimated:(BOOL)animated;

@end
