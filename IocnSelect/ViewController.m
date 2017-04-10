//
//  ViewController.m
//  IocnSelect
//
//  Created by taojunlin on 15/12/30.
//  Copyright © 2015年 taojunlin. All rights reserved.
//

#import "ViewController.h"

#import "IconSelect.h"

@interface ViewController ()
{
    IconSelect *_select;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _select = [[IconSelect alloc] initWithView:self.view image:[UIImage imageNamed:@"0.jpg"] width:200];
    [self.view addSubview:_select];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectImage:(id)sender {
    
    _select.selectImageView.image = [_select selectImage];
}

@end
