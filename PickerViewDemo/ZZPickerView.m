//
//  ZZPickerView.m
//  PickerViewDemo
//
//  Created by 赵张杰 on 2017/9/23.
//  Copyright © 2017年 赵张杰. All rights reserved.
//

#import "ZZPickerView.h"

@interface PickerViewSelectView : UIView

@property (nonatomic, strong) UIButton *okButton;

@end

@implementation PickerViewSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:self.okButton];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIButton *)okButton {
    if (!_okButton) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okButton setBackgroundColor:[UIColor clearColor]];
        [_okButton setTitle:@"OK" forState:UIControlStateNormal];
        _okButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:24];
        [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _okButton;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect rect = self.bounds;
    CGRect frame = self.okButton.frame;
    frame.size = CGSizeMake(50, 33);
    frame.origin = CGPointMake(rect.size.width - 32 - 50, 0);
    self.okButton.frame = frame;
}


@end

typedef void(^ValueBlock)(NSString *);

@interface ZZPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource> {
    NSArray *_times;
    ValueBlock _valueBlock;
    NSString *_selectedText;
}

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) PickerViewSelectView *selectView;

@end

@implementation ZZPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initailControl];
    }
    return self;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:self.bounds];
        _pickerView.backgroundColor = [UIColor colorWithWhite:.0f alpha:.3f];
        _pickerView.showsSelectionIndicator = NO;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (PickerViewSelectView *)selectView {
    if (!_selectView) {
        _selectView = [[PickerViewSelectView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 33)];
        [_selectView.okButton addTarget:self action:@selector(selectTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectView;
}

- (void)selectTimeClick:(UIButton *)button {
    NSLog(@"---%@----",_selectedText);
    if (_valueBlock) {
        _valueBlock(_selectedText);
    }
}

- (void)selectWithRow:(NSInteger)row {
    if (_pickerView) {
        _selectedText = [_times objectAtIndex:row];
        [_pickerView selectRow:row inComponent:0 animated:NO];
    }
}

- (void)selectWithValueBlock:(void(^)())block {
    _valueBlock = block;
}

- (void)initailControl {
    _times = [NSArray arrayWithObjects:@"1天",
                                       @"3天",
                                       @"1周",
                                       @"2周",
                                       @"3周",
                                       @"1个月",nil];
    [self addSubview:self.pickerView];
    CGRect frame = self.selectView.frame;
    frame.origin.y = (self.bounds.size.height - frame.size.height) * 0.5f;
    self.selectView.frame = frame;
    [self addSubview:self.selectView];
}

#pragma mark - pickerviewDelegate

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _times.count;
}

#pragma mark - UIPickerViewDataSource

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 33;
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return  self.bounds.size.width;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [_times objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedText = [_times objectAtIndex:row];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *tit = (UILabel *)view;
    if (tit == nil) {
        tit = [[UILabel alloc] init];
        tit.font = [UIFont fontWithName:@"PingFangSC-Regular" size:23];
        tit.textColor = [UIColor whiteColor];
        [tit setTextAlignment:0];
        [tit setBackgroundColor:[UIColor clearColor]];
        [self.pickerView.subviews objectAtIndex:1].layer.borderWidth = .5f;
        [self.pickerView.subviews objectAtIndex:1].layer.borderColor = [UIColor whiteColor].CGColor;
        [self.pickerView.subviews objectAtIndex:2].layer.borderWidth = .5f;
        [self.pickerView.subviews objectAtIndex:2].layer.borderColor = [UIColor whiteColor].CGColor;
    }
    tit.textAlignment = NSTextAlignmentCenter;
    tit.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return tit;
}

@end
