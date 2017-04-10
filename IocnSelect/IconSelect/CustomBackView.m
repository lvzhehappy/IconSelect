//
//  CustomBackView.m
//  IocnSelect
//
//  Created by taojunlin on 15/12/30.
//  Copyright © 2015年 taojunlin. All rights reserved.
//

#import "CustomBackView.h"

@implementation CustomBackView

- (instancetype)initWithBottomView:(UIView *)bottomView superView:(UIView *)superView
{
    if(self = [super init]){
        self.frame = superView.bounds;
        _x = bottomView.center.x;
        _y = bottomView.center.y;
        _r = bottomView.frame.size.width;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *ovalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(_x-_r/2, _y-_r/2, _r, _r)];
    [ovalPath closePath];
    UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:rect];
    [rectPath appendPath:ovalPath];
    rectPath.usesEvenOddFillRule = YES;
    
    UIColor *color = [UIColor colorWithRed:0.321 green:0.321 blue:0.321 alpha:0.5];
    [color setFill];
    [rectPath fill];
}


@end
