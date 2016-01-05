//
//  SunDec13TestingViewController.m
//  CRTestingProject
//
//  Created by caine on 12/13/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "SunDec13TestingViewController.h"

#import "UIColor+CRColor.h"
#import "CRTransitionAnimationObject.h"

#import "CRSearchFieldController.h"
#import "CRTestingFunc.h"
#import "CRKeyboardTesting.h"
#import "KMCGeigerCounter.h"
#import "UIColor+CRTheme.h"

#import "UIBGButton.h"
#import "CATextLabel.h"

@interface SunDec13TestingViewController()<UITextFieldDelegate>

@property( nonatomic, strong ) CRTransitionAnimationObject *transitionObject;
@property( nonatomic, strong ) UIButton *dismissButton;
@property( nonatomic, strong ) UITextField *textField;

@property( nonatomic, strong ) UIView *keyboardView;

@end

@implementation SunDec13TestingViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor themeColorFromString:CRThemeColorDefault];
    
//    UIBGButton *test = [[UIBGButton alloc] init];
//    test.frame = CGRectMake(0, STATUS_BAR_HEIGHT + 56 + 10, self.view.frame.size.width, 30);
//    test.titleLabel.textColor = [UIColor blackColor];
//    test.highlightTextColor = [UIColor colorWithWhite:0 alpha:0.8];
//    test.highlightColor = [UIColor colorWithWhite:0.8 alpha:1];
//    test.titleLabel.text = @"FUCK";
//    [self.view addSubview:test];
    
    self.transitionObject = [CRTransitionAnimationObject defaultCRTransitionAnimation];
    
    self.dismissButton = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 56 + 20)];
        button.backgroundColor = [UIColor randomColor];
        [button addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    NSString *test = @"The CAAnimation and CALayer classes lets you access the fields of selected data structures using key paths. This feature is a convenient way to specify the field of a data structure that you want to animate. You can also use these conventions in conjunction with the setValue:forKeyPath: and valueForKeyPath: methods to set and get those fields.";
    
    CATextLayer *tl = [CATextLabel layerFromRect:CGRectMake(16, 100, self.view.frame.size.width - 32, 56) string:test font:[UIFont fontWithName:@"Roboto-thin" size:12]];
    
    tl.backgroundColor = [UIColor randomColor].CGColor;
    [self.view.layer addSublayer:tl];
    
    
    
}

- (void)didKeyboardShow{
    
    void (^logFrame)(CGRect) = ^(CGRect frame){
        NSLog(@"x: %lf, y: %lf, w: %lf, h: %lf", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    };
    
    for( UIWindow *window in [[UIApplication sharedApplication] windows] ){
        if( [window isKindOfClass:NSClassFromString(@"UIRemoteKeyboardWindow")] ){
            for( UIView *subview in window.subviews ){
                if( [subview isKindOfClass:NSClassFromString(@"UIInputSetContainerView")] ){
                    for( UIView *subsubview in subview.subviews ){
                        if( [subsubview isKindOfClass:NSClassFromString(@"UIInputSetHostView")] ){
                            self.keyboardView = subsubview;
                        }
                    }
                }
            }
        }
    }
    
    CGRect frame = self.keyboardView.frame;
    logFrame(frame);
    frame.origin.x = self.view.frame.size.width;
    [UIView animateWithDuration:0.25f
                     animations:^{
                         self.keyboardView.frame = frame;
                     }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"begin");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [CRTestingFunc shareTesingFunc].enable = YES;
    [KMCGeigerCounter sharedGeigerCounter].enabled = YES;
}

- (void)dismissSelf{
    CRKeyboardTesting *testing = [CRKeyboardTesting new];
    testing.transitioningDelegate = self.transitionObject;
    
    CRSearchFieldController *search = [[CRSearchFieldController alloc] init];
    search.transitioningDelegate = self.transitionObject;
    
    [self presentViewController:search animated:YES completion:nil];
}

@end
