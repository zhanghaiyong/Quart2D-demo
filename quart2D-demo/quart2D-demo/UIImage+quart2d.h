//
//  UIImage+quart2d.h
//  quart2D-demo
//
//  Created by zhy on 2017/8/2.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (quart2d)

+ (UIImage *)drawImageWithImageNamed:(NSString *)imageName;


//添加文字水印
+ (UIImage *)waterImageWithImage:(UIImage *)image text:(NSString *)text textPt:(CGPoint)point attributedString:(NSDictionary *)attr;

//添加图片水印
+ (UIImage *)waterImageWithImage:(UIImage *)image waterImage:(UIImage *)waterImage waterImageRect:(CGRect)rect;

@end
