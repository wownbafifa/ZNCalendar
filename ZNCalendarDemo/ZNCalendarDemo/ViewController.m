//
//  ViewController.m
//  ZNCalendarDemo
//
//  Created by 张楠 on 16/3/30.
//  Copyright © 2016年 张楠. All rights reserved.
//

#import "ViewController.h"
#import "ReturnDateViewController.h"
#import "SingleDateViewController.h"
@interface ViewController ()
@property (nonatomic,strong) ReturnDateViewController *vc;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *endBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkInBtn;
@property (weak, nonatomic) IBOutlet UIButton *checkOutBtn;
@property (weak, nonatomic) IBOutlet UIButton *singleBtn;

@property (nonatomic,strong) NSMutableDictionary *planeDataDic;
@property (nonatomic,strong) NSMutableDictionary *hotelDataDic;


@end

@implementation ViewController


-(NSMutableDictionary *)planeDataDic{
    if (!_planeDataDic) {
        _planeDataDic = [NSMutableDictionary dictionary];
        [_planeDataDic setObject:[NSDate date] forKey:@"firstDate"];
        [_planeDataDic setObject:[NSDate date] forKey:@"endDate"];
    }
    return _planeDataDic;
}
-(NSMutableDictionary *)hotelDataDic{
    if (!_hotelDataDic) {
        _hotelDataDic = [NSMutableDictionary dictionary];
        [_hotelDataDic setObject:[NSDate date] forKey:@"firstDate"];
        [_hotelDataDic setObject:[NSDate date] forKey:@"endDate"];
    }
    return _hotelDataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/**
 *  单程机票日历
 *
 *  @param sender button
 */
- (IBAction)didClickSingleBtn:(id)sender {
    SingleDateViewController *vc = [[SingleDateViewController alloc]init];
    [vc setTitle:@"出发日期"];
    __weak typeof(self) weakself = self;
    //选完日期后的回调
    vc.travelDataBlock = ^(NSDictionary *dic){
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.dateFormat = @"yyyy-MM-dd";
        NSString *firstDateStr = [dateFormat stringFromDate:[dic objectForKey:@"dateResult"]];
        [weakself.singleBtn setTitle:firstDateStr forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}



/**
 *  往返机票
    去程日期按钮点击事件
 *
 *  @param sender button
 */
- (IBAction)didClickTripBtn:(id)sender {
    ReturnDateViewController * vc =[[ReturnDateViewController alloc]initWithFirstBtnStr:@"去程日期" andSecondBtnStr:@"返程日期" andButtonDate:nil];
    [vc setTitle:@"选择日期"];
    __weak typeof(self) weakself = self;
    
    //选完日期后的回调
    vc.travelDataBlock = ^(NSDictionary *dic){
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.dateFormat = @"yyyy-MM-dd";
        [weakself.planeDataDic setObject:[dic objectForKey:@"firstDate"] forKey:@"firstDate"];
        [weakself.planeDataDic setObject:[dic objectForKey:@"endDate"] forKey:@"endDate"];
        NSString *firstDateStr = [dateFormat stringFromDate:[dic objectForKey:@"firstDate"]];
        NSString *endDateStr = [dateFormat stringFromDate:[dic objectForKey:@"endDate"]];
        [weakself.firstBtn setTitle:firstDateStr forState:UIControlStateNormal];
        [weakself.endBtn setTitle:endDateStr forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  往返机票
    返程日期按钮点击事件
 *
 *  @param sender button
 */
- (IBAction)didClickReturnBtn:(id)sender {
    ReturnDateViewController * vc =[[ReturnDateViewController alloc]initWithFirstBtnStr:@"去程日期" andSecondBtnStr:@"返程日期" andButtonDate:[self.planeDataDic objectForKey:@"firstDate"]];
    [vc setTitle:@"选择日期"];
    __weak typeof(self) weakself = self;
    
    //选完日期后的回调
    vc.travelDataBlock = ^(NSDictionary *dic){
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.dateFormat = @"yyyy-MM-dd";
        [weakself.planeDataDic setObject:[dic objectForKey:@"firstDate"] forKey:@"firstDate"];
        [weakself.planeDataDic setObject:[dic objectForKey:@"endDate"] forKey:@"endDate"];
        NSString *firstDateStr = [dateFormat stringFromDate:[dic objectForKey:@"firstDate"]];
        NSString *endDateStr = [dateFormat stringFromDate:[dic objectForKey:@"endDate"]];
        [weakself.firstBtn setTitle:firstDateStr forState:UIControlStateNormal];
        [weakself.endBtn setTitle:endDateStr forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}



/**
 *  酒店预订
    入住日期按钮点击事件
 *
 *  @param sender button
 */
- (IBAction)didClickCheckInBtn:(id)sender {
    ReturnDateViewController * vc =[[ReturnDateViewController alloc]initWithFirstBtnStr:@"入住日期" andSecondBtnStr:@"离店日期" andButtonDate:nil];
    [vc setTitle:@"选择日期"];
    __weak typeof(self) weakself = self;
    
    //选完日期后的回调
    vc.travelDataBlock = ^(NSDictionary *dic){
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.dateFormat = @"yyyy-MM-dd";
        [weakself.hotelDataDic setObject:[dic objectForKey:@"firstDate"] forKey:@"firstDate"];
        [weakself.hotelDataDic setObject:[dic objectForKey:@"endDate"] forKey:@"endDate"];
        NSString *firstDateStr = [dateFormat stringFromDate:[dic objectForKey:@"firstDate"]];
        NSString *endDateStr = [dateFormat stringFromDate:[dic objectForKey:@"endDate"]];
        [weakself.checkInBtn setTitle:firstDateStr forState:UIControlStateNormal];
        [weakself.checkOutBtn setTitle:endDateStr forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  酒店预订
    离店日期按钮点击事件
 *
 *  @param sender button
 */
- (IBAction)didClickCheckOutBtn:(id)sender {
    ReturnDateViewController * vc =[[ReturnDateViewController alloc]initWithFirstBtnStr:@"入住日期" andSecondBtnStr:@"离店日期" andButtonDate:[self.hotelDataDic objectForKey:@"firstDate"]];
    [vc setTitle:@"选择日期"];
    __weak typeof(self) weakself = self;
    
    //选完日期后的回调
    vc.travelDataBlock = ^(NSDictionary *dic){
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.dateFormat = @"yyyy-MM-dd";
        [weakself.hotelDataDic setObject:[dic objectForKey:@"firstDate"] forKey:@"firstDate"];
        [weakself.hotelDataDic setObject:[dic objectForKey:@"endDate"] forKey:@"endDate"];
        NSString *firstDateStr = [dateFormat stringFromDate:[dic objectForKey:@"firstDate"]];
        NSString *endDateStr = [dateFormat stringFromDate:[dic objectForKey:@"endDate"]];
        [weakself.checkInBtn setTitle:firstDateStr forState:UIControlStateNormal];
        [weakself.checkOutBtn setTitle:endDateStr forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
}


@end
