//
//  PASBounceButton.m
//
//  Created by Fernando Pérez Guzmán on 14/03/2015.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PASBounceButton.h"

@import QuartzCore;
#import <pop/POP.h>


@interface PASBounceButton ()

@property (nullable, nonatomic, copy) UIColor *backgroundColorSaved;

@end

@implementation PASBounceButton {
    BOOL _didSetup, _didLayout, blocked;
}

#pragma mark - Lifecycle

// Para q siempre llame a setupBoton se pone en todos los inits posibles.
- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupMBBB];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupMBBB];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMBBB];
    }
    return self;
}

- (void)setupMBBB{
    
    if (_didSetup) return;
    _didSetup = YES;
    
    // Le dice q llamar para cada tipo de evento del boton.
    [self addTarget:self action:@selector(touching:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
    
    // ExclusiveTouch es para estar seguros del touch ya que hay muchos getos por todos lados
    [self setExclusiveTouch:YES];
    [self setClipsToBounds:YES];
    
    self.bounceSpeed = 40;
    self.bounciness = 20;
    self.shouldNotBounce = NO;
    self.cornerRadius = 0;
    self.borderWidth = 0;
    self.borderColorEnable = [UIColor blackColor];
    self.borderColorDisable = [UIColor blackColor];
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
    
    if (self.backgroundColorDisabled)[self setBackgroundColor:self.isEnabled?self.backgroundColorSaved:self.backgroundColorDisabled save:NO];
    if (self.backgroundColorSelected) [self setBackgroundColor:self.isSelected?self.backgroundColorSelected:self.backgroundColor save:NO];
    [self.layer setCornerRadius:self.cornerRadius];
    [self.layer setBorderWidth:self.borderWidth];
    [self.layer setBorderColor:self.isEnabled?self.borderColorEnable.CGColor:self.borderColorDisable.CGColor];
    
    if (self.shadowRadius>0) [self.layer setMasksToBounds:NO];
    [self.layer setShadowRadius:self.shadowRadius];
    [self.layer setShadowColor:self.shadowColor.CGColor];
    [self.layer setShadowOffset:self.shadowOffset];
    [self.layer setShadowOpacity:self.shadowOpacity];
}

#pragma mark - Setters

- (void)setSelected:(BOOL)selected{
    
    [super setSelected:selected];
    
    [self render];
}

- (void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    
    [self render];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor{
    [super setBackgroundColor:backgroundColor];
    
    self.backgroundColorSaved = self.backgroundColor;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor save:(BOOL)save {
    [super setBackgroundColor:backgroundColor];
    
    if (save)self.backgroundColorSaved = self.backgroundColor;
}

- (void)setBorderWidth:(NSUInteger)borderWidth{
    _borderWidth = borderWidth;
    
    [self render];
}

- (void)setBorderColorEnable:(UIColor *)borderColorEnable{
    _borderColorEnable = borderColorEnable;
    
    [self render];
}

- (void)setBorderColorDisable:(UIColor *)borderColorDisable{
    _borderColorDisable = borderColorDisable;
    
    [self render];
}

- (void)setBackgroundColorSelected:(UIColor *)backgroundColorSelected{
    _backgroundColorSelected = backgroundColorSelected;
    
    [self render];
}

- (void)setBackgroundColorHighlighted:(UIColor *)backgroundColorHighlighted{
    _backgroundColorHighlighted = backgroundColorHighlighted;
    
    [self render];
}

- (void)setBackgroundColorDisabled:(UIColor *)backgroundColorDisabled{
    _backgroundColorDisabled = backgroundColorDisabled;
    
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

#pragma mark - Actions

- (void)touchCancel:(UIButton*)sender{
    
    if (self.backgroundColorSaved) {
        [self setBackgroundColor:self.backgroundColorSaved save:NO];
    }
    
    if (self.shouldNotBounce) return;
    
    [sender.layer pop_removeAllAnimations];
    
    POPBasicAnimation *outSimple = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    [outSimple setToValue:[NSValue valueWithCGSize:CGSizeMake(1, 1)]];
    
    [sender.layer pop_addAnimation:outSimple forKey:@"outSimpleAnimation"];
    
    blocked = NO;
}

- (void)touching:(UIButton*)sender{
    
    if (self.backgroundColorHighlighted) {
        [self setBackgroundColor:self.backgroundColorHighlighted save:NO];
    }
    
    if (self.shouldNotBounce) return;
    
    blocked = YES;
    
    [sender.layer pop_removeAllAnimations];
    
    POPSpringAnimation *inAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    [inAnimation setSpringBounciness:self.bounciness];
    [inAnimation setSpringSpeed:self.bounceSpeed];
    [inAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(0.9, 0.9)]];
    
    [sender.layer pop_addAnimation:inAnimation forKey:@"inAnimation"];
}

- (void)touch:(UIButton*)sender{
    
    if (self.backgroundColorSaved) {
        [self setBackgroundColor:self.backgroundColorSaved save:NO];
    }
    
    if (self.shouldNotBounce) return;
    
    [sender.layer pop_removeAllAnimations];
    
    POPSpringAnimation *outAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    [outAnimation setSpringBounciness:self.bounciness];
    [outAnimation setSpringSpeed:self.bounceSpeed];
    [outAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(1, 1)]];
    
    [sender.layer pop_addAnimation:outAnimation forKey:@"outAnimation"];
    
    blocked = NO;
}

@end
