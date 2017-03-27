//
//  UIColor+XLHex.h
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (XLHex)
+ (UIColor *)colorWithHex:(UInt32)hex;

+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHex:(UInt32)hex alpha:(CGFloat)alpha;

+ (UIColor *)RandomColor;

+(UIColor *)colorWithHexStr:(NSString *)hexColor;

+(UIColor *)colorWithHexStr:(NSString *)hexColor alpha:(float)alpha;
@end
