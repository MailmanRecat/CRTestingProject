//
//  GoogleToggle.h
//  CRNote
//
//  Created by caine on 12/29/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define GOOGLE_TOGGLE_WIDTH 44
#define GOOGLE_TOOGLE_HEIGHT 24

#import <UIKit/UIKit.h>

@interface GoogleToggle : UIControl

@property( nonatomic, assign ) BOOL enable;
@property( nonatomic, strong ) UIColor *tipTheme;

@property( nonatomic, strong ) UIFont *font;
@property( nonatomic, strong ) NSString *enableString;
@property( nonatomic, strong ) NSString *disableString;

- (instancetype)initWithTarget:(id)target action:(SEL)action;
- (void)addTarget:(id)target action:(SEL)action;

@end
