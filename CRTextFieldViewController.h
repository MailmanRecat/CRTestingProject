//
//  CRTextFieldViewController.h
//  CRClassSchedule
//
//  Created by caine on 12/2/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CRTextFieldVCHandler <NSObject>

- (void)CRTextFieldVCDidDismiss:(NSString *)textFieldString;

@end

@interface CRTextFieldViewController : UIViewController

@property( nonatomic, weak ) id<CRTextFieldVCHandler> handler;

@property( nonatomic, strong ) NSString *placeholderString;
@property( nonatomic, strong ) UIColor *tintColor;
@property( nonatomic, assign ) UIReturnKeyType returnKeyType;

@end
