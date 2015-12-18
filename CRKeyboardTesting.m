//
//  CRKeyboardTesting.m
//  CRTestingProject
//
//  Created by caine on 12/13/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRKeyboardTesting.h"

#import "UIColor+CRColor.h"
#import "CRTransitionAnimationObject.h"

@interface CRKeyboardTesting()<UITextFieldDelegate>{
    void (^logFrame)(NSString *, CGRect);
}

@property( nonatomic, strong ) UIButton *dismissButton;
@property( nonatomic, strong ) UITextField *textField;
@property( nonatomic, strong ) UIView *keyboardView;

@end

@implementation CRKeyboardTesting

- (instancetype)init{
    self = [super init];
    if( self ){
        logFrame = ^(NSString *name, CGRect frame){
            NSLog(@"-----------------");
            NSLog(@"\n %@\n x: %lf\n y: %lf\n w: %lf\n h: %lf\n", name, frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
            NSLog(@"-----------------");
        };
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dismissButton = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 56 + 20)];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.backgroundColor = [UIColor randomColor];
        [button addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    [self.dismissButton.widthAnchor constraintEqualToAnchor:self.view.widthAnchor multiplier:1.0].active = YES;
    [self.dismissButton.heightAnchor constraintEqualToConstant:100].active = YES;
    
    UIButton *btn = ({
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(8, 20 + 56 + 20 + 56, self.view.frame.size.width - 16, 56)];
        button.backgroundColor = [UIColor randomColor];
        [button addTarget:self action:@selector(endListen) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        button;
    });
    
    UITextField *textField = ({
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(8, 20 + 56 + 20, self.view.frame.size.width - 16, 48)];
        textField.layer.borderColor = [UIColor blackColor].CGColor;
        textField.layer.borderWidth = 2.0f;
        textField.delegate = self;
        textField;
    });
    [self.view addSubview:textField];
    self.textField = textField;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willKeyboardShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
//    [self.transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context){
//        NSLog(@"context");
//        if( ![context isCancelled] ){
//            [self.keyboardView.superview removeFromSuperview];
//        }
//    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    NSLog(@"%@", self.keyboardView);
    
    __block CGRect frame = self.keyboardView.frame;
    frame.origin.x = self.view.frame.size.width;
    
    NSLog(@"%@", self.textField);
    
    [self.transitionCoordinator animateAlongsideTransitionInView:self.keyboardView
                                                       animation:^(id<UIViewControllerTransitionCoordinatorContext> context){
                                                           self.keyboardView.frame = frame;
                                                       }completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
                                                           self.keyboardView.hidden = YES;
                                                           [self.textField resignFirstResponder];
                                                       }];
    
//    [self.transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context){
//        NSLog(@"context");
//        if (![context isCancelled]) {
//            [self.keyboardView removeFromSuperview];
//        }
//    }];
}

- (void)willKeyboardShow{
    
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
    
}

- (void)didKeyboardShow{
    
    void (^logFrame)(CGRect) = ^(CGRect frame){
        NSLog(@"x: %lf, y: %lf, w: %lf, h: %lf", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    };
    
    NSLog(@"did show");
    
//    CGRect frame = self.keyboardView.frame;
//    
//    frame.origin.x = 100;
//    [UIView animateWithDuration:1.0f
//                     animations:^{
//                         self.keyboardView.frame = frame;
//                     }];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}

- (void)endListen{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)dismissSelf{
//    [UIView animateWithDuration:0.25f
//                          delay:0.0f
//                        options:( 7 << 16 )
//                     animations:^{
//                         self.keyboardView.frame = frame;
//                     } completion:^(BOOL finished){
//                     }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
