//
//  UIDevice+Model.h
//  CRTestingProject
//
//  Created by caine on 1/4/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#define MODEL_UNKNOW  @"UNKNOW"
#define MODEL_IPHONE4 @"IPHONE4"
#define MODEL_IPHONE5 @"IPHONE5"
#define MODEL_IPHONE6 @"IPHONE6"
#define MODEL_IPHONE7 @"IPHONE7"
#define MODEL_IPADAIR @"IPADAIR"
#define MODEL_IPADPRO @"IPADPRO"

#import <UIKit/UIKit.h>

@interface UIDevice(ModelTouch)

+ (NSString *)currentDeviceModelFromDevicePixels;

@end
