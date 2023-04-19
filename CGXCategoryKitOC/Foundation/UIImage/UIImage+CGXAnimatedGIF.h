// UIImage+CGXAnimatedGIF.h
//  CGXCategoryKit-OC
//
//  Created by CGX on 2020/10/01.
//  Copyright © 2020年 CGX. All rights reserved.
//


#import <UIKit/UIKit.h>

/**
        UIImage (animatedGIF)
        
    This category adds class methods to `UIImage` to create an animated `UIImage` from an animated GIF.
*/
@interface UIImage (CGXAnimatedGIF)

/*
        UIImage *animation = [UIImage animatedImageWithAnimatedGIFData:theData];
    
    I interpret `theData` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
    
    The GIF stores a separate duration for each frame, in units of centiseconds (hundredths of a second).  However, a `UIImage` only has a single, total `duration` property, which is a floating-point number.
    
    To handle this mismatch, I add each source image (from the GIF) to `animation` a varying number of times to match the ratios between the frame durations in the GIF.
    
    For example, suppose the GIF contains three frames.  Frame 0 has duration 3.  Frame 1 has duration 9.  Frame 2 has duration 15.  I divide each duration by the greatest common denominator of all the durations, which is 3, and add each frame the resulting number of times.  Thus `animation` will contain frame 0 3/3 = 1 time, then frame 1 9/3 = 3 times, then frame 2 15/3 = 5 times.  I set `animation.duration` to (3+9+15)/100 = 0.27 seconds.
*/
+ (nullable UIImage *)gx_animatedImageWithAnimatedGIFData:(NSData *)theData;

/*
        UIImage *image = [UIImage animatedImageWithAnimatedGIFURL:theURL];
    
    I interpret the contents of `theURL` as a GIF.  I create an animated `UIImage` using the source images in the GIF.
    
    I operate exactly like `+[UIImage animatedImageWithAnimatedGIFData:]`, except that I read the data from `theURL`.  If `theURL` is not a `file:` URL, you probably want to call me on a background thread or GCD queue to avoid blocking the main thread.
*/
+ (UIImage *)gx_animatedImageWithAnimatedGIFURL:(NSURL *)theURL;


+ (UIImage *)gx_animatedGIFNamed:(NSString *)name;

+ (UIImage *)gx_animatedGIFWithData:(NSData *)data;

- (UIImage *)gx_animatedImageByScalingAndCroppingToSize:(CGSize)size;


/**
 Whether the data is animated GIF.
 
 @param data Image data
 
 @return Returns YES only if the data is gif and contains more than one frame,
         otherwise returns NO.
 */
+ (BOOL)gx_isAnimatedGIFData:(NSData *)data;

/**
 Whether the file in the specified path is GIF.
 
 @param path An absolute file path.
 
 @return Returns YES if the file is gif, otherwise returns NO.
 */
+ (BOOL)gx_isAnimatedGIFFile:(NSString *)path;
/**
 Create an image from a PDF file data or path.
 
 @discussion If the PDF has multiple page, is just return's the first page's
 content. Image's scale is equal to current screen's scale, size is same as
 PDF's origin size.
 
 @param dataOrPath PDF data in `NSData`, or PDF file path in `NSString`.
 
 @return A new image create from PDF, or nil when an error occurs.
 */
+ (nullable UIImage *)gx_imageWithPDF:(id _Nonnull)dataOrPath;

/**
 Create an image from a PDF file data or path.
 
 @discussion If the PDF has multiple page, is just return's the first page's
 content. Image's scale is equal to current screen's scale.
 
 @param dataOrPath  PDF data in `NSData`, or PDF file path in `NSString`.
 
 @param size     The new image's size, PDF's content will be stretched as needed.
 
 @return A new image create from PDF, or nil when an error occurs.
 */
+ (nullable UIImage *)gx_imageWithPDF:(id _Nonnull)dataOrPath size:(CGSize)size;
@end
