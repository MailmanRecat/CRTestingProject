//
//  CRQueue.m
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRQueue.h"

@interface CRQueue()

@property( nonatomic, strong ) NSMutableArray *queue;

@end

@implementation CRQueue

- (instancetype)init{
    return [self initWithArray:[NSArray new]];
}

- (instancetype)initWithArray:(NSArray *)array{
    self = [super init];
    if( self ){
        self.queue = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}

- (NSUInteger)count{
    return [self.queue count];
}

- (id)pop{
    return ({
        [self.queue count] > 0 ? ({
            id obj = self.queue.firstObject;
            [self.queue removeObjectAtIndex:0];
            obj;
        }) : nil;
    });
}

- (void)push:(id)object{
    [self.queue addObject:object];
}

@end
