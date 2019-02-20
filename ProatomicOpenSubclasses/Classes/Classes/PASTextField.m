//
//  PASTextField.m
//  Pods
//
//  Created by Guillermo Saenz on 5/9/16.
//
//

#import "PASTextField.h"

#import <ReactiveObjC/ReactiveObjC.h>


@interface PASTextField () <UITextFieldDelegate>{
    __weak id<UITextFieldDelegate> _myDelegate;
}

@property (nullable, nonatomic, copy) UIColor *backgroundColorSaved;

@end

@implementation PASTextField {
    BOOL _didInit, _didLayout, _didSetupRAC;
}

#pragma mark - Initialization

- (instancetype)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    if (_didInit) return;
    _didInit = YES;
    
    [self setDelegate:self];
    
    _acceptCopy = YES;
    _acceptPaste = YES;
    _acceptSelect = YES;
    _acceptSelectAll = YES;
    
    self.cornerRadius = 0;
    self.borderWidth = 0;
    
    [self render];
    
    self.textRectInsetValue = CGPointZero;
    self.editingRectInsetValue = CGPointZero;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (_didLayout) return;
    _didLayout = YES;
    
    [self render];
}

- (void)prepareForInterfaceBuilder{
    [super prepareForInterfaceBuilder];
    
    [self render];
}

- (void)render {
    
    [self.layer setCornerRadius:self.cornerRadius];
    [self.layer setBorderWidth:self.borderWidth];
    [self.layer setBorderColor:self.borderColor.CGColor];
}

#pragma mark - Setters

- (id<UITextFieldDelegate>)delegate{
    if (_myDelegate == (id<UITextFieldDelegate>)self) return nil;
    return _myDelegate;
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate{
    [super setDelegate:self];
    if ((delegate != self) && (delegate != _myDelegate)){
        _myDelegate = delegate;
    }
}

- (void)setPlaceholderTextColor:(UIColor *)placeholderTextColor{
    _placeholderTextColor = placeholderTextColor;
    
    if (placeholderTextColor){
        NSMutableAttributedString* attrString = [self.attributedPlaceholder mutableCopy];
        [attrString setAttributes: @{NSForegroundColorAttributeName:placeholderTextColor} range: NSMakeRange(0,  attrString.length)];
        self.attributedPlaceholder =  attrString;
    }
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    
    if (self.shouldUseSuperviewBackground) {
        [super setBackgroundColor:[UIColor clearColor]];
        [self.superview setBackgroundColor:backgroundColor];
    }else{
        [super setBackgroundColor:backgroundColor];
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.textRectInsetValue.x, self.textRectInsetValue.y);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.editingRectInsetValue.x, self.editingRectInsetValue.y);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, self.placeholderRectInsetValue.x, self.placeholderRectInsetValue.y);
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (_myDelegate != (id<UITextFieldDelegate>)self && [_myDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]){
        return [_myDelegate textFieldDidBeginEditing:textField];
    }
    
    if (self.backgroundColorHighlighted) {
        if (!self.backgroundColorSaved) {
            _backgroundColorSaved = self.shouldUseSuperviewBackground?self.superview.backgroundColor:self.backgroundColor;
        }
        
        [self setBackgroundColor:self.backgroundColorHighlighted];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if (_myDelegate != (id<UITextFieldDelegate>)self && [_myDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]){
        return [_myDelegate textFieldDidEndEditing:textField];
    }
    
    if (self.backgroundColorSaved) {
        [self setBackgroundColor:self.backgroundColorSaved];
    }
}

- (BOOL)textFieldShouldReturn:(PASTextField *)textField{
    
    if (_myDelegate != (id<UITextFieldDelegate>)self && [_myDelegate respondsToSelector:@selector(textFieldShouldReturn:)]){
        return [_myDelegate textFieldShouldReturn:textField];
    }
    
    UITextField *next = textField.nextTextField;
    if (next) {
        [next becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (_myDelegate != (id<UITextFieldDelegate>)self && [_myDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]){
        return [_myDelegate textFieldShouldBeginEditing:textField];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (_myDelegate != (id<UITextFieldDelegate>)self && [_myDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]){
        return [_myDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

#pragma mark - Perform Actions

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (action == @selector(copy:)) {
        return self.shouldAcceptCopy;
    }else if (action == @selector(paste:)) {
        return self.shouldAcceptPaste;
    }else if (action == @selector(select:)) {
        return self.shouldAcceptSelect;
    }else if (action == @selector(selectAll:)) {
        return self.shouldAcceptSelectAll;
    }
    
    return [super canPerformAction:action withSender:sender];
}

#pragma mark - RAC Extension

#pragma mark Setup

- (void)setupRAC {
    
    if (self.inputValidationBlock) {
        RAC(self, text) = [self.rac_textSignal map:self.inputValidationBlock];
    }
    
    if (self.dataValidationBlock) {
        RACSignal *validInput = [self.rac_textSignal map:self.dataValidationBlock];
        
        [validInput subscribeNext:^(NSNumber *isInputDataValid) {
            if (self->_didSetupRAC) self->_dataValid = isInputDataValid.boolValue;
        }];
    }
    
    _didSetupRAC = YES;
}

@end

