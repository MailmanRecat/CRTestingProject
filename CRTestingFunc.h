//
//  CRTestingFunc.h
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CRTestingFunc : NSObject

@property( nonatomic, assign ) BOOL enable;
@property( nonatomic, assign ) BOOL running;

+ (void)runTesting;
+ (instancetype)shareTesingFunc;

@end
