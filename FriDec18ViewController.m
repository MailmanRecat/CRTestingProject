//
//  FriDec18ViewController.m
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "FriDec18ViewController.h"
#import "UIColor+CRColor.h"

@implementation FriDec18ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor CRColorType:CRColorTypeGoogleTomato];
    
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.text = self.title;
    label.font = [UIFont systemFontOfSize:47 weight:UIFontWeightBold];
    [self.view addSubview:label];
    
    [label.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [label.heightAnchor constraintEqualToAnchor:self.view.heightAnchor].active = YES;
    [label.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [label.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
}

- (void)viewWillAppear:(BOOL)animated{
}

@end
