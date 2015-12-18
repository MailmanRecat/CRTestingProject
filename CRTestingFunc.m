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

@implementation CRTestingFunc

+ (void)runTesting{
    
    CRQueue *queue = [[CRQueue alloc] initWithArray:@[ @"1", @"2", @"3", @"4", @"5" ]];
    
    CRStack *stack = [[CRStack alloc] init];
    
    [stack push:@"1"];
    [stack push:@"2"];
//    NSLog(@"%@", [stack pop]);
//    NSLog(@"%@", [stack pop]);
    
//    NSLog(@"%@", [queue pop]);
//    NSLog(@"%@", [queue pop]);
//    NSLog(@"%@", [queue pop]);
//    NSLog(@"%@", [queue pop]);
//    NSLog(@"%@", [queue pop]);
//    [queue push:@"6"];
//    NSLog(@"%@", [queue pop]);
//    NSLog(@"%@", [queue pop]);
}

@end
