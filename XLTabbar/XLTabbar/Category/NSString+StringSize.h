//
//  NSString+StringSize.h
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringSize)

- (CGSize)stringSizeWithContentSize:(CGSize)contentSize font:(UIFont *)font;

@end
