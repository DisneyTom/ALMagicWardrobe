

#import <UIKit/UIKit.h>
@protocol CalendarDelegate <NSObject>
-(void)tappedOnDate:(NSDate *)selectedDate;
-(void)change;
@end

@interface CalendarView : UIView
{
    NSInteger _selectedDate;
    NSArray *_weekNames;
}

@property (nonatomic,strong) NSDate *calendarDate;
@property (nonatomic,strong) UILabel *titleText;
@property (nonatomic,weak) id<CalendarDelegate> delegate;
@property(nonatomic,strong) NSArray *listDate;
@end
