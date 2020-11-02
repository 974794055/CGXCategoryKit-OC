//
//  UIView+CGXDraggable.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (CGXDraggable)

/**-----------------------------------------------------------------------------
 * @name UIView+draggable Properties
 * -----------------------------------------------------------------------------
 */
/** The pan gestures that handles the view dragging
 gx_panGesture The tint color of the blurred view. Set to nil to reset.
 */
@property (nonatomic) UIPanGestureRecognizer *gx_panGesture;
/**
 A caging area such that the view can not be moved outside
 of this frame.
 
 If @c cagingArea is not @c CGRectZero, and @c cagingArea does not contain the
 view's frame then this does nothing (ie. if the bounds of the view extend the
 bounds of @c cagingArea).
 Optional. If not set, defaults to @c CGRectZero, which will result
 in no caging behavior.
 */
@property (nonatomic) CGRect gx_cagingArea;

/**
 Restricts the area of the view where the drag action starts.
 
 Optional. If not set, defaults to self.view.
 */
@property (nonatomic) CGRect gx_handle;

/**
 Restricts the movement along the X axis
 */
@property (nonatomic) BOOL gx_shouldMoveAlongX;

/**
 Restricts the movement along the Y axis
 */
@property (nonatomic) BOOL gx_shouldMoveAlongY;

/**
 Notifies when dragging started
 */
@property (nonatomic, copy) void (^gx_draggingStartedBlock)(void);

/**
 Notifies when dragging ended
 */
@property (nonatomic, copy) void (^gx_draggingEndedBlock)(void);


/**-----------------------------------------------------------------------------
 * @name UIView+draggable Methods
 * -----------------------------------------------------------------------------
 */

/** Enables the dragging
 *
 * Enables the dragging state of the view
 */
- (void)gx_enableDragging;

/** Disable or enable the view dragging
 *
 * @param draggable The boolean that enables or disables the draggable state
 */
- (void)gx_setDraggable:(BOOL)draggable;

@end
