//
//  UIColor+Hex.h
//  lian
//
//  Created by Fire on 15-9-7.
//  Copyright (c) 2015年 DuoLaiDian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]

@interface UIColor (Hex)

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


//读取完成的回调  不能连续调用
+(void)getColorWithImage:(UIImage *)image
		   andCompletion:(void(^)(UIColor *imageColor))completion;


@end
