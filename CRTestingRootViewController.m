//
//  CRTestingRootViewController.m
//  CRTestingProject
//
//  Created by caine on 12/10/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRTestingRootViewController.h"
#import "UIColor+CRColor.h"
#import "CRLayout.h"

@implementation CRTestingRootViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    UILabel *label = ({
        UILabel *label = [UILabel new];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.textColor = [UIColor whiteColor];
        label.text = self.title;
        label;
    });
    
    UIButton *dismissButton = ({
        UIButton *dismiss = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 56 + 20)];
        dismiss.backgroundColor = [UIColor randomColor];
        [dismiss addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        dismiss;
    });
    
    [self.view addSubview:dismissButton];
    [self.view addSubview:label];
    [CRLayout view:@[ label, self.view ] type:CREdgeAround];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CRTestingRootViewController *test = [CRTestingRootViewController new];
    test.view.backgroundColor = [UIColor randomColor];
    [self presentViewController:test animated:YES completion:nil];
}

- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
}

@end
