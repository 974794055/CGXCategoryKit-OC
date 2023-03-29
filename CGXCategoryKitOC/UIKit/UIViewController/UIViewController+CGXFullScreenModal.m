//
//  UIViewController+CGXFullScreenModal.m
//  CGXCategoryKitOC
//
//  Created by CGX on 2022/9/20.
//

#import "UIViewController+CGXFullScreenModal.h"
#import <objc/runtime.h>
@implementation UIViewController (CGXFullScreenModal)
+ (void)load{
    [super load];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSel = @selector(presentViewController:animated:completion:);
        SEL overrideSel = @selector(gx_override_presentViewController:animated:completion:);
        
        Method originalMet = class_getInstanceMethod(self.class, originalSel);
        Method overrideMet = class_getInstanceMethod(self.class, overrideSel);
        
        method_exchangeImplementations(originalMet, overrideMet);
    });
}
 
#pragma mark - Swizzling
- (void)gx_override_presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL) animated completion:(void (^ __nullable)(void))completion{
    if(@available(iOS 13.0, *)){
        if (viewControllerToPresent.modalPresentationStyle ==  UIModalPresentationPageSheet){
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    [self gx_override_presentViewController:viewControllerToPresent animated: animated completion:completion];
}
   
@end
