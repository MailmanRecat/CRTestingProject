//
//  UIView+CRView.m
//  CRNote
//
//  Created by caine on 12/20/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UIView+CRView.h"

@implementation UIView (CRView)

- (void)addAutolayoutSubviews:(NSArray<UIView *> *)views{
    [views enumerateObjectsUsingBlock:^(UIView *view, NSUInteger index, BOOL *sS){
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:view];
    }];
}

- (void)makeBorderWithColor:(UIColor *)color width:(CGFloat)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)makeShadowWithSize:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

- (void)makeShadowWithPath:(CGPathRef)path size:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowPath = path;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

- (void)makeButtonTitle:(NSString *)title titleColor:(UIColor *)color state:(UIControlState)state{
    [(UIButton *)self setTitle:title forState:state];
    [(UIButton *)self setTitleColor:color forState:state];
}

- (void)letShadowWithSize:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

- (void)letShadowWithPath:(CGPathRef)path size:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowPath = path;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

@end
