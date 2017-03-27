//
//  XLBarItemWrapperView.m
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import "XLBarItemWrapperView.h"
#import "UIColor+XLHex.h"
#import "NSString+StringSize.h"

@interface XLBarItemWrapperView()
@property (nonatomic, strong) UILabel *buttonTitleLabel;
@property (nonatomic, strong) UIImageView *buttomImageView;

@property (nonatomic, strong) UIView *badgeBackView;
@property (nonatomic, strong) UILabel *badgeLabel;
@end

@implementation XLBarItemWrapperView

#pragma mark - life cycles
- (instancetype)init
{
    self = [super init];
    if (self) {
        _selected = NO;
        
        _normalTitleColor = [UIColor colorWithHex:0x666666];
        _selectedTitleColor = [UIColor colorWithHex:0xff2b2b];
        
        _badgeTitleColor = [UIColor whiteColor];
        _badgeTintColor = [UIColor colorWithHex:0xe6133c];
        
        _buttonTitleLabel = [[UILabel alloc] init];
        _buttonTitleLabel.font = [UIFont systemFontOfSize:11];
        _buttonTitleLabel.textAlignment = NSTextAlignmentCenter;
        _buttonTitleLabel.textColor = _normalTitleColor;
        
        _buttomImageView = [[UIImageView alloc] init];
        _buttomImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _badgeBackView = [[UIView alloc] init];
        _badgeBackView.backgroundColor = [UIColor whiteColor];
        _badgeBackView.layer.cornerRadius = 7.5;
        _badgeBackView.layer.masksToBounds = YES;
        _badgeBackView.hidden = YES;
        
        _badgeLabel = [[UILabel alloc] init];
        _badgeLabel.textAlignment = NSTextAlignmentCenter;
        _badgeLabel.backgroundColor = _badgeTintColor;
        _badgeLabel.textColor = _badgeTitleColor;
        _badgeLabel.layer.cornerRadius = 5.5;
        _badgeLabel.layer.masksToBounds = YES;
        _badgeLabel.font = [UIFont systemFontOfSize:10];
        
        [self addSubview:self.buttonTitleLabel];
        [self addSubview:self.buttomImageView];
        [self addSubview:self.badgeBackView];
        
        [self.badgeBackView addSubview:self.badgeLabel];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.buttomImageView.frame = CGRectMake(0, 0, 21, 21);
    self.buttomImageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height * 0.363);
    
    self.buttonTitleLabel.frame = CGRectMake(0, self.buttomImageView.frame.size.height + self.buttomImageView.frame.origin.y + 3, self.frame.size.width, 14);
    
    CGSize size = [self.badgeLabel.text stringSizeWithContentSize:CGSizeMake(MAXFLOAT, 11) font:[UIFont systemFontOfSize:10]];
    CGFloat width = ceil(size.width) > 18.0f ? ceil(size.width) + 10 : 22;
    self.badgeBackView.frame = CGRectMake(0, 0, width, 15);
    self.badgeBackView.center = CGPointMake(self.buttomImageView.frame.origin.x + self.buttomImageView.frame.size.width, self.buttomImageView.frame.origin.y);
    
    self.badgeLabel.frame = CGRectMake(0, 0, width - 4, 11);
    self.badgeLabel.center = CGPointMake(self.badgeBackView.frame.size.width / 2, self.badgeBackView.frame.size.height / 2);
    
}

#pragma mark - setters
- (void)setTitle:(NSString *)title
{
    _title = title;
    self.buttonTitleLabel.text = title;
}

- (void)setNormalTitleColor:(UIColor *)normalTitleColor
{
    _normalTitleColor = normalTitleColor;
    [self setSelected:self.selected];
}

- (void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    _selectedTitleColor = selectedTitleColor;
    [self setSelected:self.selected];
}

- (void)setNormalImage:(UIImage *)normalImage
{
    _normalImage = normalImage;
    [self setSelected:self.selected];
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    [self setSelected:self.selected];
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    if ([badgeValue integerValue] <= 0) {
        self.badgeBackView.hidden = YES;
    }else{
        self.badgeBackView.hidden = NO;
    }
    
    badgeValue = [badgeValue integerValue ] <= 0 ? @"0" : badgeValue;
    badgeValue = [badgeValue integerValue] > 100 ? @"99+" : badgeValue;
    _badgeValue = badgeValue;
    
    self.badgeLabel.text = badgeValue;
    [self layoutSubviews];
}

- (void)setBadgeTitleColor:(UIColor *)badgeTitleColor
{
    _badgeTitleColor = badgeTitleColor;
    self.badgeLabel.textColor = badgeTitleColor;
}

- (void)setBadgeTintColor:(UIColor *)badgeTintColor
{
    _badgeTintColor = badgeTintColor;
    self.badgeLabel.backgroundColor = badgeTintColor;
}

- (void)setSelected:(BOOL)selected
{
    _selected = selected;
    if (selected) {
        self.buttomImageView.image = self.selectedImage;
        self.buttonTitleLabel.textColor = self.selectedTitleColor;
    }else{
        self.buttomImageView.image = self.normalImage;
        self.buttonTitleLabel.textColor = self.normalTitleColor;
    }
}

@end
