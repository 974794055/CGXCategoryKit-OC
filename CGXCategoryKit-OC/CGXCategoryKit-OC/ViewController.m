//
//  ViewController.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIButton *btn;
    UIBarButtonItem *item;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    item = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:nil];
//    item.gx_preventSeriesEvent = YES;
//    item.gx_preventInterval = 3;
//    [item gx_clickActionBlock:^{
//        NSLog(@"哈哈哈");
//    }];
  
    self.navigationItem.rightBarButtonItem = item;

//    item.badgeBGColor = [UIColor redColor];
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:btn];
//    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(codeClick) forControlEvents:UIControlEventTouchUpInside];
  
    btn.frame = CGRectMake(200, 300, 100, 100);

//    [btn gx_cornerRadius:CGSizeMake(20, 20) cornerColor:[UIColor whiteColor] corners:UIRectCornerTopLeft borderColor:[UIColor blackColor] borderWidth:2];
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [btn setImage:[[NSBundle mainBundle] gx_appIcon] forState:UIControlStateNormal];
//    [btn setTitle:[[NSBundle mainBundle] gx_appIconPath] forState:UIControlStateNormal];

//    NSLog(@"哈哈icon：%@" ,[[NSBundle mainBundle] gx_appIcon]);
//    NSLog(@"哈哈gx_appIconPath：%@" ,[[NSBundle mainBundle] gx_appIconPath]);

//    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.centerY.equalTo(self.view.mas_centerY);
//        make.width.height.mas_equalTo(100);
//    }];
//    [btn.superview layoutIfNeeded];
//    [btn.superview setNeedsLayout];
////
//    [self.view layoutIfNeeded];
//    btn.gx_clipRadius = 20;
//    [btn gx_setAllCornerWithCornerRadius:20];
//    [btn gx_roundedCornerWithAllRadius:50];
    
    UIView *vieee = [[UIView alloc] init];
    [self.view addSubview:vieee];
    vieee.backgroundColor = [UIColor yellowColor];
    vieee.frame = CGRectMake(200, 420, 100, 100);
        [vieee mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(btn.mas_bottom).offset(30);
            make.width.height.mas_equalTo(100);
        }];
    
    UIView *vieep = [[UIView alloc] init];
    [self.view addSubview:vieep];
    vieep.backgroundColor = [UIColor yellowColor];
    vieep.frame = CGRectMake(200, 420, 100, 100);
        [vieep mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(vieee.mas_bottom).offset(30);
            make.width.height.mas_equalTo(100);
        }];
    

    
}

- (void)codeClick
{
//    [btn gx_addAnimationAtPoint:CGPointMake(btn.frame.origin.x, btn.frame.origin.y)];
}

@end
