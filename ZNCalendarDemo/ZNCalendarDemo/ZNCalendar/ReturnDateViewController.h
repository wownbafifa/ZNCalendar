//
//  ReturnDateViewController.h
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^travelData)(NSDictionary *);

typedef NS_OPTIONS(NSUInteger, DateButtonType) {
    DateButtonTypeFirst = 1,//去程或入住button
    DateButtonTypeEnd = 2 //返程或离店button
};

/**
 *  往返日历控制器
 */
@interface ReturnDateViewController : UIViewController

@property (nonatomic,copy) travelData travelDataBlock;

@property (nonatomic,assign) BOOL isFirstDateSelected;


- (instancetype)initWithFirstBtnStr:(NSString *)firstBtnStr andSecondBtnStr:(NSString *)secondBtnStr andButtonDate:(NSDate *)btnDate;
@end
