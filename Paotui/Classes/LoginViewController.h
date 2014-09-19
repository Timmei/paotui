//
//  LoginViewController.h
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController;

@interface LoginViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *confirNumTextfield;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextfield;
@property (weak, nonatomic) IBOutlet UIButton *sendConfirNumBtn;
- (IBAction)sendConfirmClick:(id)sender;
- (IBAction)loginClick:(id)sender;
@end
