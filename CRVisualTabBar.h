//
//  CRVisualTabBar.h
//  CRTestingProject
//
//  Created by caine on 1/3/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#define CR_VISUAL_TAB_BAR_HEIGHT 52

#import <UIKit/UIKit.h>

@interface CRVisualTabBar : UIVisualEffectView

@property( nonatomic, strong ) NSArray *items;
@property( nonatomic, assign ) NSUInteger currentIndex;

- (instancetype)initFromEffectStyle:(UIBlurEffectStyle)style;

@end
