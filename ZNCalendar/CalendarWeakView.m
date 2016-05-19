//
//  CalendarWeakView.m
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

#import "CalendarWeakView.h"
#import "Color.h"
@interface CalendarWeakView()
@property (weak, nonatomic) UILabel *day1OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day2OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day3OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day4OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day5OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day6OfTheWeekLabel;
@property (weak, nonatomic) UILabel *day7OfTheWeekLabel;
@property (strong,nonatomic) UIView *backView;
@end

@implementation CalendarWeakView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, gcWidth, 30)];
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self.backView setBackgroundColor:kColor(1, 159, 240)];
    self.backView.alpha = 0.2;
    [self addSubview:_backView];
    self.clipsToBounds = YES;
    CGFloat mainWidth = [[UIScreen mainScreen]bounds].size.width;
    CGFloat dayLabelHeight = 25.0f;
    CGFloat dayLabelWidth = mainWidth/7;
    
    //一，二，三，四，五，六，日
    CGFloat xOffset = 0.0f;
    CGFloat yOffset = 0.0f;
    UILabel *dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, dayLabelWidth, dayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    self.day1OfTheWeekLabel = dayOfTheWeekLabel;
    self.day1OfTheWeekLabel.textAlignment = NSTextAlignmentCenter;
    self.day1OfTheWeekLabel.textColor = COLOR_THEME1;
    [self addSubview:self.day1OfTheWeekLabel];
    
    xOffset += dayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, dayLabelWidth, dayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    self.day2OfTheWeekLabel = dayOfTheWeekLabel;
    self.day2OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day2OfTheWeekLabel.textColor = [UIColor blackColor];
    [self addSubview:self.day2OfTheWeekLabel];
    
    xOffset += dayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, dayLabelWidth, dayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    self.day3OfTheWeekLabel = dayOfTheWeekLabel;
    self.day3OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day3OfTheWeekLabel.textColor = [UIColor blackColor];
    [self addSubview:self.day3OfTheWeekLabel];
    
    xOffset += dayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, dayLabelWidth, dayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    self.day4OfTheWeekLabel = dayOfTheWeekLabel;
    self.day4OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day4OfTheWeekLabel.textColor = [UIColor blackColor];
    [self addSubview:self.day4OfTheWeekLabel];
    
    xOffset += dayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, dayLabelWidth, dayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    self.day5OfTheWeekLabel = dayOfTheWeekLabel;
    self.day5OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day5OfTheWeekLabel.textColor = [UIColor blackColor];
    [self addSubview:self.day5OfTheWeekLabel];
    
    xOffset += dayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, dayLabelWidth, dayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    self.day6OfTheWeekLabel = dayOfTheWeekLabel;
    self.day6OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day6OfTheWeekLabel.textColor = [UIColor blackColor];
    [self addSubview:self.day6OfTheWeekLabel];
    
    xOffset += dayLabelWidth;
    dayOfTheWeekLabel = [[UILabel alloc]initWithFrame:CGRectMake(xOffset,yOffset, dayLabelWidth, dayLabelHeight)];
    [dayOfTheWeekLabel setBackgroundColor:[UIColor clearColor]];
    [dayOfTheWeekLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    self.day7OfTheWeekLabel = dayOfTheWeekLabel;
    self.day7OfTheWeekLabel.textAlignment=NSTextAlignmentCenter;
    self.day7OfTheWeekLabel.textColor = COLOR_THEME1;
    [self addSubview:self.day7OfTheWeekLabel];
    
    [self updateWithDayNames:@[@"日", @"一", @"二", @"三", @"四", @"五", @"六"]];
    
}


//设置 @"日", @"一", @"二", @"三", @"四", @"五", @"六"
- (void)updateWithDayNames:(NSArray *)dayNames{
    for (int i = 0 ; i < dayNames.count; i++) {
        switch (i) {
            case 0:
                self.day1OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 1:
                self.day2OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 2:
                self.day3OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 3:
                self.day4OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 4:
                self.day5OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 5:
                self.day6OfTheWeekLabel.text = dayNames[i];
                break;
                
            case 6:
                self.day7OfTheWeekLabel.text = dayNames[i];
                break;
                
            default:
                break;
        }
    }

}
@end
