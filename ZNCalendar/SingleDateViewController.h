//
//  SingleDateViewController.h
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^travelData)(NSDictionary *);
/**
 *  单程日历控制器
 */
@interface SingleDateViewController : UIViewController
@property (nonatomic,copy) travelData travelDataBlock;
@end
