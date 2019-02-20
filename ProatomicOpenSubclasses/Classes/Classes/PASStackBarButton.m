//
//  PASStackBarButton.m
//  Pods
//
//  Created by Guillermo Saenz on 5/10/16.
//
//

#import "PASStackBarButton.h"

@implementation PASStackBarButton {
    BOOL isSetup;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupPASBB];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupPASBB];
    }
    return self;
}

- (void)setupPASBB{
    
    if (isSetup || self.customView) return;
    isSetup = YES;
    
    self.button = [PASStackButton button];
    [self setCustomView:self.button];
}

@end
