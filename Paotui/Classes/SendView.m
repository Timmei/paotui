//
//  SendView.m
//  Paotui
//
//  Created by Tim on 14-9-18.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "SendView.h"

@implementation SendView
{
    NSArray             *dataArray;
    
    UIButton            *tips;
    UIButton            *booking;
    
    UIDatePicker        *datePicker;
    
    UIPickerView        *pickerView;
    
    UIView              *datePickView;
}


@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        pickerView = nil;
        datePickView = nil;
        [self initBackgroudView];
    }
    return self;
}

- (void)initBackgroudView
{
    UIButton *yuyinBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    [yuyinBtn setTitle:@"声音" forState:UIControlStateNormal];
    [self addSubview:yuyinBtn];
    [yuyinBtn addTarget:self action:@selector(yuyinClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *goodsLab = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, 250, 40)];
    goodsLab.backgroundColor = [UIColor clearColor];
    goodsLab.text = @"一瓶矿泉水";
    [self addSubview:goodsLab];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 40, 40)];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = @"地址";
    [self addSubview:lable];
    
    UITextField *addRess = [[UITextField alloc]initWithFrame:CGRectMake(60, 50, 250, 40)];
    addRess.text = @"肇加浜路288号1001室";
//    addRess.editing = NO;
    [self addSubview:addRess];
    
    tips = [[UIButton alloc]initWithFrame:CGRectMake(20, 90, 60, 60)];
    tips.backgroundColor = [UIColor blueColor];
    [tips setTitle:@"小费" forState:UIControlStateNormal];
    [self addSubview:tips];
    [tips addTarget:self action:@selector(tipsClick:) forControlEvents:UIControlEventTouchUpInside];
    
    booking = [[UIButton alloc]initWithFrame:CGRectMake(180, 90, 120, 60)];
    booking.backgroundColor = [UIColor blueColor];
    [booking setTitle:@"预约" forState:UIControlStateNormal];
    [self addSubview:booking];
    [booking addTarget:self action:@selector(yuyueClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *querenSend = [[UIButton alloc]initWithFrame:CGRectMake(60, 150, 200, 60)];
    querenSend.backgroundColor = [UIColor blueColor];
    [querenSend setTitle:@"确认发送" forState:UIControlStateNormal];
    [self addSubview:querenSend];
    [querenSend addTarget:self action:@selector(sendConfir:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)tipsClick:(UIButton*)btn
{
    
    dataArray = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20", nil];
    
    
    if (pickerView == nil) {
        pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 216)];
        //    指定Delegate
        pickerView.delegate=self;
        //    显示选中框
        pickerView.showsSelectionIndicator=YES;
        pickerView.backgroundColor = [UIColor purpleColor];
        [self addSubview:pickerView];

    }
    pickerView.hidden = NO;
    
    

//    pickerData=dataArray;
    
//    //     添加按钮
//    CGRect frame = CGRectMake(120, 250, 80, 40);
//    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    selectButton.frame=frame;
//    [selectButton setTitle:@"SELECT" forState:UIControlStateNormal];
//    
//    [selectButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    
//    [self.view addSubview:selectButton];
}

- (void)yuyueClick:(UIButton*)btn
{
    
    if (datePickView == nil) {
        
        datePickView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 216)];
        datePickView.backgroundColor = [UIColor grayColor];
        [self addSubview:datePickView];
        
        UIButton *cancelDate = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 50, 40)];
        [cancelDate setTitle:@"取消" forState:UIControlStateNormal];
        [datePickView addSubview:cancelDate];
        [cancelDate addTarget:self action:@selector(cancelDate:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *selectDate = [[UIButton alloc]initWithFrame:CGRectMake(260, 0, 50, 40)];
        [selectDate setTitle:@"确定" forState:UIControlStateNormal];
        [datePickView addSubview:selectDate];
        [selectDate addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 320, 176)];
        datePicker.backgroundColor = [UIColor darkGrayColor];
        // 设置时区
        [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        // 设置当前显示时间
        [datePicker setDate:[NSDate date] animated:YES];
        // 设置显示最大时间（此处为当前时间）
        //    [datePicker setMaximumDate:[NSDate date]];
        // 设置UIDatePicker的显示模式
        [datePicker setDatePickerMode:UIDatePickerModeTime];
        // 当值发生改变的时候调用的方法
        [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
        [datePickView addSubview:datePicker];
    }
    datePickView.hidden = NO;
    
//    [datePicker release];
    
    
}

- (void)cancelDate:(UIButton*)btn
{
    datePickView.hidden = YES;
}

- (void)selectDate:(UIButton*)btn
{
    datePickView.hidden = YES;
//    datePicker
    NSDate *seleDate = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"HH:mm:ss"];//yyyy-MM-dd

    NSString *destDateString = [dateFormatter stringFromDate:seleDate];
    
    [booking setTitle:destDateString forState:UIControlStateNormal];
    
    
}
- (void)datePickerValueChanged:(UIDatePicker*)datePick
{
    // 获得当前UIPickerDate所在的时间
    NSDate *selected = [datePick date];
}
- (void)yuyinClicked:(id)sender
{
    [delegate yuyinPlay];
}

- (void)sendConfir:(id)sender
{
    [delegate sendConfirClick];
}

#pragma mark Picker Date Source Methods

//返回显示的列数
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [dataArray count];
}

#pragma mark Picker Delegate Methods

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataArray objectAtIndex:row];
}
-(void) pickerView: (UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent: (NSInteger)component
{
    [tips setTitle:[dataArray objectAtIndex:row] forState:UIControlStateNormal];
    pickerView.hidden = YES;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
