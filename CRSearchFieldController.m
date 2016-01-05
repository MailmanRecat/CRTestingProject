//
//  CRSearchFieldController.m
//  CRTestingProject
//
//  Created by caine on 1/4/16.
//  Copyright © 2016 com.caine. All rights reserved.
//

#import "CRSearchFieldController.h"
#import "UIView+CRView.h"
#import "UIDevice+ModelTouch.h"

@interface CRSearchFieldController()<UITextFieldDelegate>

@property( nonatomic, strong ) NSLayoutConstraint *yellowStoneLayoutGuide;
@property( nonatomic, strong ) UIView *yellowStone;
@property( nonatomic, strong ) UIButton *dismissBtn;
@property( nonatomic, strong ) UITextField *searchField;

@property( nonatomic, strong ) UITableView *bear;

@end

@implementation CRSearchFieldController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self letSearchField];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.searchField becomeFirstResponder];
}

- (void)letSearchField{
    self.yellowStone = ({
        UIView *stone = [[UIView alloc] init];
        stone.translatesAutoresizingMaskIntoConstraints = NO;
        stone.layer.cornerRadius = 4.0f;
        stone.backgroundColor = [UIColor whiteColor];
        [stone letShadowWithSize:CGSizeMake(0, 1) opacity:0.17 radius:1.7];
        [self.view addSubview:stone];
        [stone.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:STATUS_BAR_HEIGHT + 8].active = YES;
        [stone.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:8].active = YES;
        [stone.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-8].active = YES;
        self.yellowStoneLayoutGuide = [stone.heightAnchor constraintEqualToConstant:48];
        self.yellowStoneLayoutGuide.active = YES;
        stone;
    });
    
    self.dismissBtn = ({
        UIButton *dismiss = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 48, 48)];
        dismiss.layer.cornerRadius = 48 / 2;
        [self.yellowStone addSubview:dismiss];
        [dismiss.titleLabel setFont:[UIFont MaterialDesignIconsWithSize:21]];
        [dismiss setTitle:[UIFont mdiArrowLeft] forState:UIControlStateNormal];
        [dismiss setTitleColor:[UIColor colorWithWhite:137 / 255.0 alpha:1] forState:UIControlStateNormal];
        [dismiss addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        dismiss;
    });
    
    self.searchField= ({
        UITextField *textField = [[UITextField alloc] init];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.layer.cornerRadius = 3.0f;
        textField.delegate = self;
        [self.yellowStone addSubview:textField];
        [textField.leftAnchor constraintEqualToAnchor:self.yellowStone.leftAnchor constant:48].active = YES;
        [textField.rightAnchor constraintEqualToAnchor:self.yellowStone.rightAnchor].active = YES;
        [textField.topAnchor constraintEqualToAnchor:self.yellowStone.topAnchor].active = YES;
        [textField.bottomAnchor constraintEqualToAnchor:self.yellowStone.bottomAnchor].active = YES;
        textField;
    });
}

- (void)letBear{
    
}

- (void)dismissSelf{
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
