//
//  CalendarMonthCollectionViewLayout.m
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

 

#import "CalendarMonthCollectionViewLayout.h"

@interface CalendarMonthCollectionViewLayout ()
@end

@implementation CalendarMonthCollectionViewLayout

- (id)init {
    self = [super init];
    if (self) {
        
        CGFloat mainWidth = [[UIScreen mainScreen]bounds].size.width;
        CGFloat dayLabelHeight = 80.0;
        CGFloat dayLabelWidth = mainWidth/7;

        
        self.headerReferenceSize = CGSizeMake(mainWidth, 33.0f);//头部视图的框架大小
        self.itemSize = CGSizeMake(dayLabelWidth, dayLabelHeight);//每个cell的大小
        self.minimumLineSpacing = 0.0f;//每行的最小间距
        self.minimumInteritemSpacing = 0.0f;//每列的最小间距
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//网格视图的/上/左/下/右,的边距
    }
    return self;
}


- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBound {
    
    return YES;
    
}


@end
