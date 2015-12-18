//
//  CRNavigationViewController.m
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define CR_SEGUE_DURATION 0.25

#import "CRNavigationController.h"
#import "UIView+MOREShadow.h"
#import "UIFont+MaterialDesignIcons.h"
#import "CRStack.h"
#import "CRQueue.h"
#import "CRNavigationLeadingLabel.h"

#import "FriDec18ViewController.h"
#import "CRTheme.h"
#import "UIColor+CRColor.h"

static NSString *const CRNavigationControllerSeguePush = @"CR_NAVIGATION_CONTROLLER_SEGUE_PUSH";
static NSString *const CRNavigationControllerSeguePop  = @"CR_NAVIGATION_CONTROLLER_SEGUE_POP";

@interface CRNavigationController()

@property( nonatomic, strong ) UIView *park;
@property( nonatomic, strong ) UIButton *dismissButton;
@property( nonatomic, strong ) CRNavigationLeadingLabel *titleLabel;

@property( nonatomic, strong ) CRQueue *operationQueue;
@property( nonatomic, assign ) BOOL canOperation;
@property( nonatomic, assign ) NSUInteger level;

@property( nonatomic, strong ) CRStack *crviewControllerStack;
@property( nonatomic, strong ) UIViewController *crrootViewController;
@property( nonatomic, strong ) UIViewController *crvisualViewController;

@property( nonatomic, assign ) NSUInteger counter;

@end

@implementation CRNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super init];
    if( self ){
        
        self.operationQueue = [[CRQueue alloc] init];
        self.canOperation = YES;
        self.crviewControllerStack = [[CRStack alloc] init];
        self.level = 0;
        
        self.level++;
        self.crrootViewController = rootViewController;
        self.crvisualViewController = rootViewController;
        [self addChildViewController:rootViewController];
        [self.crviewControllerStack push:rootViewController];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.crvisualViewController.view];
    
    [self makePark];
    [self parkSunset];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    self.counter++;
    
//    [self crtransitionToViewController:({
//        FriDec18ViewController *controller = [[FriDec18ViewController alloc] init];
//        controller.title = [NSString stringWithFormat:@"friDec18 %ld", self.counter];
//        controller.view.backgroundColor = [UIColor randomColor];
//        [self addChildViewController:controller];
//        [self.crviewControllerStack push:controller];
//        controller;
//    })];
    
    [self crpushViewController:({
        FriDec18ViewController *controller = [[FriDec18ViewController alloc] init];
        controller.title = [NSString stringWithFormat:@"friDec18 %ld", self.level];
        controller.view.backgroundColor = [UIColor randomColor];
        [self addChildViewController:controller];
        [self.crviewControllerStack push:controller];
        controller;
    }) animated:YES];
}

- (void)testing{
    
    if( [self.crviewControllerStack count] > 1 ){
        [self crpopViewControllerAnimated:YES];
    }
}

- (void)crpushViewController:(UIViewController *)controller animated:(BOOL)animated{
    [self.operationQueue push:@[ CRNavigationControllerSeguePush, controller ]];
    self.level++;
    
    if( self.canOperation == YES )
        [self check];
}

- (void)crpopViewControllerAnimated:(BOOL)animated{
    if( self.level > 1 ){
        [self.operationQueue push:@[ CRNavigationControllerSeguePop ]];
        self.level--;
        
        if( self.canOperation == YES )
            [self check];
    }
}

- (void)check{
    NSArray *segue = [self.operationQueue pop];
    if( segue ){
        if( [(NSString *)segue.firstObject isEqualToString:CRNavigationControllerSeguePush] ){
            [self crtransitionToViewController:(UIViewController *)segue.lastObject];
        }else if( [(NSString *)segue.firstObject isEqualToString:CRNavigationControllerSeguePop] ){
            [self crtransitionToViewController:nil];
        }
    }else{
        self.canOperation = YES;
    }
}

- (void)crtransitionToViewController:(UIViewController *)toViewController{
    self.canOperation = NO;
    
    BOOL isPush;
    UIViewController *fromViewController;
    if( toViewController == nil ){
        isPush = NO;
        [self.crviewControllerStack pop];
        fromViewController = self.crvisualViewController;
        toViewController = (UIViewController *)[self.crviewControllerStack pop];
        
        fromViewController.view.frame = self.view.frame;
        toViewController.view.frame = CGRectMake(-(self.view.frame.size.width / 2.0f), 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view insertSubview:toViewController.view belowSubview:fromViewController.view];
        
        [self.titleLabel push:CRNavigationLeadingLabelTypePop title:toViewController.title];
    }else{
        isPush = YES;
        fromViewController = self.crvisualViewController;
        
        toViewController.view.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self.view insertSubview:toViewController.view belowSubview:self.park];
        
        [self.titleLabel push:CRNavigationLeadingLabelTypePush title:toViewController.title];
    }
    
    [UIView animateWithDuration:CR_SEGUE_DURATION
                          delay:0.0f
                        options:( 7 << 16 )
                     animations:^{
                         
                         if( isPush ){
                             fromViewController.view.frame = ({
                                 CGRect frame = self.view.frame;
                                 frame.origin.x = -(self.view.frame.size.width / 2);
                                 frame;
                             });
                             toViewController.view.frame = self.view.frame;
                         }else{
                             fromViewController.view.frame = ({
                                 CGRect frame = self.view.frame;
                                 frame.origin.x = self.view.frame.size.width;
                                 frame;
                             });
                             toViewController.view.frame = self.view.frame;
                         }
                         
                     }completion:^(BOOL f){
                         
                         [self.crvisualViewController.view removeFromSuperview];
                         if( !isPush ){
                             [self.crvisualViewController removeFromParentViewController];
                             [self.crviewControllerStack push:toViewController];
                         }
                         
                         self.crvisualViewController = toViewController;
                         
                         [self check];
                         
                     }];
}

- (void)parkSunset{
    self.park.layer.shadowOpacity = 0.27;
}

- (void)parkSunrise{
    self.park.layer.shadowOpacity = 0;
}

- (void)makePark{
    CGFloat parkHeight = 56.0f;
    self.park = ({
        UIView *park = [UIView new];
        park.translatesAutoresizingMaskIntoConstraints = NO;
        park.backgroundColor = [CRTheme themeColorFromString:@"blueberry"];
        [park makeShadowWithSize:CGSizeMake(0, 1) opacity:0 radius:1.7];
        park;
    });
    
    self.dismissButton = ({
        UIButton *dismiss = [[UIButton alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, parkHeight, parkHeight)];
        dismiss.backgroundColor = [UIColor clearColor];
        dismiss.titleLabel.font = [UIFont MaterialDesignIconsWithSize:24];
        [dismiss setTitle:[UIFont mdiArrowLeft] forState:UIControlStateNormal];
        [dismiss setTitleColor:[UIColor colorWithWhite:255 / 255.0 alpha:1] forState:UIControlStateNormal];
        [dismiss addTarget:self action:@selector(testing) forControlEvents:UIControlEventTouchUpInside];
        dismiss;
    });
    
    self.titleLabel = ({
        CRNavigationLeadingLabel *label = [[CRNavigationLeadingLabel alloc] initWithTitle:self.crrootViewController.title];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.duration = CR_SEGUE_DURATION;
        label;
    });
    
    [self.park addSubview:self.dismissButton];
    [self.park addSubview:self.titleLabel];
    [self.view addSubview:self.park];
    
    [self.park.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [self.park.widthAnchor constraintEqualToAnchor:self.view.widthAnchor].active = YES;
    [self.park.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.park.heightAnchor constraintEqualToConstant:STATUS_BAR_HEIGHT + parkHeight].active = YES;
    
    [self.titleLabel.heightAnchor constraintEqualToConstant:parkHeight].active = YES;
    [self.titleLabel.widthAnchor constraintEqualToConstant:180.0f].active = YES;
    [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.park.bottomAnchor].active = YES;
    [self.titleLabel.leftAnchor constraintEqualToAnchor:self.park.leftAnchor constant:56].active = YES;
}

@end
