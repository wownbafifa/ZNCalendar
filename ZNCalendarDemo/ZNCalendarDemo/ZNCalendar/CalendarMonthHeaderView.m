//
//  CalendarMonthHeaderView.m
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//


#import "CalendarMonthHeaderView.h"
#import "Color.h"

@interface CalendarMonthHeaderView ()

@end


@implementation CalendarMonthHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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
    
    self.clipsToBounds = YES;
    CGFloat mainWidth = [[UIScreen mainScreen]bounds].size.width;
    
    //月份
    UILabel *masterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 10.0f, mainWidth, 30.f)];
    [masterLabel setBackgroundColor:[UIColor clearColor]];
    [masterLabel setTextAlignment:NSTextAlignmentCenter];
    [masterLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
    self.masterLabel = masterLabel;
    self.masterLabel.textColor = COLOR_THEME;
    [self addSubview:self.masterLabel];

    
}




@end
