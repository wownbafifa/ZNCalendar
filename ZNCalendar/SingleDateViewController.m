//
//  SingleDateViewController.m
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

#import "SingleDateViewController.h"
#import "CalendarHomeViewController.h"
#import "CalendarDayModel.h"
@interface SingleDateViewController ()
@property (nonatomic,strong) CalendarHomeViewController *chvc;
@property (nonatomic,strong) CalendarDayModel *model;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@end

@implementation SingleDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_chvc) {
        _chvc = [[CalendarHomeViewController alloc]init];
        [_chvc setAirPlaneToDay:365 ToDateforString:nil];//飞机初始化方法
    }
    [self.view addSubview:_chvc.view];
    __weak typeof(self) weakself = self;
    //点击选择日期后的回调
    _chvc.calendarblock = ^(CalendarDayModel *model){
        weakself.model = model;
        [weakself.dataDic setObject:model.date forKey:@"dateResult"];
        weakself.travelDataBlock(weakself.dataDic);
        [weakself.navigationController popViewControllerAnimated:YES];
        
    };
}


-(NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
        [_dataDic setObject:[NSDate date] forKey:@"dateResult"];
    }
    return _dataDic;
}

@end
