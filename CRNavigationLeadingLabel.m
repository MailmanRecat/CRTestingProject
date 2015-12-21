//
//  CRNavigationLeadingLabel.m
//  CRTestingProject
//
//  Created by caine on 12/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRNavigationLeadingLabel.h"
#import "CRQueue.h"
#import "CRStack.h"

static NSString *const CR_N_L_PUSH_Key = @"CR_NAVIGATION_LEADING_LABEL_PUSH";
static NSString *const CR_N_L_POP_Key  = @"CR_NAVIGATION_LEADING_LABEL_POP";

@interface CRNavigationLeadingLabel()

@property( nonatomic, strong ) CRQueue *queue;
@property( nonatomic, assign ) BOOL isFucking;

@property( nonatomic, assign ) CGFloat leftEdgeAnchor;
@property( nonatomic, assign ) CGFloat distance;

@property( nonatomic, strong ) UILabel *leading;
@property( nonatomic, strong ) NSLayoutConstraint *leadingGuide;
@property( nonatomic, strong ) UILabel *trailing;
@property( nonatomic, strong ) NSLayoutConstraint *trailingGuide;

@end

@implementation CRNavigationLeadingLabel

- (instancetype)init{
    self = [super init];
    if( self ){
        
        self.duration = 0.5f;
        self.queue = [[CRQueue alloc] init];
        self.leftEdgeAnchor = 10;
        self.distance = 60;
        
        UILabel *label;
        self.leading = ({
            label = [UILabel new];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label;
        });
        self.trailing = ({
            label = [UILabel new];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            label;
        });
        
        [self addSubview:self.leading];
        [self addSubview:self.trailing];
        [self.leading.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [self.leading.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        [self.leading.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [self.trailing.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [self.trailing.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
        [self.trailing.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        
        self.leadingGuide = [self.leading.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.leftEdgeAnchor];
        self.trailingGuide = [self.trailing.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:self.leftEdgeAnchor + self.distance];
        self.leadingGuide.active = self.trailingGuide.active = YES;
        
        self.trailing.font = self.leading.font = [UIFont systemFontOfSize:21 weight:UIFontWeightMedium];
        self.trailing.textColor = self.leading.textColor = [UIColor whiteColor];
        
        self.trailing.alpha = 0;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title{
    return ({
        self = [self init];
        self.leading.text = title;
        self;
    });
}

- (void)setFont:(UIFont *)font color:(UIColor *)color{
    self.leading.font = self.trailing.font = font;
    self.leading.textColor = self.trailing.textColor = color;
}

- (void)setLeftEdgeAnchor:(CGFloat)anchor distance:(CGFloat)distance{
    self.leftEdgeAnchor = anchor;
    self.distance = distance;
    self.leadingGuide.constant = anchor;
    self.trailingGuide.constant = anchor + distance;
}

- (void)push:(CRNavigationLeadingLabelType)type title:(NSString *)title{
    
    [self.queue push:@[ ({
        type == CRNavigationLeadingLabelTypePush ? CR_N_L_PUSH_Key: CR_N_L_POP_Key;
    }), title ]];
    
    [self fuck];
}

- (void)fuck{
    if( self.isFucking ) return;
    
    [self check];
}

- (void)check{
    NSArray *task = [self.queue pop];
    if( task )
        [self animationType:(NSString *)task.firstObject title:(NSString *)task.lastObject];
    else
        self.isFucking = NO;
}

- (void)animationType:(NSString *)type title:(NSString *)title{
    self.isFucking = YES;
    
    self.trailing.text = title;
    self.trailing.alpha = 0;
    if( [type isEqualToString:CR_N_L_PUSH_Key] ){
        self.leadingGuide.constant = self.leftEdgeAnchor - self.distance;
    }else{
        self.trailingGuide.constant = self.leftEdgeAnchor - self.distance;
        [self layoutIfNeeded];
        self.leadingGuide.constant = self.leftEdgeAnchor + self.distance;
    }
    
    self.trailingGuide.constant = 10;
    
    [UIView animateWithDuration:self.duration * 0.5f
                          delay:0.0f
                        options:( 7 << 16 )
                     animations:^{
                         self.leading.alpha = 0;
                         self.trailing.alpha = 1;
                         [self layoutIfNeeded];
                         
                     }completion:^(BOOL f){
                         self.leading.text = title;
                         self.leadingGuide.constant = self.leftEdgeAnchor;
                         self.trailingGuide.constant = self.leftEdgeAnchor + self.distance;
                         self.leading.alpha = 1;
                         self.trailing.alpha = 0;
                         [self layoutIfNeeded];
                         
                         [self check];
                     }];
}

@end
