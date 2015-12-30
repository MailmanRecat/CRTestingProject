//
//  CRTestingFunc.m
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRTestingFunc.h"

#import "CRQueue.h"
#import "CRStack.h"

@interface CRTestingFunc()
@end

@implementation CRTestingFunc

+ (instancetype)shareTesingFunc{
    static CRTestingFunc *testingFunc;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        testingFunc = [CRTestingFunc new];
    });
    return testingFunc;
}

+ (void)runTesting{
    
}



@end
