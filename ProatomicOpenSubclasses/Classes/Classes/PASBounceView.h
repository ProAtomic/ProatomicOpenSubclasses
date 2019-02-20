//
//  PASBounceView.h
//
//
//  Created by Guillermo Sáenz on 4/9/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PASCustomFrameView.h"

IB_DESIGNABLE @interface PASBounceView : PASCustomFrameView

/**
 This is an IB accessible NSUInteger value, which will determine how fast the view will bounce.
 */
@property (assign, nonatomic) IBInspectable NSUInteger bounceSpeed;

/**
 This is an IB accessible NSUInteger value, which will determine how far the view will bounce.
 */
@property (assign, nonatomic) IBInspectable NSUInteger bounciness;

/**
 This is an IB accessible boolean value, which will determine whether the view should bounce on touch or not
 */
@property (assign, nonatomic, getter=shouldNotBounce) IBInspectable BOOL notBounce;

/**
 This is an IB accessible UIColor object, which will determine the view's highlighted background color.
 */
@property (copy, nonatomic) IBInspectable UIColor *highligtedBackgroundColor;

/**
 This is an IB accessible UIColor object, which will determine the view's highlighted tint color.
 */
@property (copy, nonatomic) UIColor *highligtedTintColor __attribute__ ((deprecated("This property was deprecated. Use highligtedTitleColor & highligtedImageColor")));

/**
 This is an IB accessible boolean value, which will determine whether the image inside the imageView should be used as a template or not
 */
@property (assign, nonatomic, getter=useImageAsTemplate) IBInspectable BOOL useImageAsTemplate;

/**
 This is an IB accessible UIColor object, which will determine the view's highlighted image color.
 */
@property (copy, nonatomic) IBInspectable UIColor *highligtedImageColor;

/**
 This is an IB accessible UIColor object, which will determine the view's highlighted title color.
 */
@property (copy, nonatomic) IBInspectable UIColor *highligtedTitleColor;

/**
 This is an IB accessible UIColor object, which will determine the view's defaults image color.
 */
@property (copy, nonatomic) IBInspectable UIColor *imageColor;

/**
 This is an UIImageView object, which can be assigned through IB to display an image.
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

/**
 This is an IB accessible UIImage object, which will determine the image view's highlighted image.
 */
@property (copy, nonatomic) IBInspectable UIImage *highligtedImage;

/**
 This is an UILabel object, which can be assigned through IB to display text.
 */
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;

@end

