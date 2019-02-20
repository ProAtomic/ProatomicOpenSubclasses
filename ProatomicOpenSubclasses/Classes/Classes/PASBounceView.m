//
//  PASBounceView.m
//
//
//  Created by Guillermo Sáenz on 4/9/15.
//  Copyright (c) 2015 Property Atomic Strong SAC. All rights reserved.
//

#import "PASBounceView.h"

@import QuartzCore;
#import <pop/POP.h>


@implementation PASBounceView{
    BOOL _didSetup, _didLayout, blocked;
    UIColor *_defaultImageColor;
    UIColor *_defaultTitleColor;
    UIColor *_defaultBackgroundColor;
    UIImage *_defaultImage;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupPABV];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupPABV];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupPABV];
    }
    return self;
}

- (void)setupPABV{
    
    if (_didSetup) return;
    _didSetup = YES;
    
    // Le dice q llamar para cada tipo de evento del boton.
    [self addTarget:self action:@selector(touching:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchDragExit];
    [self addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchCancel];
    
    // ExclusiveTouch es para estar seguros del touch ya que hay muchos gestos por todos lados
    [self setExclusiveTouch:YES];
    
    self.bounceSpeed = 40;
    self.bounciness = 20;
    self.notBounce = NO;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (_didLayout) return;
    _didLayout = YES;
    
    _defaultImageColor = self.imageView.tintColor;
    _defaultTitleColor = self.labelTitle.textColor;
    _defaultBackgroundColor = self.backgroundColor;
    _defaultImage = self.imageView.image;
    if (self.useImageAsTemplate) [_imageView setImage:[_imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
    
    [self setBackgroundColor:_defaultBackgroundColor];
}

- (void)setSelected:(BOOL)selected{
    
    if (self.selected == selected) return;
    
    [super setSelected:selected];
    
    if (self.highligtedImageColor && self.useImageAsTemplate) {
        [self.imageView setTintColor:selected?self.highligtedImageColor:_defaultImageColor];
    }
    
    if (self.highligtedTitleColor) {
        [self.labelTitle setTextColor:selected?self.highligtedTitleColor:_defaultTitleColor];
    }
    
    if (self.highligtedImage) {
        [self.imageView setImage:selected?self.highligtedImage:_defaultImage];
    }
    
    if (self.highligtedBackgroundColor) {
        [self setBackgroundColor:selected?self.highligtedBackgroundColor:_defaultBackgroundColor];
    }
}

#pragma mark - Actions

- (void)touchCancel:(UIButton*)sender{
    [self setSelected:NO];
    
    if (self.shouldNotBounce) return;
    
    [self.layer pop_removeAllAnimations];
    
    POPBasicAnimation *outSimple = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    [outSimple setToValue:[NSValue valueWithCGSize:CGSizeMake(1, 1)]];
    
    [self.layer pop_addAnimation:outSimple forKey:@"outSimpleAnimation"];
    
    blocked = NO;
}

- (void)touching:(UIButton*)sender{
    [self setSelected:YES];
    
    if (self.shouldNotBounce) return;
    
    blocked = YES;
    
    [self.layer pop_removeAllAnimations];
    
    POPSpringAnimation *inAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    
    [inAnimation setSpringBounciness:self.bounciness];
    [inAnimation setSpringSpeed:self.bounceSpeed];
    [inAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(0.9, 0.9)]];
    
    [self.layer pop_addAnimation:inAnimation forKey:@"inAnimation"];
}

- (void)touch:(UIButton*)sender{
    [self setSelected:NO];
    
    if (self.shouldNotBounce) return;
    
    [self.layer pop_removeAllAnimations];
    
    POPSpringAnimation *outAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    [outAnimation setSpringBounciness:self.bounciness];
    [outAnimation setSpringSpeed:self.bounceSpeed];
    [outAnimation setToValue:[NSValue valueWithCGSize:CGSizeMake(1, 1)]];
    
    [self.layer pop_addAnimation:outAnimation forKey:@"outAnimation"];
    
    blocked = NO;
}

@end
