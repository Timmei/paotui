//
//  UserViewController.h
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *userTableview;

@end
