//
//  SettingViewController.h
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavViewController.h"
#import "EditViewController.h"

@interface SettingViewController : MyNavViewController<NavleftBtnDelegate,UITableViewDataSource,UITableViewDelegate,selectAddressDelegate>

@end
