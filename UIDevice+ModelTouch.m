//
//  UIDevice+Model.m
//  CRTestingProject
//
//  Created by caine on 1/4/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "UIDevice+ModelTouch.h"

@implementation UIDevice(ModelTouch)
+ (NSString *)currentDeviceModelFromDevicePixels{
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    if( size.width == 320 && size.height == 480 )
        return MODEL_IPHONE4;
    else if( size.width == 320 && size.height == 568 )
        return MODEL_IPHONE5;
    else if( size.width == 375 && size.height == 667 )
        return MODEL_IPHONE6;
    else if( size.width == 414 && size.height == 736 )
        return MODEL_IPHONE7;
    else if( size.width == 768 && size.height == 1024 )
        return MODEL_IPADAIR;
    else if( size.width == 1024 && size.height == 1366 )
        return MODEL_IPADPRO;
    
    return MODEL_UNKNOW;
}
@end
