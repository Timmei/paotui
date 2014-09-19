//
//  SendViewSec.m
//  Paotui
//
//  Created by Tim on 14-9-18.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "SendViewSec.h"

@implementation SendViewSec

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self initBackgroudView];
    }
    
    return self;
}


- (void)initBackgroudView
{
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 50, 40)];
    lable.backgroundColor = [UIColor clearColor];
    lable.text = @"地址";
    [self addSubview:lable];
    
    UITextField *addRess = [[UITextField alloc]initWithFrame:CGRectMake(60, 10, 250, 40)];
    addRess.text = @"肇加浜路288号1001室";
    [self addSubview:addRess];
    
    UIButton *tips = [[UIButton alloc]initWithFrame:CGRectMake(20, 60, 60, 60)];
    tips.backgroundColor = [UIColor blueColor];
    [tips setTitle:@"小费" forState:UIControlStateNormal];
    [self addSubview:tips];
    
    UIButton *booking = [[UIButton alloc]initWithFrame:CGRectMake(240, 60, 60, 60)];
    booking.backgroundColor = [UIColor blueColor];
    [booking setTitle:@"预约" forState:UIControlStateNormal];
    [self addSubview:booking];
    
    UIButton *querenSend = [[UIButton alloc]initWithFrame:CGRectMake(60, 150, 200, 60)];
    querenSend.backgroundColor = [UIColor blueColor];
    [querenSend setTitle:@"确认发送" forState:UIControlStateNormal];
    [self addSubview:querenSend];
    [querenSend addTarget:self action:@selector(sendConfir:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void)sendConfir:(id)sender
{
    [delegate sendSecConfirClick];
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
