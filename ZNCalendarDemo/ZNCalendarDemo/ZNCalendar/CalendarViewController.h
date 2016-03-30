//
//  CalendarViewController.h
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

 

#import <UIKit/UIKit.h>
#import "CalendarLogic.h"


//回掉代码块
typedef void (^CalendarBlock)(CalendarDayModel *model);

@interface CalendarViewController : UIViewController

@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组

@property(nonatomic ,strong) CalendarLogic *Logic;

@property (nonatomic, copy) CalendarBlock calendarblock;//回调

- (void)initView;

@end
