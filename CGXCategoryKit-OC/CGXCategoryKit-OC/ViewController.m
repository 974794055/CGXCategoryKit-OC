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
    btn.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
//    [btn setImage:[UIImage imageNamed:@"Placeholder"] forState:UIControlStateNormal];
    [btn setTitle:@"哈哈" forState:UIControlStateNormal];
    [btn gx_addTapBlock:^(UIButton * _Nonnull btn) {
        NSLog(@"哈哈");
    }];
    btn.layer.masksToBounds = YES;
    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(100);
        make.width.height.mas_equalTo(200);
    }];
    btn.gx_clipType = CGXRoundedClipTypeBottomLeft | CGXRoundedClipTypeBottomRight;
    btn.gx_cornerRadius = 10;
    btn.gx_borderWidth = 5;
    btn.gx_borderColor = [UIColor blackColor];
    btn.gx_backgroundColor = [UIColor clearColor];

    //@property(nonatomic, assign) CGFloat gx_clipRadius;
//    @property(nonatomic, assign) CGXRoundedClipType gx_clipType;
    // border
    //@property(nonatomic, assign) CGFloat gx_borderWidth;
    //@property(nonatomic, strong) UIColor *gx_borderColor;
    
//    [btn gx_roundedRadius:100 BorderColor:[UIColor blackColor] BorderWidth:10 RectCorner:UIRectCornerAllCorners];
    
    


//    UILabel *label = [[UILabel alloc] init];
//    [self.view addSubview:label];
//    label.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
//    label.numberOfLines = 0;
//    label.textAlignment =  NSTextAlignmentCenter;
//    label.textColor = [UIColor redColor];
//    label.text = @"激动-激动-激动\n激动-激动-温柔";
//    [label gx_addAttributeTapWithStrings:@[@"激动",@"温柔"] delegate:self];
//    [label mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view.mas_centerX);
//        make.top.equalTo(btn.mas_bottom).offset(20);
//        make.width.height.mas_equalTo(200);
//    }];
//    [label gx_roundedCornerWithAllRadius:100];
//    [label gx_BorderWithColor:[UIColor orangeColor] borderWidth:1];
//    [label.superview layoutIfNeeded];
//    [label gx_cornerRadius:100];
//    [label gx_cornerRadius:100 borderWidth:1 borderColor:[UIColor redColor]];
    
//    UITextView *textView = [[UITextView alloc] init];
//    textView.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:textView];
//    textView.gx_placeholder = @"温柔温柔";
//    [textView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).offset(10);
//        make.right.equalTo(self.view.mas_right).offset(-10);
//        make.top.equalTo(label.mas_bottom).offset(10);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
//    }];
    
//    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dataArr" ofType:@"plist"]];
//    NSLog(@"\n%@",dataDic);
}
- (void)gx_tapAttributeInLabel:(UILabel *)label
                        string:(NSString *)string
                         range:(NSRange)range
                         index:(NSInteger)index
{
    NSLog(@"哈哈 %@--%ld--%ld--%ld",string,range.location,range.length,index);
}

@end
