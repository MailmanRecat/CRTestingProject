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

#import "CRVisualTabBar.h"

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
    
    __block UIButton *btn;
    UIButton *(^letbtn)(NSString *, NSUInteger) = ^(NSString *tit, NSUInteger tag){
        btn = [[UIButton alloc] init];
        [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [btn setTag:CR_BISUAL_PEAK_BUTTON_BASIC_TAG + tag];
        [btn.titleLabel setFont:[UIFont MaterialDesignIconsWithSize:24]];
        [btn setTitle:tit forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:249 / 255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:249 / 255.0 alpha:0.7] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithWhite:249 / 255.0 alpha:0.7] forState:UIControlStateDisabled];
        return btn;
    };
    
    CRVisualTabBar *tabbar = [[CRVisualTabBar alloc] initFromEffectStyle:UIBlurEffectStyleLight];
    [self.view addSubview:tabbar];
    [tabbar.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [tabbar.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [tabbar.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-160].active = YES;
    
    tabbar.items = @[
                     letbtn([UIFont mdiAccount], 0),
                     letbtn([UIFont mdiAccountAlert], 1),
                     letbtn([UIFont mdiAccountBox], 2)
                     ];
    
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
