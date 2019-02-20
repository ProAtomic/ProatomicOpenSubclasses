//
//  PASStackButton.h
//  Pods
//
//  Created by Guillermo Saenz on 5/10/16.
//
//

@import UIKit;

@interface PASStackButton : UIControl

/**
 This method instances the PASStackButton with a CGZero origin point.
 */
+ (instancetype)button;
/**
 This method instances the PASStackButton with an specified origin point.
 */
+ (instancetype)buttonWithOrigin:(CGPoint)origin;

/**
 This is a boolean value, which will describe whether the Menu is showing or not.
 */
@property(nonatomic, assign, readonly, getter=isShowingMenu) BOOL showMenu;

/**
 This method will display the Menu with an animation.
 */
- (void)manuallyAnimateToMenu;

/**
 This method will dismiss the Menu with an animation.
 */
- (void)manuallyAnimateToClose;

@end
