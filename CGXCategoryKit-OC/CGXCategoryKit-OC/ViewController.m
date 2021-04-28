//
//  ViewController.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CGXAttributeTapActionDelegate>
{
    UIButton *btn;
    UIBarButtonItem *item;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor orangeColor];
    [btn setImage:[UIImage imageNamed:@"Placeholder"] forState:UIControlStateNormal];
    [btn setTitle:@"哈哈" forState:UIControlStateNormal];
    [btn gx_addTapBlock:^(UIButton * _Nonnull btn) {
        NSLog(@"哈哈");
    }];
    btn.layer.masksToBounds = YES;
//    btn.frame = CGRectMake(200, 100, 100, 100);
    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_centerY).offset(-100);
        make.width.height.mas_equalTo(200);
    }];
    [btn.superview layoutIfNeeded];
    [self gx_roundedWithRadius:20 BorderColor:[UIColor redColor] BorderWidth:5 RectCorner:UIRectCornerAllCorners];

    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
//    label.frame = CGRectMake(20, 560, [UIScreen mainScreen].bounds.size.width-40, 100);
    label.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
    label.numberOfLines = 0;
    label.text = @"对巨大的激动d基督教三IE看呢短裤呃呃囧 温柔>>";
    [label gx_addAttributeTapWithStrings:@[@"激动",@"温柔"] delegate:self];
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.centerY.equalTo(self.view.mas_centerY).offset(100);
            make.width.height.mas_equalTo(200);
        }];
    [label gx_roundedCornerWithAllRadius:100];
    [label gx_BorderWithColor:[UIColor orangeColor] borderWidth:1];
//    NSLog(@"%@",[NSString gx_UUID]);
//    NSLog(@"%@",[NSString gx_UUIDString]);

//    NSLog(@"%@",[NSString gx_likeStringWithNum:@"9999"]);
//    NSLog(@"%@",[NSString gx_likeStringWithNum:@"99999"]);
//    NSLog(@"%@",[NSString gx_likeStringWithNum:@"99999999"]);
//    NSLog(@"%@",[NSString gx_likeStringWithNum:@"1999999999"]);
//
//    NSLog(@"%@",[NSString gx_helloStringByLocalTime]);
}
- (void)gx_tapAttributeInLabel:(UILabel *)label
                        string:(NSString *)string
                         range:(NSRange)range
                         index:(NSInteger)index
{
    NSLog(@"哈哈 %@--%ld--%ld--%ld",string,range.location,range.length,index);
}
- (void)codeClick
{
    NSLog(@"哈哈哈");
}

- (void)gx_roundedWithRadius:(CGFloat)radius BorderColor:(UIColor *)color BorderWidth:(CGFloat)borderWidth RectCorner:(UIRectCorner)corners
{
//    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = btn.bounds;
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = btn.bounds;
    borderLayer.lineWidth = borderWidth;
    borderLayer.strokeColor = color.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    UIBezierPath *bezierPath =  [UIBezierPath bezierPathWithRoundedRect:btn.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    [btn.layer insertSublayer:borderLayer atIndex:0];
    [btn.layer setMask:maskLayer];
}
@end
