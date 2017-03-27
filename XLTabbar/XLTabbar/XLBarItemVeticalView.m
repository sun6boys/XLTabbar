//
//  XLBarItemVeticalView.m
//  XLTabbar
//
//  Created by Charon on 17/3/26.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import "XLBarItemVeticalView.h"

@interface XLBarItemVeticalView()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *bottomImageView;

@property (nonatomic, assign) BOOL isFirstPage;
@end

@implementation XLBarItemVeticalView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.topImageView];
        [self.scrollView addSubview:self.bottomImageView];
        
        _isFirstPage = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
}

#pragma mark - public methods
- (BOOL)isTop
{
    return self.isFirstPage == YES;
}

- (void)scrollToTop
{
    if ([self isTop]) {
        return;
    }
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    self.isFirstPage = YES;
}

- (void)scrollToSecond
{
    if ([self isTop] == NO || self.bottomImage == nil) {
        return;
    }
    [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.frame.size.height) animated:YES];
    self.isFirstPage = NO;
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.scrollEnabled = NO;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.frame = CGRectMake(0, 0, 40, 40);
    }
    return _scrollView;
}

- (UIImageView *)topImageView
{
    if (_topImageView == nil) {
        _topImageView = [[UIImageView alloc] init];
        _topImageView.image = self.topImage;
        _topImageView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }
    return _topImageView;
}

- (UIImageView *)bottomImageView
{
    if (_bottomImageView == nil) {
        _bottomImageView = [[UIImageView alloc] init];
        _bottomImageView.image = self.bottomImage;
        _bottomImageView.frame = CGRectMake(0, self.topImageView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    }
    return _bottomImageView;
}

- (void)setTopImage:(UIImage *)topImage
{
    _topImage = topImage;
    self.topImageView.image = topImage;
}

- (void)setBottomImage:(UIImage *)bottomImage
{
    _bottomImage = bottomImage;
    self.bottomImageView.image = bottomImage;
}

@end
