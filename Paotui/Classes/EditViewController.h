//
//  EditViewController.h
//  Paotui
//
//  Created by Tim on 14-9-17.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavViewController.h"
#import "Address.h"
#import "AddViewController.h"

@protocol selectAddressDelegate <NSObject>

- (void)selectAddress:(Address*)address;

@end

@interface EditViewController : MyNavViewController<NavleftBtnDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)id<selectAddressDelegate>addressDelegate;

@end
