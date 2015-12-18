//
//  CRStack.m
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRStack.h"

@interface CRStack()

@property( nonatomic, strong ) NSMutableArray *stack;

@end

@implementation CRStack

- (instancetype)init{
    return [self initWithArray:[NSArray new]];
}

- (instancetype)initWithArray:(NSArray *)array{
    self = [super init];
    if( self ){
        self.stack = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}

- (NSUInteger)count{
    return [self.stack count];
}

- (id)pop{
    return ({
        [self.stack count] > 0 ? ({
            id obj = self.stack.lastObject;
            [self.stack removeLastObject];
            obj;
        }) : nil;
    });
}

- (void)push:(id)object{
    [self.stack addObject:object];
}

@end
