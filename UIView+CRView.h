//
//  UIView+CRView.h
//  CRNote
//
//  Created by caine on 12/20/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRLayout.h"

@interface UIView (CRView)

- (void)addAutolayoutSubviews:(NSArray<UIView *> *)views;
- (void)makeBorderWithColor:(UIColor *)color width:(CGFloat)width;
- (void)makeShadowWithSize:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;
- (void)makeShadowWithPath:(CGPathRef)path size:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;
- (void)makeButtonTitle:(NSString *)title titleColor:(UIColor *)color state:(UIControlState)state;

@end
