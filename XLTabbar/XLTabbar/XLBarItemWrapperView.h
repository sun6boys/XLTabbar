//
//  XLBarItemWrapperView.h
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLBarItemWrapperView : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *normalTitleColor; //默认 0x666666
@property (nonatomic, strong) UIColor *selectedTitleColor; //默认0xff2b2b

@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, strong) UIColor *badgeTitleColor; //默认 whiteColor
@property (nonatomic, strong) UIColor *badgeTintColor;  //默认 0xe6133c

@property (nonatomic, assign) BOOL selected;
@end
