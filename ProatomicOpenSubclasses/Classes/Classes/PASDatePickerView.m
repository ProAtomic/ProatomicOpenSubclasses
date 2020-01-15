//
//  PASDatePickerView.m
//  ProatomicOpenSubclasses
//
//  Created by Guillermo Saenz on 6/11/16.
//
//

#import "PASDatePickerView.h"

@interface PASDatePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>{
    __weak id<UIPickerViewDelegate> _myDelegate;
}

@property (nonatomic, strong) NSArray *monthNames;
@property (nonatomic, assign) NSUInteger year;

@end

@implementation PASDatePickerView{
    BOOL _didCommonInit;
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

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self commonInit];
}

- (void)commonInit{
    if (_didCommonInit) return;
    _didCommonInit = YES;
    
    _datePickerViewType = PADatePickerViewTypeAll;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [dateComponents setYear:dateComponents.year-100];
    _minimumDate = [calendar dateFromComponents:dateComponents];
    _maximumDate = [NSDate date];
    
    [self setDataSource:self];
    [self setDelegate:self];
    [self setShowsSelectionIndicator:YES];
    
    [self reloadData];
}

- (void)reloadData {
    [self reloadData:NO];
}

- (void)reloadData:(BOOL)force {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]]];
    self.monthNames = [dateFormatter monthSymbols];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.maximumDate];
    
    _year = dateComponents.year;
    
    if (_date || force) {
        [dateComponents setDay:1];
        [dateComponents setMonth:1];
        [dateComponents setYear:dateComponents.year];
        _date = [calendar dateFromComponents:dateComponents];
        
        [self reloadAllComponents];
    }
}

#pragma mark - Setters

- (void)setDatePickerViewType:(PADatePickerViewType)datePickerViewType {
    _datePickerViewType = datePickerViewType;
    
    [self reloadData];
}

- (void)setDate:(NSDate *)date {
    [self setDate:date animated:NO];
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    
    [self checkDateBounds];
    [self reloadData];
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    
    [self checkDateBounds];
    [self reloadData];
}

#pragma mark - Delegate

- (id<UIPickerViewDelegate>)delegate{
    return _myDelegate;
}

- (void)setDelegate:(id<UIPickerViewDelegate>)delegate{
    [super setDelegate:self];
    
    if (delegate != _myDelegate){
        _myDelegate = delegate;
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    switch (self.datePickerViewType) {
            case PADatePickerViewTypeAll:
            return 3;
            break;
        default:
            return 2;
            break;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    NSUInteger number = 0;
    
    if (component == 0) {
        switch (self.datePickerViewType) {
                case PADatePickerViewTypeMonthAndYear:
                return 12;
                break;
                case PADatePickerViewTypeAll:
                case PADatePickerViewTypeDayAndMonth:
                case PADatePickerViewTypeDayAndYear:
                return [self getNumberOfDaysInPickerView:pickerView];
                break;
        }
    } else if (component == 1) {
        switch (self.datePickerViewType) {
                case PADatePickerViewTypeDayAndYear:
                case PADatePickerViewTypeMonthAndYear:
                return [self getNumberOfYears];
                break;
                case PADatePickerViewTypeAll:
                case PADatePickerViewTypeDayAndMonth:
                return 12;
                break;
        }
    } else if (component == 2){
        return [self getNumberOfYears];
    }
    
    return number;
}

- (nullable NSString *)pickerView:(PASDatePickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    NSString *result;
    if (component == 0) {
        switch (self.datePickerViewType) {
                case PADatePickerViewTypeMonthAndYear:
                result = [self.monthNames objectAtIndex:row];
                break;
                case PADatePickerViewTypeAll:
                case PADatePickerViewTypeDayAndYear:
                case PADatePickerViewTypeDayAndMonth:
                result = [NSString stringWithFormat:@"%li", (long)(row+1)];
                break;
        }
    } else if (component == 1) {
        switch (self.datePickerViewType) {
                case PADatePickerViewTypeDayAndYear:
                case PADatePickerViewTypeMonthAndYear:
                result = [NSString stringWithFormat:@"%li", (long)(self.year-row)];
                break;
                case PADatePickerViewTypeAll:
                case PADatePickerViewTypeDayAndMonth:
                result = [self.monthNames objectAtIndex:row];
                break;
        }
    } else if (component == 2){
        result = [NSString stringWithFormat:@"%li", (long)(self.year-row)];
    }
    
    if (_myDelegate != (id<UIPickerViewDelegate>)self && [_myDelegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]){
        [_myDelegate pickerView:pickerView titleForRow:row forComponent:component];
    }
    
    return result;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (_myDelegate != (id<UIPickerViewDelegate>)self && [_myDelegate respondsToSelector:@selector(pickerView:attributedTitleForRow:forComponent:)]){
        [_myDelegate pickerView:pickerView attributedTitleForRow:row forComponent:component];
    }
    
    return NULL;
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (!self.date) {
        [self reloadData:YES];
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.date];
    
    if (component == 0) {
        switch (self.datePickerViewType) {
                case PADatePickerViewTypeMonthAndYear:
                [dateComponents setMonth:row+1];
                break;
                case PADatePickerViewTypeAll:
                case PADatePickerViewTypeDayAndYear:
                case PADatePickerViewTypeDayAndMonth:
                [dateComponents setDay:row+1];
                break;
        }
    } else if (component == 1) {
        switch (self.datePickerViewType) {
                case PADatePickerViewTypeDayAndYear:
                [pickerView reloadComponent:0];
                [dateComponents setDay:[self selectedRowInComponent:0]+1];
                [dateComponents setYear:_year - row];
                case PADatePickerViewTypeMonthAndYear:
                [pickerView reloadComponent:0];
                [dateComponents setMonth:[self selectedRowInComponent:0]+1];
                [dateComponents setYear:_year - row];
                break;
                case PADatePickerViewTypeAll:
                case PADatePickerViewTypeDayAndMonth:
                [pickerView reloadComponent:0];
                [dateComponents setDay:[self selectedRowInComponent:0]+1];
                [dateComponents setMonth:row+1];
                break;
        }
    } else if (component == 2){
        [pickerView reloadComponent:0];
        [pickerView reloadComponent:1];
        [dateComponents setDay:[self selectedRowInComponent:0]+1];
        [dateComponents setMonth:[self selectedRowInComponent:1]+1];
        [dateComponents setYear:_year - row];
    }
    
    _date = [calendar dateFromComponents:dateComponents];
    
    if (_myDelegate != (id<UIPickerViewDelegate>)self && [_myDelegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]){
        [_myDelegate pickerView:pickerView didSelectRow:row inComponent:component];
    }
    
    if ([self.datePickerViewDelegate respondsToSelector:@selector(datePickerView:didSelectRow:inComponent:)]) {
        [self.datePickerViewDelegate datePickerView:pickerView didSelectRow:row inComponent:component];
    }
}

#pragma mark - Helpers

- (void)checkDateBounds {
    if ([self date:self.minimumDate isLaterThan:self.maximumDate] || [self.minimumDate isEqualToDate:self.maximumDate]) {
        NSAssert(NO, @"Minum date can't be later or equal than maximum date");
    }
}

- (BOOL)date:(NSDate *)date isLaterThan:(NSDate *)otherDate{
    return [date compare:otherDate] == NSOrderedDescending;
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated {
    NSAssert(date, @"Date can't be NULL");
    _date = date;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [[NSTimeZone alloc] initWithName:@"GMT"];
    
    [dateFormatter setDateFormat:@"dd"];
    NSInteger day = [dateFormatter stringFromDate:date].integerValue;
    
    [dateFormatter setDateFormat:@"MM"];
    NSInteger month = [dateFormatter stringFromDate:date].integerValue;
    
    [dateFormatter setDateFormat:@"yy"];
    NSInteger year = [dateFormatter stringFromDate:date].integerValue;
    
    switch (self.datePickerViewType) {
            case PADatePickerViewTypeDayAndYear:
            [self selectRow:day-1 inComponent:0 animated:animated];
            [self selectRow:_year - year inComponent:1 animated:animated];
            break;
            case PADatePickerViewTypeMonthAndYear:
            [self selectRow:month-1 inComponent:0 animated:animated];
            [self selectRow:_year - year inComponent:1 animated:animated];
            break;
            case PADatePickerViewTypeDayAndMonth:
            [self selectRow:day-1 inComponent:0 animated:animated];
            [self selectRow:month-1 inComponent:1 animated:animated];
            break;
            case PADatePickerViewTypeAll:
            [self selectRow:day-1 inComponent:0 animated:animated];
            [self selectRow:month-1 inComponent:1 animated:animated];
            [self selectRow:_year - year inComponent:2 animated:animated];
            break;
    }
}

- (NSUInteger)getNumberOfDaysInPickerView:(UIPickerView *)pickerView {
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.date];
    
    NSInteger selectedRowInMonthComponent = pickerView.numberOfComponents>1?[pickerView selectedRowInComponent:1]:-1;
    NSUInteger month = selectedRowInMonthComponent+1;
    NSUInteger actualYear = [comps year];
    
    NSDateComponents *selectMothComps = [NSDateComponents new];
    selectMothComps.year = actualYear;
    selectMothComps.month = month;
    selectMothComps.day = 1;
    
    NSDateComponents *nextMothComps = [NSDateComponents new];
    nextMothComps.year = actualYear;
    nextMothComps.month = month+1;
    nextMothComps.day = 1;
    
    NSDate *thisMonthDate = [[NSCalendar currentCalendar] dateFromComponents:selectMothComps];
    NSDate *nextMonthDate = [[NSCalendar currentCalendar] dateFromComponents:nextMothComps];
    
    NSDateComponents *difference = [[NSCalendar currentCalendar]  components:NSCalendarUnitDay
                                                                    fromDate:thisMonthDate
                                                                      toDate:nextMonthDate
                                                                     options:0];
    
    return difference.day;
}

- (NSUInteger)getNumberOfYears {
    
    NSDateComponents *difference = [[NSCalendar currentCalendar]  components:NSCalendarUnitYear
                                                                    fromDate:self.minimumDate
                                                                      toDate:self.maximumDate
                                                                     options:0];
    return difference.year;
}

@end

