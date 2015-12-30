//
//  GoogleInboxLoadingView.m
//  dome12715
//
//  Created by caine on 8/8/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#import "GoogleInboxLoadingView.h"

@interface GoogleInboxLoadingView ()

@property( nonatomic, strong ) UIView *crbear;
@property( nonatomic, assign ) NSUInteger times;
@property( nonatomic, strong ) NSLayoutConstraint *cock;

@end

@implementation GoogleInboxLoadingView

- (instancetype)init{
    self = [super init];
    if( self ){
        [self initClass];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if( self ){
        [self initClass];
    }
    return self;
}

- (void)initClass{
    self.colors = @[
                    [UIColor colorWithRed:56 / 255.0 green:135 / 251.0 blue:255 / 255.0 alpha:1],
                    [UIColor colorWithRed:252 / 255.0 green:55 / 255.0 blue:48 / 255.0 alpha:1],
                    [UIColor colorWithRed:253 / 255.0 green:186 / 255.0 blue:44 / 255.0 alpha:1],
                    [UIColor colorWithRed:48 / 255.0 green:176 / 255.0 blue:81 / 255.0 alpha:1]
                    ];
    self.times = 0;
    self.duration = 1.0;
    self.backgroundColor = self.tintColor = [UIColor whiteColor];
    
    self.crbear =({
        UIView *crbear = [[UIView alloc] init];
        [crbear setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addSubview:crbear];
        [crbear.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [crbear.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        [crbear.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        self.cock = [crbear.widthAnchor constraintEqualToConstant:0];
        self.cock.active = YES;
        crbear;
    });
}

- (void)fuck{
    [self setLoading:YES];
    [self.cock setConstant:self.frame.size.width];
    [self.crbear setBackgroundColor:self.colors[self.times]];
    [UIView animateWithDuration:self.duration
                     animations:^{
                         [self layoutIfNeeded];
                     }completion:^(BOOL f){
                         [self setBackgroundColor:self.crbear.backgroundColor];
                         [self.cock setConstant:0];
                         [self layoutIfNeeded];
                         
                         self.times = self.times + 1 == self.colors.count ? 0 : ++self.times;
                         
                         self.enable ? [self fuck] : [self once:self.tintColor];
                     }];
}

- (void)once:(UIColor *)color{
    [self.crbear setBackgroundColor:color];
    [self.cock setConstant:self.frame.size.width];
    [UIView animateWithDuration:self.duration
                     animations:^{
                         [self layoutIfNeeded];
                     }completion:^( BOOL isFinished ){
                         self.loading = NO;
                         [self setBackgroundColor:self.crbear.backgroundColor];
                         [self.cock setConstant:0];
                         [self layoutIfNeeded];
                     }];
}

- (void)setEnable:(BOOL)enable{
    if( enable == _enable ) return;
    
    _enable = enable;
    if( enable )
        [self fuck];
    
}

@end
