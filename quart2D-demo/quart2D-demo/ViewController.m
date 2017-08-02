//
//  ViewController.m
//  quart2D-demo
//
//  Created by zhy on 2017/8/2.
//  Copyright © 2017年 zhy. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+quart2d.h"
#import <UIKit/UIKit.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.backImage.image = [UIImage drawImageWithImageNamed:@"1242-2208"];
 
//    self.backImage.image = [UIImage waterImageWithImage:[UIImage imageNamed:@"1242-2208"] text:@"水印文字" textPt:CGPointMake(100, 100) attributedString:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,[UIFont fontWithName:@"PingFang-SC-Medium" size: 50], NSFontAttributeName, nil]];
    
    
//    self.backImage.image = [UIImage waterImageWithImage:[UIImage imageNamed:@"guanlangaoshou07.jpg"] waterImage:[UIImage imageNamed:@"1242-2208"] waterImageRect:CGRectMake(50, 50, 100, 100)];
//    self.backImage.image = [UIImage clipCircleImageWithImage:[UIImage imageNamed:@"1242-2208"] circleRect:CGRectMake(100, 100, 200, 200) borderWidth:5 borderColor:[UIColor redColor]];
    
    self.backImage.image = [self.backImage.image wipeImageWithView:self.backImage currentPoint:CGPointMake(100, 100) size:CGSizeMake(20, 20)];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
