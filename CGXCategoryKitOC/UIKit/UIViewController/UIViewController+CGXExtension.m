//
//  UIViewController+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UIViewController+CGXExtension.h"

@interface NSString(CGXExtensionUIViewController)

@end

@implementation NSString (CGXExtensionUIViewController)

/**
 验证非空字符串  如果为空 转换成 @"";
 */
+ (NSString *)gx_emptyString:(NSString *)str
 {
    if(([str isKindOfClass:[NSNull class]]) || ([str isEqual:[NSNull null]]) || (str == nil) || (!str)) {

        str = @"";
    }
    return str;
}

@end

@implementation UIViewController (CGXExtension)


- (UIViewController *)gx_findViewController:(NSString *)className {
    
    if([NSString gx_emptyString:className].length <= 0) return nil;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return nil;
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        if([controller isKindOfClass:class]) {
            
            return controller;
        }
    }
    return nil;
}

- (void)gx_deleteViewController:(NSString *)className complete:(void (^)(void))complete {
    
    if([NSString gx_emptyString:className].length <= 0) return;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return;
    
    __kindof NSMutableArray<UIViewController *> *controllers = [self.navigationController.viewControllers mutableCopy];
    
    for (UIViewController *vc in controllers) {
        
        if ([vc isKindOfClass:class]) {
            
            [controllers removeObject:vc];
            
            self.navigationController.viewControllers = [controllers copy];
            
            if(complete) {
                
                complete();
            }
            
            return;
        }
    }
}

- (void)gx_pushViewController:(NSString *)className animated:(BOOL)animated {
    
    if([NSString gx_emptyString:className].length <= 0) return;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return;
    
    UIViewController *viewController = [[class alloc]init];
    
    if(viewController == nil) return;
    
    [self.navigationController pushViewController:viewController animated:animated];
}

- (void)gx_preventCirculationPushViewController:(NSString *)className animated:(BOOL)animated {
    
    if([NSString gx_emptyString:className].length <= 0) return;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return;
    __weak typeof(self) weakSelf = self;
    [self gx_deleteViewController:className complete:^{
        
        UIViewController *viewController = [[class alloc]init];
        
        if(viewController == nil) return;
        
        [weakSelf.navigationController pushViewController:viewController animated:animated];
    }];
}

- (void)gx_popViewController:(NSString *)className animated:(BOOL)animated {
    
    if([NSString gx_emptyString:className].length <= 0) return;
    
    Class class = NSClassFromString(className);
    
    if (class == nil) return;
    
    __kindof NSArray<UIViewController *> *controllers = self.navigationController.viewControllers;
    
    for (UIViewController *vc in controllers) {
        
        if ([vc isKindOfClass:class]) {
            
            [self.navigationController popToViewController:vc animated:animated];
            
            return;
        }
    }
}

/**
 *  @brief  视图层级
 *
 *  @return 视图层级字符串
 */
-(NSString*)gx_recursiveDescription
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"\n"];
    [self gx_addDescriptionToString:description indentLevel:0];
    return description;
}

-(void)gx_addDescriptionToString:(NSMutableString*)string indentLevel:(NSInteger)indentLevel
{
    NSString *padding = [@"" stringByPaddingToLength:indentLevel withString:@" " startingAtIndex:0];
    [string appendString:padding];
    [string appendFormat:@"%@, %@",[self debugDescription],NSStringFromCGRect(self.view.frame)];

    for (UIViewController *childController in self.childViewControllers)
    {
        [string appendFormat:@"\n%@>",padding];
        [childController gx_addDescriptionToString:string indentLevel:indentLevel + 1];
    }
}
- (BOOL)gx_isVisible {
    return [self isViewLoaded] && self.view.window;
}
@end
