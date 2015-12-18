//
//  CRToolBarView.m
//  CRTestingProject
//
//  Created by caine on 12/10/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRToolBarView.h"
#import "UIView+MOREStackLayoutView.h"

@implementation CRToolBarView

- (void)willMoveToSuperview:(UIView *)newSuperview{
    CGFloat len = [self.items count];
    [self autolayoutPushSubviews:self.items
                      edgeInsets:UIEdgeInsetsZero
                      multiplier:( 1.0 / len )
                       constants:0
                stackOrientation:autolayoutStackOrientationHorizontal];
}

@end
