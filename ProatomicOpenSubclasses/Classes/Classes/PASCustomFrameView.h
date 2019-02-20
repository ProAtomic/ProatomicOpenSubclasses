//
//  PASCustomFrameView.h
//
//
//  Created by Guillermo Sáenz on 6/13/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

@import UIKit;

/**
 This is the Interface Builder Designable Interface for the PASCustomFrameView Class.
 */
IB_DESIGNABLE @interface PASCustomFrameView : UIControl

/**
 This is an IB accessible NSUInteger value, which will determine the PASCustomFrameView's border width.
 */
@property (nonatomic, assign) IBInspectable NSUInteger borderWidth;

/**
 This is an IB accessible UIColor object, which will determine the PASCustomFrameView's border color.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *borderColor;

/**
 This is an IB accessible NSUInteger value, which will determine the PASCustomFrameView's corner radius.
 */
@property (nonatomic, assign) NSUInteger cornerRadious __attribute__ ((deprecated("This property was deprecated and replaced by cornerRadius.")));
@property (nonatomic, assign) IBInspectable NSUInteger cornerRadius;

/**
 This is an IB accessible CGFloat value, which will determine the PASCustomFrameView's shadow radius.
 */
@property (nonatomic, assign) IBInspectable CGFloat shadowRadius;

/**
 This is an IB accessible UIColor object, which will determine the PASCustomFrameView's shadow color.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *shadowColor;

/**
 This is an IB accessible CGSize value, which will determine the PASCustomFrameView's shadow offset.
 */
@property (nonatomic, assign) IBInspectable CGSize shadowOffset;

/**
 This is an IB accessible CGFloat value, which will determine the PASCustomFrameView's shadow opacity.
 */
@property (nonatomic, assign) IBInspectable CGFloat shadowOpacity;

/**
 This method adds an action to the PASCustomFrameView to perform when touchedUpInside event triggers.
 
 @param target This is the object which will perform the action
 @param action This is the method selector
 */
- (void)addTarget:(_Nonnull id)target action:(_Nonnull SEL)action;

@property (assign, nonatomic, getter=shouldLetTouchPass) IBInspectable BOOL letTouchPass;

@end

