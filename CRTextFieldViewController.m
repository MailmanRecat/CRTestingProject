//
//  CRTextFieldViewController.m
//  CRClassSchedule
//
//  Created by caine on 12/2/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height

#import "CRTextFieldViewController.h"
#import "UIView+CRView.h"
#import "UIFont+MaterialDesignIcons.h"

@interface CRTextFieldViewController ()<UITextFieldDelegate>

@property( nonatomic, strong ) UIView *park;
@property( nonatomic, strong ) UIButton *parkLeftButton;
@property( nonatomic, strong ) UITextField *parkTextField;

@property( nonatomic, strong ) UIView *keyboardView;

@property( nonatomic, strong ) UIView *bottomBear;
@property( nonatomic, strong ) NSLayoutConstraint *bottomBearLayoutGuide;
@property( nonatomic, strong ) UIButton *doneButton;

@end

@implementation CRTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self doPark];
    [self makeBottomBear];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willKeyboardShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(willKeyBoardChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    self.parkTextField.placeholder = self.placeholderString;
    self.parkTextField.tintColor = self.tintColor;
    self.parkTextField.returnKeyType = self.returnKeyType;
}

- (void)viewDidAppear:(BOOL)animated{
    [self.parkTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    __block CGRect frame = self.keyboardView.frame;
    frame.origin.x = self.view.frame.size.width;
    
    [self.transitionCoordinator animateAlongsideTransitionInView:self.keyboardView
                                                       animation:^(id<UIViewControllerTransitionCoordinatorContext> context){
                                                           
                                                           self.keyboardView.frame = frame;
                                                       }completion:^(id<UIViewControllerTransitionCoordinatorContext> context){
                                                           
                                                           self.keyboardView.hidden = YES;
                                                       }];
}

- (void)doPark{
    
    CGFloat parkHeight = 48;
    
    self.park = ({
        UIView *park = [UIView new];
        park.translatesAutoresizingMaskIntoConstraints = NO;
        park.backgroundColor = [UIColor whiteColor];
        park.layer.cornerRadius = 3.0f;
        [park letShadowWithSize:CGSizeMake(0, 1) opacity:0.17 radius:1.7];
        park;
    });
    [self.view addSubview:self.park];
    
    self.parkLeftButton = ({
        UIButton *dismiss = [UIButton new];
        dismiss.translatesAutoresizingMaskIntoConstraints = NO;
        dismiss.layer.cornerRadius = parkHeight / 2.0f;
        dismiss.titleLabel.font = [UIFont MaterialDesignIconsWithSize:21];
        [dismiss setTitle:[UIFont mdiArrowLeft] forState:UIControlStateNormal];
        [dismiss setTitleColor:[UIColor colorWithWhite:137 / 255.0 alpha:1] forState:UIControlStateNormal];
        [dismiss addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        dismiss;
    });
    [self.park addSubview:self.parkLeftButton];
    
    self.parkTextField = ({
        UITextField *textField = [UITextField new];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.delegate = self;
        textField;
    });
    [self.park addSubview:self.parkTextField];
    
    [CRLayout view:@[ self.park, self.view ] type:CREdgeTopLeftRight constants:UIEdgeInsetsMake(STATUS_BAR_HEIGHT + 8, 8, 0, -8)];
    [CRLayout view:@[ self.park ] type:CRFixedHeight constants:UIEdgeInsetsMake(0, parkHeight, 0, 0)];
    [CRLayout view:@[ self.parkLeftButton, self.park ] type:CREdgeTopLeftBottom constants:UIEdgeInsetsMake(0, 0, 0, 0)];
    [CRLayout view:@[ self.parkLeftButton ] type:CRFixedWidth constants:UIEdgeInsetsMake(parkHeight, 0, 0, 0)];
    [CRLayout view:@[ self.parkTextField, self.park ] type:CREdgeAround constants:UIEdgeInsetsMake(0, parkHeight, 0, 0)];
}

- (void)makeBottomBear{
    self.bottomBear = ({
        UIView *bear = [UIView new];
        bear.translatesAutoresizingMaskIntoConstraints = NO;
        bear.backgroundColor = [UIColor whiteColor];
        [bear makeShadowWithSize:CGSizeMake(0, -1) opacity:0.07 radius:3];
        bear;
    });
    [self.view addSubview:self.bottomBear];
    
    self.doneButton = ({
        UIButton *done = [UIButton new];
        done.translatesAutoresizingMaskIntoConstraints = NO;
        done.backgroundColor = [UIColor whiteColor];
//        done.titleLabel.font = [CRSettings appFontOfSize:19 weight:UIFontWeightRegular];
        [done setTitle:@"Done" forState:UIControlStateNormal];
        [done setTitleColor:[UIColor colorWithWhite:97 / 255.0 alpha:1] forState:UIControlStateNormal];
        [done addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        done;
    });
    [self.bottomBear addSubview:self.doneButton];
    
    [CRLayout view:@[ self.bottomBear, self.view ] type:CREdgeLeftRight];
    [CRLayout view:@[ self.bottomBear ] type:CRFixedHeight constants:UIEdgeInsetsMake(0, 48, 0, 0)];
//    self.bottomBearLayoutGuide = [CRLayout view:@[ self.bottomBear, self.view ]
//                                      attribute:NSLayoutAttributeBottom
//                                       relateBy:NSLayoutRelationEqual
//                                      attribute:NSLayoutAttributeBottom
//                                     multiplier:1.0
//                                       constant:0];
    [self.view addConstraint:self.bottomBearLayoutGuide];
//    [CRLayout view:@[ self.doneButton, self.bottomBear ] type:CREdgeAround];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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

- (void)willKeyBoardChangeFrame:(NSNotification *)keyboardInfo{
    NSDictionary *info = [keyboardInfo userInfo];
    CGFloat constant = self.view.frame.size.height - [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].origin.y;
    CGFloat duration = [info[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    UIViewAnimationOptions option = [info[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    self.bottomBearLayoutGuide.constant = -constant;
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:option
                     animations:^{
                         [self.view layoutIfNeeded];
                     }
                     completion:^(BOOL isFinished){}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:^{
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIKeyboardWillChangeFrameNotification
                                                      object:nil];
        
        if( self.handler && [self.handler respondsToSelector:@selector(CRTextFieldVCDidDismiss:)] )
            [self.handler CRTextFieldVCDidDismiss:self.parkTextField.text];
    }];
}

@end
