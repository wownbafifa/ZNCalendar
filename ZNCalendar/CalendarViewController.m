//
//  CalendarViewController.m
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

 

#import "CalendarViewController.h"
//UI
#import "CalendarMonthCollectionViewLayout.h"
#import "CalendarMonthHeaderView.h"
#import "CalendarDayCell.h"
#import "CalendarWeakView.h"
//MODEL
#import "CalendarDayModel.h"


@interface CalendarViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>{
     NSTimer* timer;//定时器
}

@property (nonatomic, strong) CalendarMonthCollectionViewLayout *viewLayout;

@end

@implementation CalendarViewController

static NSString *MonthHeader = @"MonthHeaderView";

static NSString *DayCell = @"DayCell";



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initData];
        [self initView];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}



- (void)initView{
    
    
    [self setTitle:@"选择日期"];
    
    self.viewLayout = [[CalendarMonthCollectionViewLayout alloc]init];
    
    CalendarWeakView *weakView = [[CalendarWeakView alloc]initWithFrame:CGRectMake(0, 10, [[UIScreen mainScreen] bounds].size.width, 27)];
    [self.view addSubview:weakView];
    
    //[layout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //设置横向还
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, 35, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:self.viewLayout]; //初始化网格视图大小
    
    [self.collectionView registerClass:[CalendarDayCell class] forCellWithReuseIdentifier:DayCell];//cell重用设置ID
    [self.collectionView registerClass:[CalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];

//    self.collectionView.bounces = NO;//将网格视图的下拉效果关闭
    
//    self.collectionView.bounces = YES;
    
//    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.delegate = self;//实现网格视图的delegate

    self.collectionView.dataSource = self;//实现网格视图的dataSource

    self.collectionView.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.collectionView];
}



-(void)initData{
    
    self.calendarMonth = [[NSMutableArray alloc]init];//每个月份的数组
}



#pragma mark - CollectionView代理方法

//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.calendarMonth.count;
}


//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:section];
    
    return monthArray.count;
}


//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];

    NSMutableArray *monthArray = [self.calendarMonth objectAtIndex:indexPath.section];
    
    CalendarDayModel *model = [monthArray objectAtIndex:indexPath.row];
    
    cell.model = model;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width/7, 31);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width, 42);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;

    if (kind == UICollectionElementKindSectionHeader){
        
        NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
        CalendarDayModel *model = [month_Array objectAtIndex:15];

        CalendarMonthHeaderView *monthHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthHeader.masterLabel.text = [NSString stringWithFormat:@"%d年 %d月",model.year,model.month];//@"日期";
        monthHeader.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8f];
        reusableview = monthHeader;
    }
    return reusableview;
    
}




//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section >= 1) {
        NSMutableArray *before = [self.calendarMonth objectAtIndex:indexPath.section-1];
        [before enumerateObjectsUsingBlock:^(CalendarDayModel *obj, NSUInteger idx, BOOL *stop) {
            if (obj.style != CellDayTypeEmpty) {
                obj.style = CellDayTypePast;
            }
        }];
    }
    
    NSMutableArray *month_Array = [self.calendarMonth objectAtIndex:indexPath.section];
    CalendarDayModel *model = [month_Array objectAtIndex:indexPath.row];
    
    if (model.style != CellDayTypeEmpty) {
            for (int i=0; i<indexPath.row; i++) {
                CalendarDayModel *day = month_Array[i];
                if (day.style != CellDayTypeEmpty) {
                    day.style = CellDayTypePast;
                }
        
            }
    }
    
    if (model.style == CellDayTypeFutur || model.style == CellDayTypeWeek ||model.style == CellDayTypeClick) {
       
        [self.Logic selectLogic:model];
        
        __weak typeof(self)wself = self;
        if (wself.calendarblock) {
            
            wself.calendarblock(model);//传递数组给上级
            
            timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:wself selector:@selector(onTimer) userInfo:nil repeats:YES];
            
            [wself.collectionView reloadData];
        }
        [self.collectionView reloadData];
    }
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.6 * NSEC_PER_SEC);
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        NSIndexPath *scrollIndex = [NSIndexPath indexPathForItem:indexPath.item inSection:indexPath.section];
//        [self.collectionView scrollToItemAtIndexPath:scrollIndex atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
//        
//    });
}

//返回这个UICollectionView是否可以被选择
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    return YES;
//}


//定时器方法
- (void)onTimer{
    
    [timer invalidate];//定时器无效
    
    timer = nil;
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
