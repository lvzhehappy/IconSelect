//
//  CustomBackView.h
//  IocnSelect
//
//  Created by taojunlin on 15/12/30.
//  Copyright © 2015年 taojunlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomBackView : UIView
//原点
@property (nonatomic,assign)CGFloat x;


@property (nonatomic,assign)CGFloat y;

//半径
@property (nonatomic,assign)CGFloat r;

- (instancetype)initWithBottomView:(UIView *)bottomView superView:(UIView *)superView;
@end
