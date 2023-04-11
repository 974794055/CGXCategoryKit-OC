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
    
    UIScrollView *scrollView= [[UIScrollView alloc] init];
    scrollView.pagingEnabled =NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];

    UIView *containerView = [[UIView alloc] init];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];

    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [containerView addSubview:btn];
    btn.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
//    [btn setImage:[UIImage imageNamed:@"Placeholder"] forState:UIControlStateNormal];
    [btn setTitle:@"哈哈" forState:UIControlStateNormal];
    [btn gx_addTapBlock:^(UIButton * _Nonnull btn) {
        NSLog(@"哈哈");
    }];
    btn.layer.masksToBounds = YES;
    [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containerView.mas_centerX);
        make.top.equalTo(containerView.mas_top).offset(10);
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
        UILabel *label = [[UILabel alloc] init];
        [containerView addSubview:label];
        label.backgroundColor = [UIColor colorWithWhite:0.93 alpha:1];
        label.numberOfLines = 0;
        label.textAlignment =  NSTextAlignmentCenter;
        label.textColor = [UIColor redColor];
        label.text = @"激动-激动-激动\n激动-激动-温柔";
        [label gx_addAttributeTapWithStrings:@[@"激动",@"温柔"] delegate:self];
        [label mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.top.equalTo(btn.mas_bottom).offset(20);
            make.width.height.mas_equalTo(200);
        }];
        [label gx_roundedCornerWithAllRadius:100];
        [label gx_BorderWithColor:[UIColor orangeColor] borderWidth:1];
        [label.superview layoutIfNeeded];
        [label gx_cornerRadius:100];
        [label gx_cornerRadius:100 borderWidth:1 borderColor:[UIColor redColor]];
        
        UITextView *textView = [[UITextView alloc] init];
        textView.backgroundColor = [UIColor orangeColor];
        [containerView addSubview:textView];
        textView.gx_placeholder = @"温柔温柔";
        [textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(10);
            make.right.equalTo(self.view.mas_right).offset(-10);
            make.top.equalTo(label.mas_bottom).offset(10);
            make.width.height.mas_equalTo(200);
        }];
    
    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dataArr" ofType:@"plist"]];
    NSLog(@"\n%@",dataDic);
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@",@"14415"];
    
    UIImage *logo = [[UIImage imageNamed:@"Placeholder"] gx_imageWithCornerRadius:10 andSize:CGSizeMake(ScreenWidth*0.1, ScreenWidth*0.1)];
    
    UIImage *footImage1 = [UIImage gx_qrCodeImageForDataDic:dataDic size:ScreenWidth*0.5 logo:logo];
    UIImage *footImage2 = [UIImage gx_qrCodeImageForDataUrl:url size:ScreenWidth*0.5 logo:logo];
    UIImage *footImage3 = [UIImage gx_qrImageByContent:url];
    UIImage *footImage4 = [UIImage gx_qrImageByContent:url outputSize:ScreenWidth*0.5];
    UIImage *footImage5 = [UIImage gx_qrImageByContent:url outputSize:ScreenWidth*0.5 color:[UIColor orangeColor]];
    UIImage *footImage6 = [UIImage gx_qrImageByContent:url outputSize:ScreenWidth*0.5 tintColor:[UIColor orangeColor] logo:logo logoFrame:CGRectMake(ScreenWidth*0.1, ScreenWidth*0.2, ScreenWidth *0.1, ScreenWidth *0.1) isCorrectionHighLevel:YES];

    NSMutableArray *urlArr = [NSMutableArray arrayWithObjects:footImage1,footImage2,footImage3,footImage4,footImage5,footImage6, nil];
    
    UIImageView *hhhImageView;
    for (int i = 0 ; i<urlArr.count; i++) {
        UIImageView *codeImageView = ({
            UIImageView *ppImageView = [[UIImageView alloc] init];
            ppImageView.contentMode = UIViewContentModeScaleAspectFit;
            ppImageView.layer.masksToBounds = YES;
            ppImageView.clipsToBounds = YES;
            ppImageView;
        });
        [containerView addSubview:codeImageView];
        
        UIImage *qrimage = urlArr[i];
        codeImageView.image = qrimage;
        if(i==0){
            [codeImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(containerView.mas_centerX);
                make.top.equalTo(textView.mas_bottom).offset(20);
                make.width.height.mas_equalTo(ScreenWidth*0.5);
            }];
        } else{
            [codeImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(containerView.mas_centerX);
                make.top.equalTo(hhhImageView.mas_bottom).offset(20);
                make.width.height.mas_equalTo(ScreenWidth*0.5);
            }];
        }

        hhhImageView = codeImageView;
    }

    
    // 设置过渡视图的底边距（此设置将影响到scrollView的contentSize）这个也是关键的一步
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(hhhImageView.mas_bottom).offset(80+kSafeHeight);
    }];
    
    [UIImage gx_requestSizeNoHeader:[NSURL URLWithString:@"https://img2.baidu.com/it/u=787509579,3031904838&fm=253&fmt=auto&app=138&f=PNG?w=1115&h=500"] completion:^(NSURL *imgURL, CGSize size) {
        NSLog(@"哈哈 %@--%f--%f",imgURL,size.width,size.height);
    }];

}
- (void)gx_tapAttributeInLabel:(UILabel *)label
                        string:(NSString *)string
                         range:(NSRange)range
                         index:(NSInteger)index
{
    NSLog(@"哈哈 %@--%ld--%ld--%ld",string,range.location,range.length,index);
}

@end
