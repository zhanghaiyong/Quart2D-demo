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
    
    NSLog(@"%@",NSStringFromCGSize(image.size));
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
    
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

    
    NSLog(@"%@",NSStringFromCGSize(image.size));
    // 1.开始上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), NO, 0);
    
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

//裁剪图形图片
+ (UIImage *)clipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect {

    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height), YES, 0);
    
    // 2.设置裁剪区域（这个区域不会被裁剪）
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    //一个path调用addClip之后，它所在的context的可见区域就变成了它的“fill area”，接下来的绘制，如果在这个区域外都会被无视。
    [path addClip];
    
    // 3.绘制图片
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];;
    
    // 4.获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 5.关闭上下文
    UIGraphicsEndImageContext();
    
    // 6.返回新图片
    return newImage;
}

//裁剪带边框的圆形图片
+ (UIImage *)clipCircleImageWithImage:(UIImage *)image circleRect:(CGRect)rect borderWidth:(CGFloat)borderW borderColor:(UIColor *)borderColor {

    //1、开启上下文
    UIGraphicsBeginImageContext(CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height));
    
    //2、设置边框
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [borderColor setFill];
    [path fill];
    
    //3、设置裁剪区域
    UIBezierPath * clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(rect.origin.x + borderW , rect.origin.x + borderW , rect.size.width - borderW * 2, rect.size.height - borderW *2)];
    [clipPath addClip];
    
    //3、绘制图片
    [image drawInRect:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];;
    
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //5、关闭上下文
    UIGraphicsEndImageContext();
    
    //6、返回新图片
    return newImage;
    
}

//截屏
+ (void)cutScreenWithView:(UIView *)view successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block {

    //1、开启上下文
    UIGraphicsBeginImageContext(view.bounds.size);
    
    //2.获取当前上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //3.截屏
    [view.layer renderInContext:ctx];
    
    //4、获取新图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //5.转化成为Data
    //compressionQuality:表示压缩比 0 - 1的取值范围
    NSData * data = UIImageJPEGRepresentation(newImage, 1);
    //6、关闭上下文
    UIGraphicsEndImageContext();
    
    //7.回调
    block(newImage,data);
}

//擦除：
- (nullable UIImage *)wipeImageWithView:(nullable UIView *)view currentPoint:(CGPoint)nowPoint size:(CGSize)size {
    //计算位置
    CGFloat offsetX = nowPoint.x - size.width * 0.5;
    CGFloat offsetY = nowPoint.y - size.height * 0.5;
    CGRect clipRect = CGRectMake(offsetX, offsetY, size.width, size.height);
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 1);
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //把图片绘制上去(把view.layer绘制到上下文)
    //获取需要截取的view的layer
    [view.layer renderInContext:ctx];
    
    //把这一块设置为透明
    CGContextClearRect(ctx, clipRect);
    
    //获取新的图片
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    //重新赋值图片
    return newImage;
}

//图片裁剪：
+ (void)cutScreenWithView:(nullable UIView *)view cutFrame:(CGRect)frame successBlock:(nullable void(^)(UIImage * _Nullable image,NSData * _Nullable imagedata))block {

//    //先把裁剪区域上面显示的层隐藏掉
//    for (PQWipeView * wipe in view.subviews) {
//        [wipe setHidden:YES];
//    }
//    
    
    // ************************   进行第一次裁剪 ********************
    
    //1.开启上下文
    UIGraphicsBeginImageContext(view.frame.size);
    //2、获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //3、添加裁剪区域
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:frame];
    [path addClip];
    //4、渲染
    [view.layer renderInContext:ctx];
    //5、从上下文中获取
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7、关闭上下文
    UIGraphicsEndImageContext();
    
//    //8、进行完第一次裁剪之后，我们就已经拿到了没有半透明层的图片，这个时候可以恢复显示
//    for (PQWipeView * wipe in view.subviews) {
//        [wipe setHidden:NO];
//    }
    
    // ************************   进行第二次裁剪 ********************
    //9、开启上下文，这个时候的大小就是我们最终要显示图片的大小
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0);
    
    //10、这里把x y 坐标向左、上移动
    [newImage drawAtPoint:CGPointMake(- frame.origin.x, - frame.origin.y)];
    
    //11、得到要显示区域的图片
    UIImage * fImage = UIGraphicsGetImageFromCurrentImageContext();
    //12、得到data类型 便于保存
    NSData * data2 = UIImageJPEGRepresentation(fImage, 1);
    //13、关闭上下文
    UIGraphicsEndImageContext();
    //14、回调
    block(fImage,data2);

}


@end
