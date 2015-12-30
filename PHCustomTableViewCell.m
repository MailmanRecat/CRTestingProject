//
//  PHCustomTableViewCell.m
//  CRTestingProject
//
//  Created by caine on 12/22/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "PHCustomTableViewCell.h"

@implementation PHCustomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.crimageview = [[UIImageView alloc] init];
    self.crimageview.translatesAutoresizingMaskIntoConstraints = NO;
    self.crimageview.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.crimageview];
    [self.crimageview.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
    [self.crimageview.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor].active = YES;
    [self.crimageview.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
    [self.crimageview.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor].active = YES;
    
    return self;
}

@end
