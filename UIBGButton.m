//
//  UIBGButton.m
//  CRTestingProject
//
//  Created by caine on 1/4/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "UIBGButton.h"

@interface UIBGButton()

@property( nonatomic, strong ) UIColor *bcholder;
@property( nonatomic, strong ) UIColor *tcholder;

@end

@implementation UIBGButton

- (instancetype)init{
    self = [super init];
    
    [self addTarget:self action:@selector(letHighlighted) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(letHighlighted) forControlEvents:UIControlEventTouchDragInside];
    [self addTarget:self action:@selector(letUnhightlighted) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(letUnhightlighted) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(letUnhightlighted) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(letUnhightlighted) forControlEvents:UIControlEventTouchDragOutside];
    
    self.titleLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:label];
        [label.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [label.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
        [label.rightAnchor constraintEqualToAnchor:self.rightAnchor].active = YES;
        [label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
        label;
    });
    
    return self;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    self.backgroundColor = backgroundColor;
    self.bcholder = backgroundColor;
}

- (void)setHighlightTextColor:(UIColor *)highlightTextColor{
    _highlightTextColor = highlightTextColor;
    self.tcholder = self.titleLabel.textColor;
}

- (void)letHighlighted{
    self.highlighted = YES;
    [self letStateUpdate];
}

- (void)letUnhightlighted{
    self.highlighted = NO;
    [self letStateUpdate];
}

- (void)letStateUpdate{
    if( self.state == UIControlStateHighlighted )
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.backgroundColor = self.highlightColor;
                             self.titleLabel.textColor = self.highlightTextColor ? self.highlightTextColor : self.titleLabel.textColor;
                         }];
    else
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.backgroundColor = self.bcholder;
                             self.titleLabel.textColor = self.tcholder;
                         }];
}

@end
