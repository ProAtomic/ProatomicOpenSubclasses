//
//  PASStackButton.m
//  Pods
//
//  Created by Guillermo Saenz on 5/10/16.
//
//

#import "PASStackButton.h"

#import <pop/POP.h>


@interface PASStackButton ()

@property(nonatomic, strong) CALayer *topLayer;
@property(nonatomic, strong) CALayer *middleLayer;
@property(nonatomic, strong) CALayer *bottomLayer;

@end

@implementation PASStackButton {
    BOOL _didSetup, _didLayoutSubviews;
}

+ (instancetype)button{
    return [self buttonWithOrigin:CGPointZero];
}

+ (instancetype)buttonWithOrigin:(CGPoint)origin{
    return [[self alloc] initWithFrame:CGRectMake(origin.x, origin.y, 24, 17)];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupMBSB];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupMBSB];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupMBSB];
    }
    return self;
}

#pragma mark - Instance methods

- (void)tintColorDidChange{
    CGColorRef color = [self.tintColor CGColor];
    self.topLayer.backgroundColor = color;
    self.middleLayer.backgroundColor = color;
    self.bottomLayer.backgroundColor = color;
}

#pragma mark - Private Instance methods

- (void)animateToMenu{
    [self removeAllAnimations];
    
    CGFloat height = CGRectGetHeight(self.topLayer.bounds);
    
    POPBasicAnimation *fadeAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    fadeAnimation.duration = 0.3;
    fadeAnimation.toValue = @1;
    
    POPBasicAnimation *positionTopAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionTopAnimation.duration = 0.3;
    positionTopAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds),
                                                                         roundf(CGRectGetMinY(self.bounds)+(height/2)))];
    
    POPBasicAnimation *positionBottomAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionTopAnimation.duration = 0.3;
    positionBottomAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetMidX(self.bounds),
                                                                            roundf(CGRectGetMaxY(self.bounds)-(height/2)))];
    
    POPSpringAnimation *transformTopAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformTopAnimation.toValue = @(0);
    transformTopAnimation.springBounciness = 20.f;
    transformTopAnimation.springSpeed = 20;
    transformTopAnimation.dynamicsTension = 1000;
    
    POPSpringAnimation *transformBottomAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformBottomAnimation.toValue = @(0);
    transformBottomAnimation.springBounciness = 20.0f;
    transformBottomAnimation.springSpeed = 20;
    transformBottomAnimation.dynamicsTension = 1000;
    
    [self.topLayer pop_addAnimation:positionTopAnimation forKey:@"positionTopAnimation"];
    [self.topLayer pop_addAnimation:transformTopAnimation forKey:@"rotateTopAnimation"];
    [self.middleLayer pop_addAnimation:fadeAnimation forKey:@"fadeAnimation"];
    [self.bottomLayer pop_addAnimation:positionBottomAnimation forKey:@"positionBottomAnimation"];
    [self.bottomLayer pop_addAnimation:transformBottomAnimation forKey:@"rotateBottomAnimation"];
}

- (void)animateToX{
    [self removeAllAnimations];
    
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    POPBasicAnimation *fadeAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    fadeAnimation.toValue = @0;
    fadeAnimation.duration = 0.3;
    
    POPBasicAnimation *positionTopAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionTopAnimation.toValue = [NSValue valueWithCGPoint:center];
    positionTopAnimation.duration = 0.3;
    
    POPBasicAnimation *positionBottomAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
    positionBottomAnimation.toValue = [NSValue valueWithCGPoint:center];
    positionTopAnimation.duration = 0.3;
    
    POPSpringAnimation *transformTopAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformTopAnimation.toValue = @(M_PI_4);
    transformTopAnimation.springBounciness = 20.f;
    transformTopAnimation.springSpeed = 20;
    transformTopAnimation.dynamicsTension = 1000;
    
    POPSpringAnimation *transformBottomAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    transformBottomAnimation.toValue = @(-M_PI_4);
    transformBottomAnimation.springBounciness = 20.0f;
    transformBottomAnimation.springSpeed = 20;
    transformBottomAnimation.dynamicsTension = 1000;
    
    [self.topLayer pop_addAnimation:positionTopAnimation forKey:@"positionTopAnimation"];
    [self.topLayer pop_addAnimation:transformTopAnimation forKey:@"rotateTopAnimation"];
    [self.middleLayer pop_addAnimation:fadeAnimation forKey:@"fadeAnimation"];
    [self.bottomLayer pop_addAnimation:positionBottomAnimation forKey:@"positionBottomAnimation"];
    [self.bottomLayer pop_addAnimation:transformBottomAnimation forKey:@"rotateBottomAnimation"];
}

- (void)manuallyAnimateToMenu{
    if (self.isShowingMenu) return;
    [self animateToMenu];
    _showMenu = YES;
}

- (void)manuallyAnimateToClose{
    if (!self.isShowingMenu) return;
    [self animateToX];
    _showMenu = NO;
}

- (void)touchUpInsideHandler:(PASStackButton *)sender{
    if (!self.isShowingMenu) {
        [self animateToMenu];
    } else {
        [self animateToX];
    }
    _showMenu = !self.isShowingMenu;
}

- (void)setupMBSB{
    
    if (_didSetup) return;
    _didSetup = YES;
    
    [self addTarget:self action:@selector(touchUpInsideHandler:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (_didLayoutSubviews) return;
    _didLayoutSubviews = YES;
    
    CGFloat height = 2.f;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat cornerRadius =  1.f;
    CGColorRef color = [self.tintColor CGColor];
    
    self.topLayer = [CALayer layer];
    self.topLayer.frame = CGRectMake(0, CGRectGetMinY(self.bounds), width, height);
    self.topLayer.cornerRadius = cornerRadius;
    self.topLayer.backgroundColor = color;
    
    self.middleLayer = [CALayer layer];
    self.middleLayer.frame = CGRectMake(0, CGRectGetMidY(self.bounds)-(height/2), width, height);
    self.middleLayer.cornerRadius = cornerRadius;
    self.middleLayer.backgroundColor = color;
    
    self.bottomLayer = [CALayer layer];
    self.bottomLayer.frame = CGRectMake(0, CGRectGetMaxY(self.bounds)-height, width, height);
    self.bottomLayer.cornerRadius = cornerRadius;
    self.bottomLayer.backgroundColor = color;
    
    [self.layer addSublayer:self.topLayer];
    [self.layer addSublayer:self.middleLayer];
    [self.layer addSublayer:self.bottomLayer];
}

- (void)removeAllAnimations{
    [self.topLayer pop_removeAllAnimations];
    [self.middleLayer pop_removeAllAnimations];
    [self.bottomLayer pop_removeAllAnimations];
}

@end
