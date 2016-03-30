//
//  CalendarLogic.h
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

 

#import <Foundation/Foundation.h>
#import "CalendarDayModel.h"
#import "NSDate+WQCalendarLogic.h"

@interface CalendarLogic : NSObject

- (NSMutableArray *)reloadCalendarView:(NSDate *)date  selectDate:(NSDate *)date1 needDays:(int)days_number;
- (void)selectLogic:(CalendarDayModel *)day;
@end
