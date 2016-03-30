//
//  CalendarDayCell.h
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarDayModel.h"
#import "Color.h"

@interface CalendarDayCell : UICollectionViewCell
{
    UILabel *day_lab;//今天的日期或者是节日
    UILabel *day_title;//显示标签
    UILabel *imgview;//选中时的图片
}

@property(nonatomic , strong)CalendarDayModel *model;

@end
