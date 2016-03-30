//
//  UIScrollView+UITouch.m
//  ZNCanlendar
//
//  Created by 张楠 on 16/3/29.
//  Copyright © 2016年 zn. All rights reserved.
//

#import "UIScrollView+UITouch.h"

@implementation UIScrollView (UITouch)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //if(!self.dragging)
    {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    [super touchesBegan:touches withEvent:event];
}
//-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //if(!self.dragging)
//    {
//        [[self nextResponder] touchesMoved:touches withEvent:event];
//    }
//    [super touchesMoved:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    //if(!self.dragging)
//    {
//        [[self nextResponder] touchesEnded:touches withEvent:event];
//    }
//    [super touchesEnded:touches withEvent:event];
//}
@end
