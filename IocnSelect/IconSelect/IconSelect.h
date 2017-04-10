//
//  IconSelect.h
//  IocnSelect
//
//  Created by taojunlin on 15/12/30.
//  Copyright © 2015年 taojunlin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CustomBackView.h"

@interface IconSelect : UIView
//图片
@property (nonatomic,strong)UIImageView *bottomImageView;

//图片选区
@property (nonatomic,strong)UIImageView *selectImageView;


//蒙板
@property (nonatomic,strong)CustomBackView  *backView;

//传入的图片
@property (nonatomic,strong)UIImage *image;


//最小缩放比例
@property (nonatomic,assign)CGFloat minimumScale;

//最大缩放比例
@property (nonatomic,assign)CGFloat maxmumScale;

- (instancetype)initWithView:(UIView *)view image:(UIImage *)image width:(CGFloat)width;

/**获取选框的图片 */
- (UIImage *)selectImage;

//- (void)removeFromSuperview;
@end
