//
//  PASDatePickerView.h
//  ProatomicOpenSubclasses
//
//  Created by Guillermo Saenz on 6/11/16.
//
//

@import UIKit;

typedef enum : NSUInteger {
    PADatePickerViewTypeDayAndMonth,
    PADatePickerViewTypeMonthAndYear,
    PADatePickerViewTypeDayAndYear,
    PADatePickerViewTypeAll
} PADatePickerViewType;

@protocol PASDatePickerViewDelegate;

@interface PASDatePickerView : UIPickerView

@property (nonnull, nonatomic, strong, readonly) NSDate *date;
@property (nonnull, nonatomic, strong) NSDate *minimumDate;
@property (nonnull, nonatomic, strong) NSDate *maximumDate;

@property(nullable,nonatomic,weak) id <PASDatePickerViewDelegate>   datePickerViewDelegate;

@property (nonatomic, assign, readonly) PADatePickerViewType datePickerViewType;

- (void)setDatePickerViewType:(PADatePickerViewType)datePickerViewType;
- (void)setDate:(nonnull NSDate *)date animated:(BOOL)animated;

@end

@protocol PASDatePickerViewDelegate<NSObject>
@optional

- (void)datePickerView:(PASDatePickerView *_Nullable)datePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

@end

