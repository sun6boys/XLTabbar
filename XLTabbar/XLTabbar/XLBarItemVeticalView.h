//
//  XLBarItemVeticalView.h
//  XLTabbar
//
//  Created by Charon on 17/3/26.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLBarItemVeticalView : UIView

@property (nonatomic, strong) UIImage *topImage;
@property (nonatomic, strong) UIImage *bottomImage;

- (BOOL)isTop;

- (void)scrollToTop;

- (void)scrollToSecond;

@end
