//
//  CRVEPassboard.m
//  CRTestingProject
//
//  Created by caine on 12/31/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRVEPassboard.h"
#import "CRVEPassCodeBtn.h"

@interface CRVEPassboard()

@end

@implementation CRVEPassboard

- (instancetype)init{
    self = [super init];
    
    [self initClass];
    
    return self;
}

- (void)initClass{
    
    UIEdgeInsets edge = UIEdgeInsetsMake(26, 24, 26, 24);
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.widthAnchor constraintEqualToConstant:edge.left * 4 + 80 * 3].active = YES;
    [self.heightAnchor constraintEqualToConstant:(80 * 4) + (edge.top * 5)].active = YES;
    
    CRVEPassCodeBtn *C0, *C1, *C2, *C3, *C4, *C5, *C6, *C7, *C8, *C9;
    
    UIBlurEffectStyle style = UIBlurEffectStyleDark;
    C0 = [[CRVEPassCodeBtn alloc] initFromNumber:0 effectStyle:style];
    C1 = [[CRVEPassCodeBtn alloc] initFromNumber:1 effectStyle:style];
    C2 = [[CRVEPassCodeBtn alloc] initFromNumber:2 effectStyle:style];
    C3 = [[CRVEPassCodeBtn alloc] initFromNumber:3 effectStyle:style];
    C4 = [[CRVEPassCodeBtn alloc] initFromNumber:4 effectStyle:style];
    C5 = [[CRVEPassCodeBtn alloc] initFromNumber:5 effectStyle:style];
    C6 = [[CRVEPassCodeBtn alloc] initFromNumber:6 effectStyle:style];
    C7 = [[CRVEPassCodeBtn alloc] initFromNumber:7 effectStyle:style];
    C8 = [[CRVEPassCodeBtn alloc] initFromNumber:8 effectStyle:style];
    C9 = [[CRVEPassCodeBtn alloc] initFromNumber:9 effectStyle:style];
    
    __block NSLayoutAnchor *relaHorAnchor;
    [@[ C1, C2, C3, C4, C5, C6, C7, C8, C9 ] enumerateObjectsUsingBlock:^(UIView *btn, NSUInteger index, BOOL *sS){
        [self addSubview:btn];
        if( index % 3 == 0 )
            relaHorAnchor = self.leftAnchor;
        
        NSUInteger constant = index / 3;
        [btn.topAnchor constraintEqualToAnchor:self.topAnchor constant:(constant * 80) + ((constant + 1) * edge.top)].active = YES;
        [btn.leftAnchor constraintEqualToAnchor:relaHorAnchor constant:edge.left].active = YES;

        relaHorAnchor = btn.rightAnchor;
    }];
    
    [self addSubview:C0];
    [C0.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-edge.top].active = YES;
    [C0.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    
    [C0 addTarget:self action:@selector(tttt) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tttt{
    NSLog(@"touched");
}

@end
