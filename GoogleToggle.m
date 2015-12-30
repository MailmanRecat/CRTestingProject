//
//  GoogleToggle.m
//  CRNote
//
//  Created by caine on 12/29/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define GOOGOLE_TOGGLE_SWIPE_SENSITIVITY 100

#import "GoogleToggle.h"
#import "UIView+CRView.h"
#import "UIColor+CRTheme.h"

@interface GoogleToggle()

@property( nonatomic, assign ) CGFloat operationQueue;

@property( nonatomic, strong ) UIView  *wall;
@property( nonatomic, strong ) UIView  *tipHat;
@property( nonatomic, strong ) UILabel *tip;
@property( nonatomic, strong ) NSLayoutConstraint *tipLayoutGuide;

@property( nonatomic, assign ) CGFloat panStartX;
@property( nonatomic, assign ) CGFloat panEndX;
@property( nonatomic, assign ) BOOL    panStatusTick;

@property( nonatomic, weak   ) id  target;
@property( nonatomic, assign ) SEL action;

@end

@implementation GoogleToggle

- (instancetype)init{
    self = [super init];
    if( self ){
        [self initClass];
        [self addTarget:self action:@selector(letToggle) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithTarget:(id)target action:(SEL)action{
    self = [self init];
    
    self.target = target;
    self.action = action;
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return self;
}

- (void)addTarget:(id)target action:(SEL)action{
    self.target = target;
    self.action = action;
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setEnable:(BOOL)enable{
    if( _enable == enable ) return;
    _enable = enable;
    
    self.tipLayoutGuide.constant = enable ? GOOGLE_TOGGLE_WIDTH - GOOGLE_TOOGLE_HEIGHT : 0;
    [UIView animateWithDuration:0.25f
                     animations:^{
                         
                        [self enable] ? [self letTipStatusEnable] : [self letTipStatusDisable];
                        [self.tipHat layoutIfNeeded];
                         
                     }completion:^(BOOL f){
                         --self.operationQueue == 0 ? nil : [self toggle];
                     }];
}

- (void)setTipTheme:(UIColor *)tipTheme{
    _tipTheme = tipTheme;
    
    self.enable ? (self.tip.textColor = tipTheme) : (self.tip.backgroundColor = tipTheme);
}

- (void)setFont:(UIFont *)font{
    _font = font;
    
    self.tip.font = font;
}

- (void)setEnableString:(NSString *)enableString{
    _enableString = enableString;
    
    if( self.enable ) self.tip.text = enableString;
}

- (void)setDisableString:(NSString *)disableString{
    _disableString = disableString;
    
    if( !self.enable ) self.tip.text = disableString;
}

- (void)letToggle{
    self.operationQueue++;
    
    if( self.operationQueue == 1 )
        [self toggle];
}

- (void)toggle{
    self.enable = self.enable ? NO : YES;
}

- (void)letTipStatusUpdate{
    if( self.tipLayoutGuide.constant < (GOOGLE_TOGGLE_WIDTH - GOOGLE_TOOGLE_HEIGHT) / 2.0 ){
        [self letTipStatusDisable];
        _enable = NO;
    }else{
        [self letTipStatusEnable];
        _enable = YES;
    }
    
    [self.tipHat layoutIfNeeded];
}

- (void)letTipStatusEnable{
    self.wall.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    self.tip.backgroundColor = [UIColor whiteColor];
    self.tip.textColor = self.tipTheme;
    self.tip.text = self.enableString;
}

- (void)letTipStatusDisable{
    self.wall.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    self.tip.backgroundColor = self.tipTheme;
    self.tip.textColor = [UIColor whiteColor];
    self.tip.text = self.disableString;
}

- (void)letSwipe:(UIPanGestureRecognizer *)pan{
    if( pan.state == UIGestureRecognizerStateBegan ){
        self.panStartX = [pan locationInView:self].x;
        self.panStatusTick = self.enable;
    }
    else if( pan.state == UIGestureRecognizerStateChanged ){
        self.panEndX = [pan locationInView:self].x;
        
        CGFloat maxLen = GOOGLE_TOGGLE_WIDTH - GOOGLE_TOOGLE_HEIGHT;
        CGFloat distantce = fabs(self.panEndX - self.panStartX) / GOOGOLE_TOGGLE_SWIPE_SENSITIVITY;
        if( self.panEndX < 0 && self.tipLayoutGuide.constant > 0 ){
            self.tipLayoutGuide.constant = self.tipLayoutGuide.constant -  distantce < 0 ? 0 : self.tipLayoutGuide.constant - distantce;
            [self letTipStatusUpdate];
        }
        else if( self.panEndX > 0 && self.tipLayoutGuide.constant < maxLen ){
            self.tipLayoutGuide.constant = self.tipLayoutGuide.constant + distantce > maxLen ? maxLen : self.tipLayoutGuide.constant + distantce;
            [self letTipStatusUpdate];
        }
    }
    else if( pan.state == UIGestureRecognizerStateEnded ){
        
        if( self.tipLayoutGuide.constant != 0 || self.tipLayoutGuide.constant != (GOOGLE_TOGGLE_WIDTH - GOOGLE_TOOGLE_HEIGHT) ){
            
            self.tipLayoutGuide.constant = self.tipLayoutGuide.constant < (GOOGLE_TOGGLE_WIDTH - GOOGLE_TOOGLE_HEIGHT) / 2.0 ? 0 : (GOOGLE_TOGGLE_WIDTH - GOOGLE_TOOGLE_HEIGHT);
            
            [self letTipStatusUpdate];
        }
        
        if( self.target && self.action && (self.panStatusTick != self.enable) ){
            ((void (*)(id, SEL))[self.target methodForSelector:self.action])(self.target, self.action);
        }
    }
}

- (void)initClass{
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.widthAnchor constraintEqualToConstant:GOOGLE_TOGGLE_WIDTH].active = YES;
    [self.heightAnchor constraintEqualToConstant:GOOGLE_TOOGLE_HEIGHT].active = YES;
    
    self.wall = ({
        CGFloat edgeInset = 8;
        UIView *bridge = [[UIView alloc] init];
        bridge.translatesAutoresizingMaskIntoConstraints = NO;
        bridge.userInteractionEnabled = NO;
        bridge.layer.cornerRadius = (GOOGLE_TOOGLE_HEIGHT - edgeInset) / 2.0f;
        bridge.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self addSubview:bridge];
        [bridge.widthAnchor constraintEqualToConstant:GOOGLE_TOGGLE_WIDTH - edgeInset].active = YES;
        [bridge.heightAnchor constraintEqualToConstant:GOOGLE_TOOGLE_HEIGHT - edgeInset].active = YES;
        [bridge.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        [bridge.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        bridge;
    });
    
    self.tipHat = ({
        UIView *hat = [[UIView alloc] init];
        hat.translatesAutoresizingMaskIntoConstraints = NO;
        hat.userInteractionEnabled = NO;
        hat.layer.cornerRadius = GOOGLE_TOOGLE_HEIGHT / 2.0f;
        [hat makeShadowWithSize:CGSizeMake(0.0f, 1.7f) opacity:0.3f radius:1.7f];
        [self addSubview:hat];
        [hat.widthAnchor constraintEqualToConstant:GOOGLE_TOOGLE_HEIGHT].active = YES;
        [hat.heightAnchor constraintEqualToAnchor:hat.widthAnchor].active = YES;
        [hat.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
        self.tipLayoutGuide = [hat.leftAnchor constraintEqualToAnchor:self.leftAnchor];
        self.tipLayoutGuide.active = YES;
        hat;
    });
    
    self.tip = ({
        UILabel *tip = [[UILabel alloc] init];
        tip.translatesAutoresizingMaskIntoConstraints = NO;
        tip.layer.masksToBounds = YES;
        tip.layer.cornerRadius = GOOGLE_TOOGLE_HEIGHT / 2.0f;
        tip.textColor = [UIColor whiteColor];
        tip.textAlignment = NSTextAlignmentCenter;
        [self.tipHat addSubview:tip];
        [tip.widthAnchor constraintEqualToAnchor:self.tipHat.widthAnchor].active = YES;
        [tip.heightAnchor constraintEqualToAnchor:self.tipHat.heightAnchor].active = YES;
        [tip.centerXAnchor constraintEqualToAnchor:self.tipHat.centerXAnchor].active = YES;
        [tip.centerYAnchor constraintEqualToAnchor:self.tipHat.centerYAnchor].active = YES;
        tip;
    });
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(letSwipe:)];
    [self addGestureRecognizer:pan];
    
    self.tipTheme = [UIColor themeColorFromString:CRThemeColorDefault];
}

@end
