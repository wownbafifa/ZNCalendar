//
//  ReturnDateViewController.h
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^travelData)(NSDictionary *);

/**
 *  往返日历控制器
 */
@interface ReturnDateViewController : UIViewController

@property (nonatomic,copy) travelData travelDataBlock;

@property (nonatomic,assign) BOOL isFirstDateSelected;


- (instancetype)initWithFirstBtnStr:(NSString *)firstBtnStr andSecondBtnStr:(NSString *)secondBtnStr;
@end
