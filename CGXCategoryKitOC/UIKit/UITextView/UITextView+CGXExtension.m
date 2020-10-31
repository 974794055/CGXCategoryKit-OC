//
//  UITextView+CGXExtension.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020 CGX. All rights reserved.
//
//

#import "UITextView+CGXExtension.h"
#include <objc/runtime.h>
#import "UITextView+CGXPlaceholder.h"
@interface UITextView ()

@property (nonatomic, assign) BOOL addNoti;

@property (nonatomic, copy) NSString *lastTextStr;

@property (nonatomic, copy) void(^textHandle) (NSString *textStr);

@end

@implementation UITextView (CGXExtension)
- (void)setAddNoti:(BOOL)addNoti {
    
    objc_setAssociatedObject(self, &@selector(addNoti), [NSNumber numberWithBool:addNoti], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)addNoti {
    
    BOOL obj = [objc_getAssociatedObject(self, &@selector(addNoti)) boolValue];
    return obj;
}

- (void)setCharacterLengthPrompt:(BOOL)characterLengthPrompt {
    
    objc_setAssociatedObject(self, &@selector(characterLengthPrompt), [NSNumber numberWithBool:characterLengthPrompt], OBJC_ASSOCIATION_ASSIGN);
    
    //setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self addTextChangeNoti];
    [self setNeedsDisplay];
}

- (BOOL)characterLengthPrompt {
    
    id obj = objc_getAssociatedObject(self, &@selector(characterLengthPrompt));
    return [obj boolValue];
}

- (void)setTextHandle:(void (^)(NSString *))textHandle {
    
    objc_setAssociatedObject(self, &@selector(textHandle), textHandle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *))textHandle {
    
    id handle = objc_getAssociatedObject(self, &@selector(textHandle));
    if (handle) {
        
        return (void(^)(NSString *textStr))handle;
    }
    return nil;
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
- (void)gx_textDidChange:(void (^)(NSString *))handle {
    
    self.textHandle = handle;
    [self addTextChangeNoti];
}

/**
 *  监听文字改变
 */
- (void)textDidChange {
    
    //重绘
    [self characterTruncation];
    [self setNeedsDisplay];
}

- (void)setFont:(UIFont *)font {
    
    // setNeedsDisplay会在下一个消息循环时刻，调用drawRect:
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    //设置文字属性
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = self.font;
    attributes[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor lightGrayColor];
    
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat width = rect.size.width -2 * x;
    
    //画最大字符文本,添加文本显示边界
    if(self.characterLengthPrompt == YES) {
        
        [self setContentInset:UIEdgeInsetsMake(0, 0, 25, 0)];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        paragraphStyle.alignment = NSTextAlignmentRight;
        
        NSMutableDictionary *maximumLimitAttributes = [attributes mutableCopy];
        maximumLimitAttributes[NSParagraphStyleAttributeName] = paragraphStyle;
        
        NSString *limitStr = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length];
        
        [limitStr drawInRect:CGRectMake(x, rect.size.height-20+self.contentOffset.y, width, 20) withAttributes:maximumLimitAttributes];
    }
    //如果不需要显示最大字符限制文本，则把边界置为默认
    else {
        
        [self setContentInset:UIEdgeInsetsZero];
    }
    
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
}

- (void)characterTruncation {
    if((self.textHandle) && (![self.text isEqualToString:self.lastTextStr])) {
        
        self.textHandle(self.text);
    }
    self.lastTextStr = self.text;
}

- (void)addTextChangeNoti {
    
    if(self.addNoti == NO) {
        
        // 当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    self.addNoti = YES;
}

- (void)dealloc {
    
    if(self.addNoti == YES) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    }
}
@end
