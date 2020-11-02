//
//  UIView+CGXDraggable.m
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//

#import "UIView+CGXDraggable.h"
#import <objc/runtime.h>

@implementation UIView (CGXDraggable)

- (void)setGx_panGesture:(UIPanGestureRecognizer*)panGesture
{
    objc_setAssociatedObject(self, @selector(gx_panGesture), panGesture, OBJC_ASSOCIATION_RETAIN);
}

- (UIPanGestureRecognizer*)gx_panGesture
{
    return objc_getAssociatedObject(self, @selector(gx_panGesture));
}

- (void)setGx_cagingArea:(CGRect)cagingArea
{
    if (CGRectEqualToRect(cagingArea, CGRectZero) ||
        CGRectContainsRect(cagingArea, self.frame)) {
        NSValue *cagingAreaValue = [NSValue valueWithCGRect:cagingArea];
        objc_setAssociatedObject(self, @selector(gx_cagingArea), cagingAreaValue, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CGRect)gx_cagingArea
{
    NSValue *cagingAreaValue = objc_getAssociatedObject(self, @selector(gx_cagingArea));
    return [cagingAreaValue CGRectValue];
}

- (void)setGx_handle:(CGRect)handle
{
    CGRect relativeFrame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    if (CGRectContainsRect(relativeFrame, handle)) {
        NSValue *handleValue = [NSValue valueWithCGRect:handle];
        objc_setAssociatedObject(self, @selector(gx_handle), handleValue, OBJC_ASSOCIATION_RETAIN);
    }
}

- (CGRect)gx_handle
{
    NSValue *handleValue = objc_getAssociatedObject(self, @selector(gx_handle));
    return [handleValue CGRectValue];
}

- (void)setGx_shouldMoveAlongY:(BOOL)newShould
{
    NSNumber *shouldMoveAlongYBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(gx_shouldMoveAlongY), shouldMoveAlongYBool, OBJC_ASSOCIATION_RETAIN );
}

- (BOOL)gx_shouldMoveAlongY
{
    NSNumber *moveAlongY = objc_getAssociatedObject(self, @selector(gx_shouldMoveAlongY));
    return (moveAlongY) ? [moveAlongY boolValue] : YES;
}

- (void)setGx_shouldMoveAlongX:(BOOL)newShould
{
    NSNumber *shouldMoveAlongXBool = [NSNumber numberWithBool:newShould];
    objc_setAssociatedObject(self, @selector(gx_shouldMoveAlongX), shouldMoveAlongXBool, OBJC_ASSOCIATION_RETAIN );
}

- (BOOL)gx_shouldMoveAlongX
{
    NSNumber *moveAlongX = objc_getAssociatedObject(self, @selector(gx_shouldMoveAlongX));
    return (moveAlongX) ? [moveAlongX boolValue] : YES;
}

- (void)setGx_draggingStartedBlock:(void (^)(void))draggingStartedBlock
{
    objc_setAssociatedObject(self, @selector(gx_draggingStartedBlock), draggingStartedBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void (^)(void))gx_draggingStartedBlock
{
    return objc_getAssociatedObject(self, @selector(gx_draggingStartedBlock));
}

- (void)setGx_draggingEndedBlock:(void (^)(void))draggingEndedBlock
{
    objc_setAssociatedObject(self, @selector(gx_draggingEndedBlock), draggingEndedBlock, OBJC_ASSOCIATION_RETAIN);
}

- (void (^)(void))gx_draggingEndedBlock
{
    return objc_getAssociatedObject(self, @selector(gx_draggingEndedBlock));
}

- (void)gx_handlePan:(UIPanGestureRecognizer*)sender
{
    // Check to make you drag from dragging area
    CGPoint locationInView = [sender locationInView:self];
    if (!CGRectContainsPoint(self.gx_handle, locationInView)) {
        return;
    }
    
    [self gx_adjustAnchorPointForGestureRecognizer:sender];
    
    if (sender.state == UIGestureRecognizerStateBegan && self.gx_draggingStartedBlock) {
        self.gx_draggingStartedBlock();
    }
    
    if (sender.state == UIGestureRecognizerStateEnded && self.gx_draggingEndedBlock) {
        self.gx_draggingEndedBlock();
    }
    
    CGPoint translation = [sender translationInView:[self superview]];
    
    CGFloat newXOrigin = CGRectGetMinX(self.frame) + (([self gx_shouldMoveAlongX]) ? translation.x : 0);
    CGFloat newYOrigin = CGRectGetMinY(self.frame) + (([self gx_shouldMoveAlongY]) ? translation.y : 0);
    
    CGRect cagingArea = self.gx_cagingArea;
    
    CGFloat cagingAreaOriginX = CGRectGetMinX(cagingArea);
    CGFloat cagingAreaOriginY = CGRectGetMinY(cagingArea);
    
    CGFloat cagingAreaRightSide = cagingAreaOriginX + CGRectGetWidth(cagingArea);
    CGFloat cagingAreaBottomSide = cagingAreaOriginY + CGRectGetHeight(cagingArea);
    
    if (!CGRectEqualToRect(cagingArea, CGRectZero)) {
        
        // Check to make sure the view is still within the caging area
        if (newXOrigin <= cagingAreaOriginX ||
            newYOrigin <= cagingAreaOriginY ||
            newXOrigin + CGRectGetWidth(self.frame) >= cagingAreaRightSide ||
            newYOrigin + CGRectGetHeight(self.frame) >= cagingAreaBottomSide) {
            
            // Don't move
            newXOrigin = CGRectGetMinX(self.frame);
            newYOrigin = CGRectGetMinY(self.frame);
        }
    }
    
    [self setFrame:CGRectMake(newXOrigin,
                              newYOrigin,
                              CGRectGetWidth(self.frame),
                              CGRectGetHeight(self.frame))];
    
    [sender setTranslation:(CGPoint){0, 0} inView:[self superview]];
}

- (void)gx_adjustAnchorPointForGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        UIView *piece = self;
        CGPoint locationInView = [gestureRecognizer locationInView:piece];
        CGPoint locationInSuperview = [gestureRecognizer locationInView:piece.superview];
        
        piece.layer.anchorPoint = CGPointMake(locationInView.x / piece.bounds.size.width, locationInView.y / piece.bounds.size.height);
        piece.center = locationInSuperview;
    }
}

- (void)gx_setDraggable:(BOOL)draggable
{
    [self.gx_panGesture setEnabled:draggable];
}

- (void)gx_enableDragging
{
    self.gx_panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gx_handlePan:)];
    [self.gx_panGesture setMaximumNumberOfTouches:1];
    [self.gx_panGesture setMinimumNumberOfTouches:1];
    [self.gx_panGesture setCancelsTouchesInView:NO];
    [self setGx_handle:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addGestureRecognizer:self.gx_panGesture];
}

@end
