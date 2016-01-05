//
//  LayoutGuideTestController.m
//  CRTestingProject
//
//  Created by caine on 12/31/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "LayoutGuideTestController.h"
#import "CRVEPassCodeBtn.h"
#import "CRVEPassboard.h"

@interface LayoutGuideTestController()

@end

@implementation LayoutGuideTestController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:89 / 255.0 alpha:1];
    
    CRVEPassboard *board = [[CRVEPassboard alloc] init];
//    board.backgroundColor = [UIColor randomColor];
    [self.view addSubview:board];
    
    [board.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:100].active = YES;
    [board.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
}

@end
