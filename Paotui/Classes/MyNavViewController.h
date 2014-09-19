//
//  MyNavViewController.h
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NavleftBtnDelegate <NSObject>

- (void)leftBtnClick;
- (void)rightBtnClick;

@end

@interface MyNavViewController : UIViewController

@property(nonatomic,strong)id<NavleftBtnDelegate>delegate;
@property(nonatomic,strong)UILabel *myTitle;

@property(nonatomic,strong)UIButton *rightBtn;

@end
