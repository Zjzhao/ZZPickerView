//
//  ViewController.m
//  PickerViewDemo
//
//  Created by 赵张杰 on 2017/9/23.
//  Copyright © 2017年 赵张杰. All rights reserved.
//

#import "ViewController.h"
#import "ZZPickerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ZZPickerView *pickerView = [[ZZPickerView alloc] initWithFrame:CGRectMake(0, 0, 200, 213)];
    [pickerView selectWithRow:2];
    [self.view addSubview:pickerView];
    pickerView.center = self.view.center;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
