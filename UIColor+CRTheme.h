//
//  UIColor+CRTheme.h
//  CRNote
//
//  Created by caine on 12/20/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const CRThemeColorDefault = @"default";

@interface UIColor (CRTheme)

+ (NSArray *)themeColorname;
+ (NSDictionary *)themeColors;
+ (UIColor *)themeColorFromString:(NSString *)string;

+ (UIColor *)CRColor:(CGFloat)R :(CGFloat)G :(CGFloat)B :(CGFloat)Alpha;

+ (UIColor *)randomColor;

@end
