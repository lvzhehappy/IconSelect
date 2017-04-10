//
//  IconSelect.m
//  IocnSelect
//
//  Created by taojunlin on 15/12/30.
//  Copyright © 2015年 taojunlin. All rights reserved.
//

#import "IconSelect.h"

@interface IconSelect ()
{
    CGFloat _width;
    BOOL _isBeyond;
    CGPoint _lastCenter;
    CGFloat _lastWidth;
    CGFloat _lastScale;
}
@end

@implementation IconSelect

- (instancetype)initWithView:(UIView *)view image:(UIImage *)image width:(CGFloat)width
{
    if(self = [super init]){
        self.frame = view.bounds;
        _width = width;
        _image = image;
        
        //缩放比例默认值
        _minimumScale = 1;
        _maxmumScale = 3;
        
        [self imageViewConfig];
        [self resetImage];
        [self backViewConfig];
        [self selectImageViewConfig];
    }
    return self;
}


#pragma mark 重置图像 按照imageView的大小来指定比例
- (void)resetImage
{
    CGSize newSize = _bottomImageView.frame.size;
    UIGraphicsBeginImageContext(newSize);
    [_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    _bottomImageView.image = newImage;
}


#pragma mark imageView设置
- (void)imageViewConfig
{
    self.bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _width, _width)];
    [self addSubview:_bottomImageView];
    _bottomImageView.center = self.center;
    _bottomImageView.userInteractionEnabled = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [_bottomImageView addGestureRecognizer:pan];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(scale:)];
    [_bottomImageView addGestureRecognizer:pinch];
    
     _lastWidth = _bottomImageView.frame.size.width;
}


- (void)panAction:(UIPanGestureRecognizer *)pan
{
    if(pan.state ==UIGestureRecognizerStateEnded){
        if(_isBeyond || !CGRectContainsRect(_bottomImageView.frame, _selectImageView.frame)){
            [UIView animateWithDuration:0.3 animations:^{
                _bottomImageView.center = _lastCenter;
            }];
        }
    }
    CGPoint center = _selectImageView.center;
    CGPoint point = [pan translationInView:_bottomImageView];
    if(CGRectContainsPoint(_bottomImageView.frame, center)){
        pan.view.center = CGPointMake(pan.view.center.x + point.x, _bottomImageView.center.y + point.y);
        _isBeyond =NO;
        if(CGRectContainsRect(_bottomImageView.frame, _selectImageView.frame)){
            _lastCenter = pan.view.center;
        }
    }else{
        _isBeyond = YES;
    }
    [pan setTranslation:CGPointMake(0, 0) inView:_bottomImageView];
    NSLog(@"%@",NSStringFromCGRect(_bottomImageView.frame));
}

- (void)scale:(UIPinchGestureRecognizer *)pinch
{
//    if(pinch.scale < _minimumScale){
//        pinch.scale = _minimumScale;
//    }
//    if(pinch.scale > _maxmumScale){
//        pinch.scale = _maxmumScale;
//    }
//    _bottomImageView.transform = CGAffineTransformMakeScale(pinch.scale, pinch.scale);
//    [self resetImage];
//    if(pinch.state == UIGestureRecognizerStateEnded){
//        if(!CGRectContainsRect(_bottomImageView.frame, _selectImageView.frame)){
//            [UIView animateWithDuration:0.2 animations:^{
//                _bottomImageView.center = _selectImageView.center;
//                _lastCenter = _selectImageView.center;
//            }];
//        }
//    }
    
    if(pinch.state == UIGestureRecognizerStateBegan){
        _lastScale = 1.0;
    }
    CGFloat scale = 1.0 -(_lastScale - pinch.scale);
    
    CGFloat currentWidth = _bottomImageView.frame.size.width * scale;
    if(currentWidth / _lastWidth < 1){
        ;
    }else if(currentWidth / _lastWidth >3){
        ;
    }else{
        _bottomImageView.transform = CGAffineTransformScale(_bottomImageView.transform, scale, scale);
    }
    _lastScale = pinch.scale;
    
    [self resetImage];
    if(pinch.state == UIGestureRecognizerStateEnded){
        if(!CGRectContainsRect(_bottomImageView.frame, _selectImageView.frame)){
            [UIView animateWithDuration:0.2 animations:^{
                _bottomImageView.center = _selectImageView.center;
                _lastCenter = _selectImageView.center;
            }];
        }
    }
    
}
#pragma mark 蒙板设置
- (void)backViewConfig
{
    _backView = [[CustomBackView alloc] initWithBottomView:_bottomImageView superView:self];
    _backView.backgroundColor = [UIColor clearColor];
    _backView.userInteractionEnabled = NO;
    [self addSubview:_backView];
}

#pragma mark 选区设置
- (void)selectImageViewConfig
{
    _selectImageView = [[UIImageView alloc] initWithFrame:_bottomImageView.frame];
    _selectImageView.layer.cornerRadius = _width/2;
    _selectImageView.layer.masksToBounds = YES;
    _selectImageView.layer.borderWidth = 0.5;
    _selectImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self addSubview:_selectImageView];
    [self bringSubviewToFront:_selectImageView];
    _lastCenter = _selectImageView.center;
}

//获取选框的图片
- (UIImage *)selectImage
{
    CGFloat x = _bottomImageView.frame.origin.x;
    CGFloat y = _bottomImageView.frame.origin.y;
    CGFloat targetx = _selectImageView.frame.origin.x;
    CGFloat targety = _selectImageView.frame.origin.y;
    CGFloat width = _selectImageView.frame.size.width;
    CGRect rect = CGRectMake(targetx-x, targety-y, width, width);
    NSLog(@"%@",NSStringFromCGRect(rect));
    UIImage *newImage = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([_bottomImageView.image CGImage], rect)];
    return newImage;
}


- (void)removeFromSuperview
{
    _bottomImageView.transform = CGAffineTransformIdentity;
    _bottomImageView.center = _selectImageView.center;
    _lastCenter = _selectImageView.center;
}

@end
