//
//  XLTabbar.m
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import "XLTabbar.h"
#import "UIColor+XLHex.h"
#import "XLTabbarItem.h"

@interface XLTabbar()

@property (nonatomic, strong) UIView *shadowLineView;
@property (nonatomic, strong) XLTabbarItem *selectedItem;
@end

@implementation XLTabbar

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.shadowLineView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.shadowLineView.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    
    CGFloat width = self.tabbarItems.count > 0 ? self.frame.size.width / self.tabbarItems.count : 0;
    [self.tabbarItems enumerateObjectsUsingBlock:^(XLTabbarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = CGRectMake(idx * width, 0.5, width, self.frame.size.height - 0.5);
    }];
}

#pragma mark - private methods
- (void)addEventWithBarItem:(XLTabbarItem *)item
{
    [item addTouchUpInsideEventWithTarget:self action:@selector(didTappedItemInNormalState:) forState:XLTabbarItemStateNormal];
    [item addTouchUpInsideEventWithTarget:self action:@selector(didTappedItemInSelectedState:) forState:XLTabbarItemStateSelected];
    [item addTouchUpInsideEventWithTarget:self action:@selector(didTappedItemInSpecialSelectedState:) forState:XLTabbarItemStateSpecialSelected];
}

- (void)addTabbarItems
{
    if (self.tabbarItems.count == 0) {
        return;
    }
    //默认点击的是第0个
    [self.tabbarItems enumerateObjectsUsingBlock:^(XLTabbarItem * _Nonnull item, NSUInteger idx, BOOL * _Nonnull stop) {
        if (item.isSelected) {
            self.selectedItem = item;
        }
        item.tag = idx;
        [self addSubview:item];
        [self addEventWithBarItem:item];
    }];
}

#pragma mark - event response
- (void)didTappedItemInNormalState:(XLTabbarItem *)item
{
    item.selected = YES;
    self.selectedItem.selected = NO;
    
    self.selectedItem = item;
    if ([self.delegate respondsToSelector:@selector(tabbar:didSelectedItemAtIndex:)]) {
        [self.delegate tabbar:self didSelectedItemAtIndex:item.tag];
    }
}

- (void)didTappedItemInSelectedState:(XLTabbarItem *)item
{
    if ([self.delegate respondsToSelector:@selector(tabbar:didDeselectedItemAtIndex:)]) {
        [self.delegate tabbar:self didDeselectedItemAtIndex:item.tag];
    }
}

- (void)didTappedItemInSpecialSelectedState:(XLTabbarItem *)item
{
    if ([self.delegate respondsToSelector:@selector(tabbar:didSelectedSpecialItemAtIndex:)]) {
        [self.delegate tabbar:self didSelectedSpecialItemAtIndex:item.tag];
    }
}

#pragma mark - public methods
- (void)config
{
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < self.delegate.childViewControllers.count; index ++) {
        UIViewController *childVC = self.delegate.childViewControllers[index];
        if (childVC.bl_TabbarItem) {
            [temp addObject:childVC.bl_TabbarItem];
        }
    }
    self.tabbarItems = temp;
}

#pragma mark - setters
- (void)setTabbarItems:(NSArray<XLTabbarItem *> *)tabbarItems
{
    _tabbarItems = [tabbarItems copy];
    [self addTabbarItems];
}

- (void)setShadowColor:(UIColor *)shadowColor
{
    _shadowColor = shadowColor;
    self.shadowLineView.backgroundColor = shadowColor;
}

#pragma mark - getters
- (UIView *)shadowLineView
{
    if (_shadowLineView == nil) {
        _shadowLineView = [[UIView alloc] init];
        _shadowLineView.backgroundColor = [UIColor colorWithHex:0xE7E7E7];
    }
    return _shadowLineView;
}
@end


#import <objc/runtime.h>

static char barItemKey;

@implementation UIViewController(BarItem)

- (XLTabbarItem *)bl_TabbarItem
{
    return objc_getAssociatedObject(self, &barItemKey);
}

- (void)setBl_TabbarItem:(XLTabbarItem *)bl_TabbarItem
{
    objc_setAssociatedObject(self, &barItemKey, bl_TabbarItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
