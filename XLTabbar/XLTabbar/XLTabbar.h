//
//  XLTabbar.h
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import <UIKit/UIKit.h>


@class XLTabbarItem;
@class XLTabbar;

@protocol XLTabbarDelegte <NSObject>

- (void)tabbar:(XLTabbar *)tabbar didSelectedItemAtIndex:(NSInteger)index;

- (void)tabbar:(XLTabbar *)tabbar didDeselectedItemAtIndex:(NSInteger)index;

- (void)tabbar:(XLTabbar *)tabbar didSelectedSpecialItemAtIndex:(NSInteger)index;

@end

@interface XLTabbar : UIView

@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, copy) NSArray<XLTabbarItem *> *tabbarItems;

@property (nonatomic, weak) UIViewController <XLTabbarDelegte> *delegate;

- (void)config;

@end



@interface UIViewController(BarItem)

@property (nonatomic, strong) XLTabbarItem *bl_TabbarItem;

@end
