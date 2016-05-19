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
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 8.0f, mainWidth, 1)];
//    [label setBackgroundColor:GCViewColor_8];
//    [self addSubview:label];
    
    //月份

    UILabel *masterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 15.0f, mainWidth, 20.f)];
    [masterLabel setBackgroundColor:[UIColor clearColor]];
    [masterLabel setTextAlignment:NSTextAlignmentCenter];
    [masterLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:17.0f]];
    self.masterLabel = masterLabel;
    self.masterLabel.textColor = [UIColor blackColor];
    [self addSubview:self.masterLabel];

    
}




@end
