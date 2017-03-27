//
//  ViewController.m
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import "ViewController.h"
#import "XLTabbarItem.h"

#import "XLBarItemWrapperView.h"
#import "XLTabbar.h"

@interface ViewController ()<XLTabbarDelegte>

@property (nonatomic, strong) XLBarItemWrapperView *wrapperView;

@property (nonatomic, strong) UIViewController *vc1;
@property (nonatomic, strong) UIViewController *vc2;
@property (nonatomic, strong) UIViewController *vc3;
@property (nonatomic, strong) UIViewController *vc4;
@property (nonatomic, strong) UIViewController *vc5;
@property (nonatomic, strong) XLTabbar *tabbar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    XLTabbarItem *item = [[XLTabbarItem alloc] init];
    item.backgroundColor = [UIColor redColor];
    item.frame = CGRectMake(100, 100, 100, 100);
    [item addTarget:self action:@selector(didTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:item];
    
     /*
    self.wrapperView = [[XLBarItemWrapperView alloc] init];
    self.wrapperView.frame = CGRectMake(200, 250, 80, 49);
    self.wrapperView.title = @"购物车";
    self.wrapperView.normalImage = [UIImage imageNamed:@"tabbar_home_unSelected"];
    self.wrapperView.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    self.wrapperView.badgeValue = @"10";
    
    [self.view addSubview:self.wrapperView];
     */
    
    [self addChildViewController:self.vc1];
    [self addChildViewController:self.vc2];
    [self addChildViewController:self.vc3];
    [self addChildViewController:self.vc4];
    [self addChildViewController:self.vc5];
    
    [self.view addSubview:self.tabbar];
    [self.tabbar config];
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.tabbar.frame = CGRectMake(0, self.view.frame.size.height - 49, self.view.frame.size.width, 49);
}

- (void)didTapped:(UIControl *)control
{
    self.vc4.bl_TabbarItem.badgeValue = @"50";
    
    [self.vc1.bl_TabbarItem setState:XLTabbarItemStateSpecialSelected];
}

#pragma mark - XLTabbarDelegte
- (void)tabbar:(XLTabbar *)tabbar didSelectedItemAtIndex:(NSInteger)index
{
    NSLog(@"切换到第%zd个页面",index);
}

- (void)tabbar:(XLTabbar *)tabbar didDeselectedItemAtIndex:(NSInteger)index
{
    NSLog(@"%zd反选",index);
}

- (void)tabbar:(XLTabbar *)tabbar didSelectedSpecialItemAtIndex:(NSInteger)index
{
    NSLog(@"%zd个Item 点击特殊按钮",index);
}


- (UIViewController *)vc1
{
    if (_vc1 == nil) {
        _vc1 = [[UIViewController alloc] init];
        _vc1.bl_TabbarItem = [XLTabbarItem barItemWithStyle:XLTabbarItemStyleVeticaCustom];
        
        [_vc1.bl_TabbarItem setImage:[UIImage imageNamed:@"tabbar_home_unSelected"] forState:XLTabbarItemStateNormal];
        [_vc1.bl_TabbarItem setTitle:@"首页" forState:XLTabbarItemStateNormal];
        [_vc1.bl_TabbarItem setImage:[UIImage imageNamed:@"homeNormal"] forState:XLTabbarItemStateSelected];
        [_vc1.bl_TabbarItem setImage:[UIImage imageNamed:@"homeTop"] forState:XLTabbarItemStateSpecialSelected];
        _vc1.bl_TabbarItem.selected = YES;
        //_vc1.bl_TabbarItem.disableSelectedEvent = YES;
    }
    return _vc1;
}

- (UIViewController *)vc2
{
    if (_vc2 == nil) {
        _vc2 = [[UIViewController alloc] init];
        _vc2.bl_TabbarItem = [XLTabbarItem barItemWithStyle:XLTabbarItemStyleNormal];
        
        [_vc2.bl_TabbarItem setImage:[UIImage imageNamed:@"tabbar_order_unSelected"] forState:XLTabbarItemStateNormal];
        [_vc2.bl_TabbarItem setTitle:@"分类" forState:XLTabbarItemStateNormal];
        [_vc2.bl_TabbarItem setImage:[UIImage imageNamed:@"tabbar_order_selected"] forState:XLTabbarItemStateSelected];
    }
    return _vc2;
}

- (UIViewController *)vc3
{
    if (_vc3 == nil) {
        _vc3 = [[UIViewController alloc] init];
        _vc3.bl_TabbarItem = [XLTabbarItem barItemWithStyle:XLTabbarItemStyleNormal];
        
        [_vc3.bl_TabbarItem setImage:[UIImage imageNamed:@"tabbar_user_unSelected"] forState:XLTabbarItemStateNormal];
        [_vc3.bl_TabbarItem setTitle:@"发现" forState:XLTabbarItemStateNormal];
        [_vc3.bl_TabbarItem setImage:[UIImage imageNamed:@"tabbar_user_selected"] forState:XLTabbarItemStateSelected];
    }
    return _vc3;
}

- (UIViewController *)vc4
{
    if (_vc4 == nil) {
        _vc4 = [[UIViewController alloc] init];
        _vc4.bl_TabbarItem = [XLTabbarItem barItemWithStyle:XLTabbarItemStyleNormal];
        
        [_vc4.bl_TabbarItem setImage:[UIImage imageNamed:@"tabbar_home_unSelected"] forState:XLTabbarItemStateNormal];
        [_vc4.bl_TabbarItem setTitle:@"购物车" forState:XLTabbarItemStateNormal];
        [_vc4.bl_TabbarItem setImage:[UIImage imageNamed:@"tabbar_home_selected"] forState:XLTabbarItemStateSelected];

    }
    return _vc4;
}

- (UIViewController *)vc5
{
    if (_vc5 == nil) {
        _vc5 = [[UIViewController alloc] init];
        _vc5.bl_TabbarItem = [XLTabbarItem barItemWithStyle:XLTabbarItemStyleNormal];
        
        [_vc5.bl_TabbarItem setImage:[UIImage imageNamed:@"tabbar_order_unSelected"] forState:XLTabbarItemStateNormal];
        [_vc5.bl_TabbarItem setTitle:@"分类" forState:XLTabbarItemStateNormal];
        [_vc5.bl_TabbarItem setImage:[UIImage imageNamed:@"tabbar_order_selected"] forState:XLTabbarItemStateSelected];
    }
    return _vc5;
}

- (XLTabbar *)tabbar
{
    if (_tabbar == nil) {
        _tabbar = [[XLTabbar alloc] init];
        _tabbar.delegate = self;
    }
    return _tabbar;
}

@end
