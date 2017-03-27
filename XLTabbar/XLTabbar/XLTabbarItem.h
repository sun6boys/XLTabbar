//
//  XLTabbarItem.h
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XLBarItemWrapperView;

typedef NS_ENUM(NSInteger,XLTabbarItemState) {
    XLTabbarItemStateNormal,              //普通状态
    XLTabbarItemStateSelected,            //普通的选中状态
    XLTabbarItemStateSpecialSelected,     //选中状态的第二种形态。。。
};

typedef NS_ENUM(NSInteger, XLTabbarItemStyle){
    XLTabbarItemStyleNormal,
    XLTabbarItemStyleVeticaCustom,
};

@interface XLTabbarItem : UIControl

@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic, strong) NSMutableDictionary *stateActions;

@property (nonatomic, strong) XLBarItemWrapperView *wrapperView;

@property (nonatomic, assign) BOOL disableSelectedEvent;

+ (instancetype)barItemWithStyle:(XLTabbarItemStyle)style;

- (void)setImage:(UIImage *)image forState:(XLTabbarItemState)state;

- (void)setTitle:(NSString *)title forState:(XLTabbarItemState)state;

- (void)setState:(XLTabbarItemState)state;

- (void)addTouchUpInsideEventWithTarget:(id)target action:(SEL)action forState:(XLTabbarItemState)state;


@end


@interface XLNormalTabbarItem : XLTabbarItem

@end


@interface XLSpecialTabbarItem : XLTabbarItem

@end
