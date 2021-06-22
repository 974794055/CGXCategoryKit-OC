//
//  UITextField+CGXExtension.m
//  CGXAppStructure
//
//  Created by CGX on 2018/12/14.
//  Copyright © 2018年 CGX. All rights reserved.
//

#import "UITextField+CGXExtension.h"
#include <objc/runtime.h>

@interface UITextField ()

@property (nonatomic, assign) BOOL addNoti;

@property (nonatomic, copy) NSString *lastTextStr;

@property (nonatomic, copy) void(^textHandle) (NSString *textStr);

@end

@implementation UITextField (CGXExtension)
- (void)setGx_placeholderColor:(UIColor *)gx_placeholderColor {
    if (@available(iOS 13, *)) {
        NSDictionary *attributes = [self.attributedPlaceholder attributesAtIndex:0 effectiveRange:nil];
        NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:attributes];
        [attPlace addAttribute:NSForegroundColorAttributeName value:gx_placeholderColor range:NSMakeRange(0, attPlace.length)];
        self.attributedPlaceholder = attPlace;
    } else{
        [self setValue:gx_placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
    }
}

- (UIColor *)gx_placeholderColor {
    
    return self.gx_placeholderColor;
}
- (void)setGx_placeholderFont:(UIFont *)gx_placeholderFont
{
    if (@available(iOS 13, *)) {
        NSDictionary *attributes = [self.attributedPlaceholder attributesAtIndex:0 effectiveRange:nil];
        NSMutableAttributedString *attPlace = [[NSMutableAttributedString alloc] initWithString:self.placeholder attributes:attributes];
        [attPlace addAttribute:NSFontAttributeName value:gx_placeholderFont range:NSMakeRange(0, attPlace.length)];
        self.attributedPlaceholder = attPlace;
    } else{
        [self setValue:gx_placeholderFont forKeyPath:@"_placeholderLabel.font"];
    }
}
- (UIFont *)gx_placeholderFont
{
    return self.gx_placeholderFont;
}
- (void)setAddNoti:(BOOL)addNoti {
    
    objc_setAssociatedObject(self, @selector(addNoti), [NSNumber numberWithBool:addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, _cmd) boolValue];
    return obj;
}

- (void)setGx_maximumLimit:(NSInteger)gx_maximumLimit {
    
    objc_setAssociatedObject(self, @selector(gx_maximumLimit), @(gx_maximumLimit), OBJC_ASSOCIATION_ASSIGN);
    
    [self addTextChangeNoti];
}

- (NSInteger)gx_maximumLimit {
    
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setTextHandle:(void (^)(NSString *))textHandle {
    
    objc_setAssociatedObject(self, @selector(textHandle), textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))textHandle {
    
    return objc_getAssociatedObject(self, @selector(textHandle));
}

- (void)setLastTextStr:(NSString *)lastTextStr {
    
    objc_setAssociatedObject(self, @selector(lastTextStr), lastTextStr, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastTextStr {
    
    return [self emptyStr:objc_getAssociatedObject(self, _cmd)];
}
- (NSString *)emptyStr:(NSString *)str {
    
    if(([str isKindOfClass:[NSNull class]]) || ([str isEqual:[NSNull null]]) || (str == nil) || (!str)) {
        
        str = @"";
    }
    return str;
}
/**
 *  监听文字改变
 */
- (void)textDidChange {
    
    [self characterTruncation];
}

- (void)gx_textDidChange:(void (^)(NSString *))handle {
    
    self.textHandle = handle;
    [self addTextChangeNoti];
}

- (void)gx_fixMessyDisplay
{
    
    if(self.gx_maximumLimit <= 0) {self.gx_maximumLimit = MAXFLOAT;}
    [self addTextChangeNoti];
}

- (void)addTextChangeNoti {
    
    if(self.addNoti == NO) {
        
        // 当UITextField的文字发生改变时，UITextField自己会发出一个UITextFieldTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    }
    self.addNoti = YES;
}

- (NSString *)characterTruncation {
    
    //字符截取
    if(self.gx_maximumLimit > 0) {
        
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        //没有高亮选择的字，则对已输入的文字进行字数统计和限制,如果有高亮待选择的字，则暂不对文字进行统计和限制
        if ((position == nil) && (self.text.length > self.gx_maximumLimit)) {
            
            const char *res = [self.text substringToIndex:self.gx_maximumLimit].UTF8String;
            if (res == NULL) {
                self.text = [self.text substringToIndex:self.gx_maximumLimit - 1];
            }else{
                self.text = [self.text substringToIndex:self.gx_maximumLimit];
            }
        }
    }
    if((self.textHandle) && (![self.text isEqualToString:self.lastTextStr])) {
        
        self.textHandle(self.text);
    }
    self.lastTextStr = self.text;
    
    return self.text;
}

- (void)dealloc {
    
    if(self.addNoti == YES) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    }
}



@end
