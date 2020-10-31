//
//  ViewController.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
//<CGXAttributeTapActionDelegate>
{
    UIButton *btn;
    UIBarButtonItem *item;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:btn];
//    btn.backgroundColor = [UIColor lightGrayColor];
//
////    btn.frame = CGRectMake(200, 300, 100, 100);
//    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.centerY.equalTo(self.view.mas_centerY).offset(-100);
//        make.width.height.mas_equalTo(100);
//    }];
////    [btn.superview layoutIfNeeded];
////    [btn.superview setNeedsLayout];
////////
////    [self.view layoutIfNeeded];
////    btn.gx_clipRadius = 20;
////    [btn gx_roundedCornerWithAllRadius:20];
//
//        [btn gx_cornerRadius:CGSizeMake(20, 20) cornerColor:[UIColor whiteColor] corners:UIRectCornerAllCorners borderColor:[UIColor blackColor] borderWidth:2];
//
//    [btn setImage:[UIImage imageNamed:@"Placeholder"] forState:UIControlStateNormal];
//    [btn setTitle:@"哈哈" forState:UIControlStateNormal];
//    [btn gx_addTapBlock:^(UIButton * _Nonnull btn) {
//        NSLog(@"哈哈");
//    }];
//
//
//    UIImageView *vccc = [[UIImageView alloc] init];
//    [self.view addSubview:vccc];
//    vccc.frame = CGRectMake(200, 450, 100, 100);
//    vccc.image = [UIImage imageNamed:@"Placeholder"];
////    [vccc gx_imageWithString:@"鑫哈哈哈"];
////    [vccc gx_reflect];
////    [btn gx_buttonWithEdgeInsetsStyle:CGXEdgeInsetsPositionImageRight imageTitleSpace:10];
//
//    UILabel *label = [[UILabel alloc] init];
//    [self.view addSubview:label];
//    label.frame = CGRectMake(20, 560, [UIScreen mainScreen].bounds.size.width-40, 100);
//    label.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
//    label.numberOfLines = 0;
//    label.text = @"对巨大的激动d基督教三IE看呢短裤呃呃囧 温柔>>";
//    [label gx_addAttributeTapWithStrings:@[@"激动",@"温柔"] delegate:self];
//
//    NSLog(@"%@",[NSString gx_UUID]);
//    NSLog(@"%@",[NSString gx_UUIDString]);
//
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

@end
