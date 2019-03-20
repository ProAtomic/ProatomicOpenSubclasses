//
//  PASCustomFrameView.m
//
//
//  Created by Guillermo Sáenz on 6/13/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PASCustomFrameView.h"

@implementation PASCustomFrameView {
    BOOL _didSetup, _didLayout;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupMBCFV];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupMBCFV];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMBCFV];
    }
    return self;
}

- (void)setupMBCFV{
    
    if (_didSetup) return;
    _didSetup = YES;
    
    self.letTouchPass = NO;
    self.cornerRadius = 0;
    self.borderWidth = 0;
    self.borderColor = [UIColor blackColor];
    self.shadowRadius = 0;
    
    [self render];
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

- (void)render{
    
    if (self.cornerRadius>0) [self setClipsToBounds:YES];
    
    [self.layer setCornerRadius:self.cornerRadius];
    [self.layer setBorderWidth:self.borderWidth];
    [self.layer setBorderColor:self.borderColor.CGColor];
    
    if (self.shadowRadius>0) [self.layer setMasksToBounds:NO];
    [self.layer setShadowRadius:self.shadowRadius];
    [self.layer setShadowColor:self.shadowColor.CGColor];
    [self.layer setShadowOffset:self.shadowOffset];
    [self.layer setShadowOpacity:self.shadowOpacity];
}

- (void)setBorderWidth:(NSUInteger)borderWidth{
    _borderWidth = borderWidth;
    
    [self render];
}

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    
    [self render];
}

- (void)setCornerRadious:(NSUInteger)cornerRadious{
    _cornerRadious = cornerRadious;
    
    [self setCornerRadius:cornerRadious];
}

- (void)setCornerRadius:(NSUInteger)cornerRadius {
    _cornerRadius = cornerRadius;
    
    [self render];
}

- (void)setShadowColor:(UIColor *)shadowColor{
    _shadowColor = shadowColor;
    
    [self render];
}

- (void)setShadowOffset:(CGSize)shadowOffset{
    _shadowOffset = shadowOffset;
    
    [self render];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity{
    _shadowOpacity = shadowOpacity;
    
    [self render];
}

- (void)addTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (self.shouldLetTouchPass) {
        for (UIView *view in self.subviews) {
            if (!view.hidden && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
        }
        
        return NO;
    }
    
    return [super pointInside:point withEvent:event];
}

@end

