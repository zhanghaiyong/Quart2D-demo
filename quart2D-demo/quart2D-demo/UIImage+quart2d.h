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

//裁剪图形图片
+ (UIImage *)clipCircleImageWithImage:(UIImage *)image circleRect: (CGRect)rect;

//裁剪带边框的圆形图片
+ (UIImage *)clipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:(UIColor *)borderColor;

//截屏
+ (void)cutScreenWithView:(UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;

//擦除：
- (nullable UIImage *)wipeImageWithView:(nullable UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size;

//图片裁剪：
+ (void)cutScreenWithView:(nullable UIView *)view cutFrame:(CGRect)frame successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block;
    
@end
