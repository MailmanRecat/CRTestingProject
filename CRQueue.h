//
//  CRQueue.h
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRQueue : NSObject

- (instancetype)initWithArray:(NSArray *)array;

- (NSUInteger)count;
- (id)pop;
- (void)push:(id)object;

@end
