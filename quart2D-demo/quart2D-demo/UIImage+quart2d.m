//
//  UIImage+quart2d.m
//  quart2D-demo
//
//  Created by zhy on 2017/8/2.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "UIImage+quart2d.h"


@implementation UIImage (quart2d)

+ (UIImage *)drawImageWithImageNamed:(NSString *)imageName {

    // 1.获取图片
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 2.开启图形上下文
    UIGraphicsBeginImageContext(image.size);
    
    // 3.绘制到图形上下文中
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    // 4.从上下文中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭图形上下文
    UIGraphicsEndImageContext();
    
    // 6.返回图片
    return newImage;
}


//添加文字水印
+ (UIImage *)waterImageWithImage:(UIImage *)image text:(NSString *)text textPt:(CGPoint)point attributedString:(NSDictionary *)attr {

    // 1.开始上下文
    /*
     size——新创建的位图上下文的大小
     opaque—透明开关，如果图形完全不用透明，设置为YES以优化位图的存储。
     scale—–缩放因子 iPhone 4是2.0，其他是1.0。虽然这里可以用[UIScreen mainScreen].scale来获取，但实际上设为0后，系统就会自动设置正确的比例了。
     */
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    
    // 2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    
    // 3.添加水印文字
    [text drawAtPoint:point withAttributes:attr];
    
    // 4.从上下文获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    
    // 6。返回图片
    return  newImage;
    
}

//添加图片水印
+ (UIImage *)waterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect {

    // 1.开始上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake( [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), NO, 0);
    
    // 2.绘制背景图片
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    
    // 3.绘制水印图片到当前上下文
    [waterImage drawInRect:rect];
    
    // 4.从上下文中获取图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    
    //  6.返回图片
    return newImage;
}

@end
