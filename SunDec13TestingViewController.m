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

#import "CRKeyboardTesting.h"

@interface SunDec13TestingViewController()<UITextFieldDelegate>

@property( nonatomic, strong ) CRTransitionAnimationObject *transitionObject;
@property( nonatomic, strong ) UIButton *dismissButton;
@property( nonatomic, strong ) UITextField *textField;

@property( nonatomic, strong ) UIView *keyboardView;

@end

@implementation SunDec13TestingViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.transitionObject = [CRTransitionAnimationObject defaultCRTransitionAnimation];
    
    self.dismissButton = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 56 + 20)];
        button.backgroundColor = [UIColor randomColor];
        [button addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    self.textField = ({
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 20 + 56 + 72, self.view.frame.size.width - 16, 48)];
        textField.backgroundColor = [UIColor randomColor];
        textField.delegate = self;
        [self.view addSubview:textField];
        textField;
    });
    
    NSString *testString = @"12adaadasdsadsadasdasdasdasdasdasdasdasddsakf.nrwkgjrnef kjerbvkjdaskdnas,dmasdasasdasds";
    CGFloat LENMAX = 3000;
    CGFloat width  = self.view.frame.size.width / 2;
    CGSize  size   = CGSizeMake(width, LENMAX);
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 4, 280, self.view.frame.size.width / 2, 100)];
    text.numberOfLines = 0;
    text.backgroundColor = [UIColor randomColor];
    
    text.text = testString;
    
//    [text sizeToFit];
    
    [self.view addSubview:text];
    
    CGRect stringRect = [testString boundingRectWithSize:size
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:@{
                                                           NSFontAttributeName: text.font
                                                           }
                                                 context:nil];
    
    [text sizeThatFits:stringRect.size];
    
    void (^logFrame)(CGRect) = ^(CGRect frame){
        NSLog(@"x: %lf, y: %lf, w: %lf, h: %lf", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    };
    
//    logFrame( stringRect );

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

- (void)dismissSelf{
    CRKeyboardTesting *testing = [CRKeyboardTesting new];
    testing.transitioningDelegate = self.transitionObject;
    [self presentViewController:testing animated:YES completion:nil];
}

@end
