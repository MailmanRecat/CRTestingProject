//
//  CRPACKBViewController.m
//  CRTestingProject
//
//  Created by caine on 12/24/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRTheme.h"
#import "UIFont+MaterialDesignIcons.h"
#import "GoogleInboxLoadingView.h"
#import "CRPACKBViewController.h"
#import "GoogleToggle.h"

@interface CRPACKBViewController()

@property( nonatomic, strong ) GoogleInboxLoadingView *loading;

@property( nonatomic, strong ) UILabel *res;
@property( nonatomic, strong ) GoogleToggle *tog;

@end

@implementation CRPACKBViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    self.loading = [[GoogleInboxLoadingView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 6)];
    [self.view addSubview:self.loading];
    
    UIView *bv = [[UIView alloc] init];
    bv.backgroundColor = [CRTheme themeColorFromString:@"default"];
    bv.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bv];
    [bv.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [bv.heightAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [bv.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [bv.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
//    self.tog = [[GoogleToggle alloc] initWithTarget:self action:@selector(togAction)];
    self.tog = [[GoogleToggle alloc] init];
    [self.tog addTarget:self action:@selector(togAction)];
    [self.view addSubview:self.tog];
    [self.tog.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.tog.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    self.tog.tipTheme = [CRTheme themeColorFromString:@"tomato"];
    self.tog.font = [UIFont MaterialDesignIconsWithSize:15];
    self.tog.enableString = [UIFont mdiEye];
    self.tog.disableString = [UIFont mdiEyeOff];
}

- (void)togAction{
    if( !self.res )
        self.res = ({
            UILabel *res = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200, self.view.frame.size.width, 56)];
            [self.view addSubview:res];
            res.text = @"RES";
            res.textAlignment = NSTextAlignmentCenter;
            res.textColor = [UIColor whiteColor];
            res.font = [UIFont systemFontOfSize:27 weight:UIFontWeightBold];
            res;
        });
    
    if( self.tog.enable )
        self.res.text = @"enable";
    else
        self.res.text = @"disable";
}

- (void)viewDidAppear:(BOOL)animated{
//    [self.loading ON];
    self.loading.enable = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if( self.loading.enable )
        self.loading.enable = NO;
    else{
        self.loading.tintColor = [CRTheme randomColor];
        self.loading.colors = @[ [CRTheme randomColor], [CRTheme randomColor], [CRTheme randomColor], [CRTheme randomColor], [CRTheme randomColor] ];
        self.loading.enable = YES;
    }
}

- (UIStatusBarStyle)preferredStatusBarStylea{
    return UIStatusBarStyleDefault;
}

@end
