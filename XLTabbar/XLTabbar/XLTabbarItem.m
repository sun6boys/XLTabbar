//
//  XLTabbarItem.m
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import "XLTabbarItem.h"
#import "XLBarItemWrapperView.h"
#import "XLBarItemVeticalView.h"

#import <pop/POP.h>

@interface XLTabbarItem()

@property (nonatomic, assign) XLTabbarItemState itemState;

@end

@implementation XLTabbarItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        _stateActions = [[NSMutableDictionary alloc] init];
        
        _wrapperView = [[XLBarItemWrapperView alloc] init];
        _wrapperView.userInteractionEnabled = NO;
                
        [self addSubview:_wrapperView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.wrapperView.frame = self.bounds;
}

+ (instancetype)barItemWithStyle:(XLTabbarItemStyle)style
{
    if (style == XLTabbarItemStyleNormal) {
        return [[XLNormalTabbarItem alloc] init];
    }else{
        return [[XLSpecialTabbarItem alloc] init];
    }
}

- (void)setImage:(UIImage *)image forState:(XLTabbarItemState)state
{
    if (state == XLTabbarItemStateNormal) {
        self.wrapperView.normalImage = image;
    }else if (state == XLTabbarItemStateSelected){
        self.wrapperView.selectedImage = image;
    }
}

- (void)setTitle:(NSString *)title forState:(XLTabbarItemState)state
{
    self.wrapperView.title = title;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = badgeValue;
    self.wrapperView.badgeValue = badgeValue;
}

- (void)setState:(XLTabbarItemState)state{}

- (void)addTouchUpInsideEventWithTarget:(id)target action:(SEL)action forState:(XLTabbarItemState)state
{
    self.stateActions[@(state)] = NSStringFromSelector(action);
    
    if ([self.allTargets containsObject:target]) {
        return;
    }
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    [super sendAction:action to:target forEvent:event];
}

@end


@implementation XLNormalTabbarItem

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.wrapperView.selected = selected;
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    XLTabbarItemState state = self.isSelected ? XLTabbarItemStateSelected : XLTabbarItemStateNormal;
    NSString *actionString = self.stateActions[@(state)];
    
    if (actionString.length == 0) return;
    
    SEL selector = NSSelectorFromString(actionString);
    [super sendAction:selector to:target forEvent:event];
    [self beiginAnimation];
    
}

- (void)beiginAnimation
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.7, 0.7)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.f, 1.f)];
    animation.duration = 0.2;

    [self pop_addAnimation:animation forKey:@"Scale"];
}

@end

@interface XLSpecialTabbarItem()

@property (nonatomic, strong) XLBarItemVeticalView *veticalView;
@end

@implementation XLSpecialTabbarItem
- (instancetype)init
{
    if (self = [super init]) {
        self.wrapperView.selected = NO;
        
        _veticalView = [[XLBarItemVeticalView alloc] init];
        _veticalView.hidden = YES;
        _veticalView.userInteractionEnabled = NO;
        
        [self addSubview:self.veticalView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.veticalView.frame = self.bounds;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected == NO) {
        self.wrapperView.hidden = NO;
        self.veticalView.hidden = YES;
    }else{
        self.veticalView.hidden = NO;
        self.wrapperView.hidden = YES;
    }
}

- (void)setImage:(UIImage *)image forState:(XLTabbarItemState)state
{
    if (state == XLTabbarItemStateNormal) {
        [super setImage:image forState:state];
    }else if(state == XLTabbarItemStateSelected){
        self.veticalView.topImage = image;
    }else if (state == XLTabbarItemStateSpecialSelected){
        self.veticalView.bottomImage = image;
    }
}


#pragma mark - private methods
- (void)beiginAnimationForNormalStateSelect
{
    POPBasicAnimation *animation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.f, 1.f)];
    animation.duration = 0.2;
    [self pop_addAnimation:animation forKey:@"Scale"];
}

- (void)setState:(XLTabbarItemState)state
{
    if (self.isSelected == NO) {
        return;
    }
    if (state == XLTabbarItemStateNormal) {
        
    }else if (state == XLTabbarItemStateSelected){
        [self.veticalView scrollToTop];
    }else if (state == XLTabbarItemStateSpecialSelected){
        [self.veticalView scrollToSecond];
    }
}

- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    XLTabbarItemState state;
    if (self.isSelected == NO) {
        state = XLTabbarItemStateNormal;
        [self beiginAnimationForNormalStateSelect];
    }else{
        state = [self.veticalView isTop] == YES ? XLTabbarItemStateSelected : XLTabbarItemStateSpecialSelected;
        if (state == XLTabbarItemStateSelected && self.disableSelectedEvent) {
            return;
        }
        
        if ([self.veticalView isTop]) {
            [self.veticalView scrollToSecond];
        }else{
            [self.veticalView scrollToTop];
        }
    }
    NSString *actionString = self.stateActions[@(state)];
    
    if (actionString.length == 0) return;
    
    SEL selector = NSSelectorFromString(actionString);
    [super sendAction:selector to:target forEvent:event];
}

@end
