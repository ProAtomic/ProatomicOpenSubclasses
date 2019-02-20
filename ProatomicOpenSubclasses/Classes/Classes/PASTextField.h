//
//  PASTextField.h
//  Pods
//
//  Created by Guillermo Saenz on 5/9/16.
//
//

@import UIKit;

/**
 This is the Interface Builder Designable Interface for the PASTextField Class.
 */
IB_DESIGNABLE @interface PASTextField : UITextField

/**
 This is an UITextField object, which references the nextTextField in the form.
 */
@property (nullable, weak, nonatomic) IBOutlet UITextField *nextTextField;

/**
 This is an IB accessible boolean value, which will determine whether the PASTextField should inherit it's superview's background.
 */
@property (nonatomic, assign) IBInspectable BOOL shouldUseSuperviewBackground;

/**
 This is an IB accessible UIColor object, which will set the PASTextField's background color for it's highlighted state.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *backgroundColorHighlighted;

/**
 This is an IB accessible UIColor object, which will set the PASTextField's placeholder text color.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *placeholderTextColor;

/**
 This is an IB accessible boolean value, which determines whether the textfield can be copyed to clipboard.
 */
@property (nonatomic, assign, getter=shouldAcceptCopy) IBInspectable BOOL acceptCopy;

/**
 This is an IB accessible boolean value, which determines whether the textfield accepts pasting text from clipboard.
 */
@property (nonatomic, assign, getter=shouldAcceptPaste) IBInspectable BOOL acceptPaste;

/**
 This is an IB accessible boolean value, which determines whether the textfield accepts partial selection.
 */
@property (nonatomic, assign, getter=shouldAcceptSelect) IBInspectable BOOL acceptSelect;

/**
 This is an IB accessible boolean value, which determines whether the textfield accepts selecting All.
 */
@property (nonatomic, assign, getter=shouldAcceptSelectAll) IBInspectable BOOL acceptSelectAll;

/**
 This is an IB accessible NSUInteger value, which will determine the button's border width.
 */
@property (nonatomic, assign) IBInspectable NSUInteger borderWidth;

/**
 This is an IB accessible UIColor object, which will determine the button's border color for it's Enabled state.
 */
@property (nullable, nonatomic, copy) IBInspectable UIColor *borderColor;

/**
 This is an IB accessible NSUInteger value, which will determine the button's corner radius.
 */
@property (nonatomic, assign) IBInspectable NSUInteger cornerRadius;

@property (nonatomic, assign) IBInspectable CGPoint textRectInsetValue;

@property (nonatomic, assign) IBInspectable CGPoint editingRectInsetValue;

@property (nonatomic, assign) IBInspectable CGPoint placeholderRectInsetValue;

@property (nonatomic, copy, nullable) NSString * _Nullable (^inputValidationBlock)(NSString * _Nonnull text);
@property (nonatomic, copy, nullable) NSNumber * _Nullable (^dataValidationBlock)(NSString * _Nonnull text);
@property (nonatomic, assign, readonly, getter=isDataValid) BOOL dataValid;

- (void)setupRAC;

@end


