//
//  CRVEPassCodeBtn.m
//  CRTestingProject
//
//  Created by caine on 12/31/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define CRVEPASSCODE_SIZE 80

#import "CRVEPassCodeBtn.h"
#import "UIView+CRView.h"

@interface CRVEPassCodeBtn()

@property( nonatomic, strong ) UIVisualEffectView *visual;
@property( nonatomic, strong ) UILabel *titleLabel;
@property( nonatomic, strong ) UILabel *conteLabel;

@end

@implementation CRVEPassCodeBtn

- (instancetype)initFromNumber:(NSUInteger)number effectStyle:(UIBlurEffectStyle)style{
    self = [super init];
    
    NSArray *words = @[
                       @"",
                       @"",
                       @"a b c",
                       @"d e f",
                       @"g h i",
                       @"j k l",
                       @"m n o",
                       @"p q r s",
                       @"t u v",
                       @"w x y z"
                       ];
    
    [self initClass:style];
    [self.titleLabel setText:[NSString stringWithFormat:@"%ld", number]];
    [self.conteLabel setText:number < 10 ? words[number] : words.firstObject];
    
    return self;
}

- (void)initClass:(UIBlurEffectStyle)style{
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.widthAnchor constraintEqualToConstant:CRVEPASSCODE_SIZE].active = YES;
    [self.heightAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
    [self letShadowWithPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CRVEPASSCODE_SIZE, CRVEPASSCODE_SIZE) cornerRadius:CRVEPASSCODE_SIZE / 2].CGPath
                       size:CGSizeMake(0, 1.7)
                    opacity:0.3f
                     radius:1.7f];
    
    
//    UIVisualEffectView *visualEffect = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
//    visualEffect.frame = CGRectMake(0, 0, CRVEPASSCODE_SIZE, CRVEPASSCODE_SIZE);
//    visualEffect.userInteractionEnabled = NO;
//    visualEffect.layer.cornerRadius = CRVEPASSCODE_SIZE / 2;
//    visualEffect.clipsToBounds = YES;
//    [self addSubview:visualEffect];
//    
//    self.visual = visualEffect;
    
    CGFloat (^dirtyHeight)(NSString *, UIFont *) = ^(NSString *string, UIFont *font){
        return [string boundingRectWithSize:CGSizeMake(1000, 1000)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:@{
                                              NSFontAttributeName: font
                                              }
                                    context:nil].size.height;
    };
    
    UIFont *titleFont = [UIFont fontWithName:@"Roboto-Light" size:38];
    UIFont *conteFont = [UIFont fontWithName:@"Roboto-Light" size:12];
    
    CGFloat titleLabelHeight = (NSUInteger)dirtyHeight(@"1", titleFont) - 8;
    CGFloat conteLabelHeight = (NSUInteger)dirtyHeight(@"a", conteFont);
    
//    CGFloat titleLabelHeight = 36;
//    CGFloat conteLabelHeight = 14;
    
    CGFloat offset = (CRVEPASSCODE_SIZE - (titleLabelHeight + conteLabelHeight)) / 2.0;
    
    self.titleLabel = ({
        UILabel *tl = [[UILabel alloc] initWithFrame:CGRectMake(0, offset, CRVEPASSCODE_SIZE, titleLabelHeight)];
        tl.font = titleFont;
        tl.textAlignment = NSTextAlignmentCenter;
        tl.textColor = style == UIBlurEffectStyleDark ? [UIColor whiteColor] : [UIColor blackColor];
        tl;
    });
    
    self.conteLabel = ({
        UILabel *cl = [[UILabel alloc] initWithFrame:CGRectMake(0, offset + titleLabelHeight, CRVEPASSCODE_SIZE, conteLabelHeight)];
        cl.font = conteFont;
        cl.textAlignment = NSTextAlignmentCenter;
        cl.textColor = style == UIBlurEffectStyleDark ? [UIColor whiteColor] : [UIColor blackColor];
        cl;
    });
    
//    [visualEffect.contentView addSubview:self.titleLabel];
//    [visualEffect.contentView addSubview:self.conteLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.conteLabel];
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    self.layer.cornerRadius = CRVEPASSCODE_SIZE / 2;
//    self.clipsToBounds = YES;
    
    [self addTarget:self action:@selector(letTouch:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(letTouch:) forControlEvents:UIControlEventTouchDragInside];
    [self addTarget:self action:@selector(letTouchCancel:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(letTouchCancel:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(letTouchCancel:) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(letTouchCancel:) forControlEvents:UIControlEventTouchDragOutside];
}

- (void)letTouch:(UIControl *)sender{
    self.highlighted = YES;
    [self letStateUpdate];
}

- (void)letTouchCancel:(UIControl *)sender{
    self.highlighted = NO;
    [self letStateUpdate];
}

- (void)letStateUpdate{
    if( self.state == UIControlStateHighlighted )
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
                             self.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:1];
                             self.conteLabel.textColor = [UIColor colorWithWhite:0 alpha:1];
                         }];
    else
        [UIView animateWithDuration:0.3f
                         animations:^{
                             self.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
                             self.titleLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
                             self.conteLabel.textColor = [UIColor colorWithWhite:1 alpha:1];
                         }];
}

@end
