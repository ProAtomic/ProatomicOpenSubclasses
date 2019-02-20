//
//  PASBounceButton.h
//
//  Created by Fernando Pérez Guzmán on 14/03/2015.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

@import UIKit;

/**
 This is the Interface Builder Designable Interface for the PASBounceButton Class.
 */
IB_DESIGNABLE @interface PASBounceButton : UIButton

/**
 This is an IB accessible boolean value, which will determine whether the button should bounce on touch or not.
 */
@property (nonatomic, assign) IBInspectable BOOL shouldNotBounce;

/**
 This is an IB accessible NSUInteger value, which will determine the button's border width.
 */
@property (nonatomic, assign) IBInspectable NSUInteger borderWidth;

/**
 This is an IB accessible UIColor object, which will determine the button's border color for it's Enabled state.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *borderColorEnable;

/**
 This is an IB accessible UIColor object, which will determine the button's border color for it's Disabled state.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *borderColorDisable;

/**
 This is an IB accessible UIColor object, which will determine the button's background color for it's Selected state.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *backgroundColorSelected;

/**
 This is an IB accessible UIColor object, which will determine the button's background color for it's Highlighted state.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *backgroundColorHighlighted;

/**
 This is an IB accessible UIColor object, which will determine the button's background color for it's Disabled state.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *backgroundColorDisabled;

/**
 This is an IB accessible NSUInteger value, which will determine the button's corner radius.
 */
@property (nonatomic, assign) NSUInteger cornerRadious __attribute__ ((deprecated("This property was deprecated and replaced by cornerRadius.")));
@property (nonatomic, assign) IBInspectable NSUInteger cornerRadius;

/**
 This is an IB accessible NSUInteger value, which will determine the button's bounce speed.
 */
@property (nonatomic, assign) IBInspectable NSUInteger bounceSpeed;

/**
 This is an IB accessible NSUInteger value, which will determine how far the button will bounce.
 */
@property (nonatomic, assign) IBInspectable NSUInteger bounciness;

/**
 This is an IB accessible CGFloat value, which will determine the PASCustomFrameView's shadow radius.
 */
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;

/**
 This is an IB accessible UIColor object, which will determine the button's shadow color.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *shadowColor;

/**
 This is an IB accessible CGSize value, which will determine the button's shadow offset.
 */
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;

/**
 This is an IB accessible CGFloat value, which will determine the button's shadow opacity.
 */
@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;

@end
