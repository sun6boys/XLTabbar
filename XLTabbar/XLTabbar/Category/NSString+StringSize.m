//
//  NSString+StringSize.m
//  XLTabbar
//
//  Created by Charon on 17/3/25.
//  Copyright © 2017年 Charon. All rights reserved.
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)

- (CGSize)stringSizeWithContentSize:(CGSize)contentSize font:(UIFont *)font
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName: font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize size = [self boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return size;
}

@end
