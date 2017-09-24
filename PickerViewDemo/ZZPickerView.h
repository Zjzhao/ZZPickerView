//
//  ZZPickerView.h
//  PickerViewDemo
//
//  Created by 赵张杰 on 2017/9/23.
//  Copyright © 2017年 赵张杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZPickerView : UIView

//点击方法
- (void)selectWithValueBlock:(void(^)())block;
//默认选中行
- (void)selectWithRow:(NSInteger)row;

@end
