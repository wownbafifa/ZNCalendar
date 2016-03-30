//
//  ReturnDateViewController.m
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

#import "ReturnDateViewController.h"
#import "CalendarHomeViewController.h"
#import "CalendarDayModel.h"
#define gcWidth [[UIScreen mainScreen] bounds].size.width
#define gcHeight [[UIScreen mainScreen] bounds].size.height

@interface ReturnDateViewController ()<UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *firstDateBtn;
@property (weak, nonatomic) IBOutlet UIButton *endDateBtn;
@property (nonatomic,copy) NSString *firstBtnStr;
@property (nonatomic,copy) NSString *secondBtnStr;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic,strong) CalendarHomeViewController *chvc;
@property (nonatomic,assign) CGPoint point;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraints;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@property (nonatomic,strong) CalendarDayModel *model;
@end

@implementation ReturnDateViewController
/**
 *  实例化方法
 *
 *  @param firstBtnStr  第一个按钮上面的文字，去程日期或者入住日期
 *  @param secondBtnStr 第二个按钮上面的问题，返程日期或者离店日期
 *
 *  @return ReturnDateViewController
 */
- (instancetype)initWithFirstBtnStr:(NSString *)firstBtnStr andSecondBtnStr:(NSString *)secondBtnStr andButtonDate:(NSDate *)btnDate{
    if (self = [super init]) {
        self.firstBtnStr = firstBtnStr;
        self.secondBtnStr = secondBtnStr;
        self.isFirstDateSelected = true;
        if (btnDate != nil) {
            [self.dataDic setObject:btnDate forKey:@"firstDate"];
            self.isFirstDateSelected = false;
        }
    }
    return self;
}

-(NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
        [_dataDic setObject:[NSDate date] forKey:@"firstDate"];
        [_dataDic setObject:[NSDate date] forKey:@"endDate"];
    }
    return _dataDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [dateFormat stringFromDate:[self.dataDic objectForKey:@"firstDate"]];
    [self.firstDateBtn setTitle:self.firstBtnStr forState:UIControlStateNormal];
    [self.endDateBtn setTitle:self.secondBtnStr forState:UIControlStateNormal];
    self.point = CGPointMake(0, 0);
    if (!_chvc) {
        _chvc = [[CalendarHomeViewController alloc]init];
        if (self.isFirstDateSelected) {
            [_chvc setAirPlaneToDay:365 ToDateforString:nil];
        }else{
            [_chvc setAirPlaneToDay:365 ToDateforString:dateStr];
        }
    }
    UIView *calendarView = [[UIView alloc]initWithFrame:CGRectMake(0, 100,gcWidth , gcHeight)];
    [calendarView addSubview:_chvc.view];
    [self.view addSubview:calendarView];
    if (self.isFirstDateSelected == false) {
        [self didAnimationWithSelect:dateStr andIsFirstBtnSelected:false andAnimation:false];
    }
    
    __weak typeof(self) weakself = self;
    //点击选择日期后的回调
   _chvc.calendarblock = ^(CalendarDayModel *model){
       weakself.model = model;
       NSString *dateString = [NSString stringWithFormat:@"%@ %@",[model toString],[model getWeek]];
       if (weakself.isFirstDateSelected == true) {
           [weakself.dataDic setObject:model.date forKey:@"firstDate"];
           
            [weakself didAnimationWithSelect:dateString andIsFirstBtnSelected:weakself.isFirstDateSelected andAnimation:true];
       }
       else {
           [weakself.dataDic setObject:model.date forKey:@"endDate"];
           weakself.travelDataBlock(weakself.dataDic);
           
           [weakself didAnimationWithSelect:dateString andIsFirstBtnSelected:weakself.isFirstDateSelected andAnimation:true];
       }
   };
    
}

/**
 *  去程或入住日期按钮点击事件
 *
 *  @param sender button
 */
- (IBAction)didClickFirstDateBtn:(id)sender {
    if (self.isFirstDateSelected == true) {
        return;
    }
    self.isFirstDateSelected = true;
    [self updateBottomView:self.isFirstDateSelected andWithAnimation:YES];
    [self.chvc setAirPlaneToDay:365 ToDateforString:nil];
    NSAttributedString *attrStr0 = [[NSAttributedString alloc] initWithString: [self.firstBtnStr substringWithRange: NSMakeRange(0, self.firstBtnStr.length)] attributes:  @{}];
    [self.firstDateBtn setAttributedTitle:attrStr0 forState:UIControlStateNormal];
}


/**
 *  返程或离店日期按钮点击事件
 *
 *  @param sender button
 */
- (IBAction)didClickEndDateBtn:(id)sender {
    if (self.isFirstDateSelected == false) {
        return;
    }
    self.isFirstDateSelected = false;
    [self updateBottomView:self.isFirstDateSelected andWithAnimation:YES];
    NSAttributedString *attrStr0 = [[NSAttributedString alloc] initWithString: [self.secondBtnStr substringWithRange: NSMakeRange(0, self.secondBtnStr.length)] attributes:  @{}];
    [self.endDateBtn setAttributedTitle:attrStr0 forState:UIControlStateNormal];
    
}


/**
 *  点击按钮或选择日期后更新底部蓝色view的位置
 *
 *  @param isFirstDate   FirstDateBtn是否被选中
 *  @param withAnimation 是否需要开启动画
 */
- (void)updateBottomView:(BOOL)isFirstDate andWithAnimation:(BOOL)withAnimation{
    if (withAnimation) {
        if (!isFirstDate) {
            [UIView animateWithDuration:0.3 animations:^{
                self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, gcWidth/2, 0);
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, -gcWidth/2, 0);
            }];
        }
    }else{
        if (!isFirstDate) {
                self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, gcWidth/2, 0);
        }else{
                self.bottomView.transform = CGAffineTransformTranslate(self.bottomView.transform, -gcWidth/2, 0);
        }
    }
    [self viewDidLayoutSubviews];
}


/**
 *   选中日期后的动画
 *
 *  @param dateStr             选中日期的字符串
 *  @param isFirstDateSelected FirstDateBtn是否被选中
 */
- (void)didAnimationWithSelect:(NSString *)dateStr andIsFirstBtnSelected:(BOOL)isFirstDateSelected andAnimation:(BOOL)isAnimation{
    if (isAnimation) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.point.x, self.point.y, 90, 20)];
        label.text = dateStr;
        label.font = [UIFont systemFontOfSize:10];
        [self.view addSubview:label];
        
        if (isFirstDateSelected) {
            [UIView animateWithDuration:0.5 animations:^{
                label.frame = CGRectMake(CGRectGetMidX(self.firstDateBtn.frame)-30, CGRectGetMaxY(self.firstDateBtn.frame), 90, 20);
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
                [self changeFirstDateBtn:dateStr];
                [self updateBottomView:self.isFirstDateSelected andWithAnimation:YES];
            }];
        }else{
            [UIView animateWithDuration:0.5 animations:^{
                label.frame = CGRectMake(CGRectGetMidX(self.endDateBtn.frame)-30, CGRectGetMaxY(self.endDateBtn.frame), 90, 20);
            } completion:^(BOOL finished) {
                [label removeFromSuperview];
                [self changeEndDateBtn:dateStr];
                [self updateBottomView:self.isFirstDateSelected andWithAnimation:NO];
                [self.navigationController popViewControllerAnimated:YES];
                [self removeFromParentViewController];
            }];
        }
    }else{
        [self changeFirstDateBtn:dateStr];
        [self updateBottomView:self.isFirstDateSelected andWithAnimation:YES];
    }
    
    
}


/**
 *  选择日期后修改去程日期按钮的label。
 *
 *  @param firstDateStr 选中的日期
 */
- (void)changeFirstDateBtn:(NSString *)firstDateStr{
    self.isFirstDateSelected = false;
    self.firstDateBtn.titleLabel.numberOfLines = 2;
    self.firstDateBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    NSMutableAttributedString *attributedStr = [self getAppendAttributedString:[NSString stringWithFormat:@"%@\n",self.firstBtnStr] andDateString:firstDateStr];
    [self.firstDateBtn setAttributedTitle:attributedStr forState:UIControlStateNormal];

}

/**
 *   选择日期后修改返程日期按钮的label。
 *
 *  @param firstDateStr 选中的日期
 */
- (void)changeEndDateBtn:(NSString *)firstDateStr{
    self.isFirstDateSelected = true;
    self.endDateBtn.titleLabel.numberOfLines = 2;
    self.endDateBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    NSMutableAttributedString *attributedStr = [self getAppendAttributedString:[NSString stringWithFormat:@"%@\n",self.firstBtnStr] andDateString:firstDateStr];
    [self.endDateBtn setAttributedTitle:attributedStr forState:UIControlStateNormal];
}


/**
 *  添加富文本样式
 *
 *  @param dateType 按钮文本
 *  @param dateStr  选中的日期
 *
 *  @return NSAttributedString
 */
- (NSMutableAttributedString *)getAppendAttributedString:(NSString *)dateType andDateString:(NSString *)dateStr{
    NSString *t0 = dateType;
    NSString *t1 = dateStr;
    NSMutableParagraphStyle *paragraph=[[NSMutableParagraphStyle alloc]init];
    paragraph.alignment=NSTextAlignmentCenter;
    NSDictionary *attrTitleDict0 = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:11],NSParagraphStyleAttributeName:paragraph};
    NSDictionary *attrTitleDict1 = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:13],NSForegroundColorAttributeName: [UIColor blackColor],NSParagraphStyleAttributeName:paragraph};
    NSAttributedString *attrStr0 = [[NSAttributedString alloc] initWithString: [t0 substringWithRange: NSMakeRange(0, t0.length)] attributes: attrTitleDict0];
    NSAttributedString *attrStr1 = [[NSAttributedString alloc] initWithString: [t1 substringWithRange: NSMakeRange(0, t1.length)] attributes: attrTitleDict1];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithAttributedString: attrStr0];
    [attributedStr appendAttributedString:attrStr1];
    return attributedStr;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    CGPoint touchLocation = [touch locationInView:self.view];
    self.point = CGPointMake(touchLocation.x, touchLocation.y);

}


@end
