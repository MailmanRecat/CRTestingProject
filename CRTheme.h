//
//  CRTheme.h
//  CRClassSchedule
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CRTheme : NSObject

+ (NSDictionary *)themeColors;
+ (UIColor *)themeColorFromString:(NSString *)string;

@end
