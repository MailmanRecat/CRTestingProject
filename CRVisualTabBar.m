//
//  CRVisualTabBar.m
//  CRTestingProject
//
//  Created by caine on 1/3/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRVisualTabBar.h"

@interface CRVisualTabBar()

@end

@implementation CRVisualTabBar

- (instancetype)initFromEffectStyle:(UIBlurEffectStyle)style{
    self = [super initWithEffect:[UIBlurEffect effectWithStyle:style]];
    [self initClass];
    return self;
}

- (void)initClass{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.heightAnchor constraintEqualToConstant:CR_VISUAL_TAB_BAR_HEIGHT].active = YES;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    [self initBtns];
}

- (void)initBtns{
    
    __block NSLayoutAnchor *contrastAnchor;
    [self.items enumerateObjectsUsingBlock:^(UIView *btn, NSUInteger index, BOOL *sS){
        [self.contentView addSubview:btn];
         
         if( index == 0 )
             contrastAnchor = self.contentView.leftAnchor;
         
         [btn.heightAnchor constraintEqualToConstant:CR_VISUAL_TAB_BAR_HEIGHT].active = YES;
         [btn.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:(1.0 / self.items.count)].active = YES;
         [btn.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
         [btn.leftAnchor constraintEqualToAnchor:contrastAnchor].active = YES;
         
         contrastAnchor = btn.rightAnchor;
     }];
}

@end
