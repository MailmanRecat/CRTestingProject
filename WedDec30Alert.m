//
//  WedDec30Alert.m
//  CRTestingProject
//
//  Created by caine on 12/30/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "WedDec30Alert.h"

@interface WedDec30Alert()

@end

@implementation WedDec30Alert

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    iv.image = [UIImage imageNamed:@"MM7.jpg"];
    [self.view addSubview:iv];
    
    UIView *content = [[UIView alloc] init];
    content.translatesAutoresizingMaskIntoConstraints = NO;
    content.backgroundColor = [UIColor clearColor];
    content.layer.cornerRadius = 56 / 2.0f;
    [content makeShadowWithSize:CGSizeMake(0, 1.7) opacity:0.17f radius:1.7];
    [self.view addSubview:content];
    [content.widthAnchor constraintEqualToConstant:56].active = YES;
    [content.heightAnchor constraintEqualToConstant:56].active = YES;
    [content.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16].active = YES;
    [content.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-52 - 16].active = YES;
    
    UIVisualEffectView *effect = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    effect.translatesAutoresizingMaskIntoConstraints = NO;
    [content addSubview:effect];
    effect.clipsToBounds = YES;
//    effect.contentView.alpha = 0;
    effect.layer.cornerRadius = 56 / 2.0f;
    [effect.topAnchor constraintEqualToAnchor:content.topAnchor].active = YES;
    [effect.leftAnchor constraintEqualToAnchor:content.leftAnchor].active = YES;
    [effect.rightAnchor constraintEqualToAnchor:content.rightAnchor].active = YES;
    [effect.bottomAnchor constraintEqualToAnchor:content.bottomAnchor].active = YES;
    
    UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 56, 56)];
    text.font = [UIFont MaterialDesignIconsWithSize:24];
    text.text = [UIFont mdiPlus];
    text.textColor = [UIColor whiteColor];
    text.textAlignment = NSTextAlignmentCenter;
    
    [effect.contentView addSubview:text];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"touched");
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert test" message:@"fuck me" preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"action test" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
//        NSLog(@"%@", action.title);
//    }];
//    
//    [alert addAction:action];
    
//    [self presentViewController:alert animated:YES completion:^{}];
    
    [self letWindow];
}

- (void)letWindow{
    UIWindow *window = [[UIWindow alloc] initWithFrame:self.view.window.bounds];
    window.windowLevel = UIWindowLevelAlert + 10;
//    window.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    window.backgroundColor = [UIColor randomColor];
    [window makeKeyAndVisible];
    
    NSLog(@"%@", [UIApplication sharedApplication].windows);
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

@end
