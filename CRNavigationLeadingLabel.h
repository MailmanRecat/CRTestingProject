//
//  CRNavigationLeadingLabel.h
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CRNavigationLeadingLabelType){
    CRNavigationLeadingLabelTypePush = 0,
    CRNavigationLeadingLabelTypePop
};

@interface CRNavigationLeadingLabel : UIView

@property( nonatomic, assign ) NSTimeInterval duration;

- (instancetype)initWithTitle:(NSString *)title;

- (void)setFont:(UIFont *)font color:(UIColor *)color;
- (void)setLeftEdgeAnchor:(CGFloat)anchor distance:(CGFloat)distance;

- (void)push:(CRNavigationLeadingLabelType)type title:(NSString *)title;

@end
