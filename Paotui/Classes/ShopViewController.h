//
//  ShopViewController.h
//  Paotui
//
//  Created by Tim on 14-9-18.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyNavViewController.h"
#import "Store.h"
#import "SendView.h"

@interface ShopViewController : MyNavViewController<NavleftBtnDelegate,sendViewDelegate>

@property (strong,nonatomic)Store *myStore;

@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *distance;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@end
