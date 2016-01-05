//
//  CRVisualPeak.m
//  CRNote
//
//  Created by caine on 12/30/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "CRVisualPeak.h"
#import "UIFont+MaterialDesignIcons.h"

@interface CRVisualPeak()

@property( nonatomic, strong ) NSLayoutConstraint *selfLayoutGuide;

@end

@implementation CRVisualPeak

- (instancetype)initFromEffectStyle:(UIBlurEffectStyle)style{
    self = [super initWithEffect:[UIBlurEffect effectWithStyle:style]];
    
    [self initClass:style];
    
    return self;
}

- (NSArray<UIButton *> *)btns{
    if( !self.remove || !self.lock || !self.font || !self.photo || !self.palette || !self.save || !self.paste || !self.copying || !self.keyboard || !self.message )
        return nil;
    
    return @[ self.remove, self.lock, self.font, self.photo, self.palette, self.save, self.paste, self.copying, self.keyboard, self.message ];
}

- (void)setNotification:(NSString *)notification{
    if( notification == _notification ) return;
    _notification = notification;
    
    [self.message setTitle:notification forState:UIControlStateNormal];
    if( notification ){
        [self layoutSelf:CR_VISUAL_PEAK_HEIGHT * 2 title:notification];
    }else
        [self layoutSelf:CR_VISUAL_PEAK_HEIGHT title:notification];
}

- (void)layoutSelf:(CGFloat)height title:(NSString *)title{
    [self.message layoutIfNeeded];
    self.selfLayoutGuide.constant = height;
    
    if( title ) self.message.hidden = NO;
    self.message.alpha = title ? 0 : 1;
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:(7 << 16)
                     animations:^{
                         
                         self.message.alpha = title ? 1 : 0;
                         
                         [self.superview layoutIfNeeded];
                     }completion:^(BOOL f){
                         if( !title ) self.message.hidden = YES;
                     }];
}

- (void)setEnbleSubbtn:(BOOL)enbleSubbtn{
    if( _enbleSubbtn == enbleSubbtn ) return;
    _enbleSubbtn = enbleSubbtn;
    
    if( enbleSubbtn ){
        self.paste.alpha = self.copying.alpha = self.keyboard.alpha = 0;
        self.paste.hidden = self.copying.hidden = self.keyboard.hidden = NO;
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.paste.alpha = self.copying.alpha = self.keyboard.alpha = 1;
                             self.remove.alpha = self.lock.alpha = self.font.alpha = self.photo.alpha = self.palette.alpha = self.save.alpha = 0;
                         }completion:^(BOOL f){
                             self.remove.hidden = self.lock.hidden = self.font.hidden = self.photo.hidden = self.palette.hidden = self.save.hidden = YES;
                         }];
    }else{
        self.remove.hidden = self.lock.hidden = self.font.hidden = self.photo.hidden = self.palette.hidden = self.save.hidden = NO;
        [UIView animateWithDuration:0.25f
                         animations:^{
                             self.paste.alpha = self.copying.alpha = self.keyboard.alpha = 0;
                             self.remove.alpha = self.lock.alpha = self.font.alpha = self.photo.alpha = self.palette.alpha = self.save.alpha = 1;
                         }completion:^(BOOL f){
                             self.paste.hidden = self.copying.hidden = self.keyboard.hidden = YES;
                         }];
    }
}

- (void)initClass:(UIBlurEffectStyle)style{
    __block UIButton *btn;
    UIButton *(^letbtn)(NSString *, NSUInteger) = ^(NSString *tit, NSUInteger tag){
        btn = [[UIButton alloc] init];
        [btn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [btn setTag:CR_BISUAL_PEAK_BUTTON_BASIC_TAG + tag];
        [btn.titleLabel setFont:[UIFont MaterialDesignIconsWithSize:24]];
        [btn setTitle:tit forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:249 / 255.0 alpha:1] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithWhite:249 / 255.0 alpha:0.7] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor colorWithWhite:249 / 255.0 alpha:0.7] forState:UIControlStateDisabled];
        return btn;
    };
    
    self.remove   = letbtn([UIFont mdiDelete],        0);
    self.lock     = letbtn([UIFont mdiLock],          1);
    self.font     = letbtn([UIFont mdiParking],       2);
    self.photo    = letbtn([UIFont mdiFileImageBox],  3);
    self.palette  = letbtn([UIFont mdiCheckboxBlankCircle], 4);
    self.save     = letbtn([UIFont mdiPackageDown],   5);
    self.paste    = letbtn([UIFont mdiContentPaste],  6);
    self.copying  = letbtn([UIFont mdiContentCopy],   7);
    self.keyboard = letbtn([UIFont mdiKeyboardClose], 8);
    self.message  = ({
        UIButton *button = letbtn(nil,                9);
        [self.contentView addSubview:button];
//        [button.titleLabel setFont:[CRNoteApp appFontOfSize:16 weight:UIFontWeightRegular]];
        [button setTitleColor:[UIColor colorWithWhite:237 / 255.0 alpha:1] forState:UIControlStateNormal];
        [button setContentEdgeInsets:UIEdgeInsetsMake(0, 16, 0, -16)];
        [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [button.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
        [button.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
        [button.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
        [button.heightAnchor constraintEqualToConstant:CR_VISUAL_PEAK_HEIGHT].active = YES;
        button;
    });
    
    __block NSLayoutAnchor *contrastAnchor;
    [@[ self.remove, self.lock, self.font, self.photo, self.palette, self.save ] enumerateObjectsUsingBlock:
     ^(UIView *btn, NSUInteger index, BOOL *sS){
         [self.contentView addSubview:btn];
         
         if( index == 0 )
             contrastAnchor = self.contentView.leftAnchor;
         
         [btn.heightAnchor constraintEqualToConstant:CR_VISUAL_PEAK_HEIGHT].active = YES;
         [btn.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:(1 / 6.0)].active = YES;
         [btn.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
         [btn.leftAnchor constraintEqualToAnchor:contrastAnchor].active = YES;
         
         contrastAnchor = btn.rightAnchor;
     }];
    
    [@[ self.paste, self.copying, self.keyboard ] enumerateObjectsUsingBlock:^(UIView *btn, NSUInteger index, BOOL *sS){
        [self.contentView addSubview:btn];
        
        if( index == 0 )
            contrastAnchor = self.contentView.leftAnchor;
        
        btn.hidden = YES;
        [btn.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
        [btn.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor multiplier:(1 / 3.0)].active = YES;
        [btn.heightAnchor constraintEqualToConstant:CR_VISUAL_PEAK_HEIGHT].active = YES;
        [btn.leftAnchor constraintEqualToAnchor:contrastAnchor].active = YES;
        
        contrastAnchor = btn.rightAnchor;
    }];
    
    self.selfLayoutGuide = [self.heightAnchor constraintEqualToConstant:CR_VISUAL_PEAK_HEIGHT];
    self.selfLayoutGuide.active = YES;
}

@end
