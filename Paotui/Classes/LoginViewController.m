//
//  LoginViewController.m
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"

@interface LoginViewController ()

@end


@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.phoneNumTextfield becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)sendConfirmClick:(id)sender {
}


- (IBAction)loginClick:(id)sender {
    
    NSString *urlString = [NSString stringWithFormat:@"http://192.168.0.101:8080/yunspeedserver/webapp/api/User/loginOrReg.api?"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@"13421342124" forKey:@"phoneNumber"];
    [parameters setObject:@"1342" forKey:@"code"];

    
    [manager POST:urlString parameters:parameters
         success:^(AFHTTPRequestOperation *operation,id responseObject) {
             NSLog(@"Success: %@", responseObject);
             
         }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
             NSLog(@"Error: %@", error);
         }];
    
    
    if (self.phoneNumTextfield.text.length == 0) {
        [self.phoneNumTextfield becomeFirstResponder];
    }
    else if (self.confirNumTextfield.text.length == 0) {
        [self.confirNumTextfield becomeFirstResponder];
    }
    
    if ([self.phoneNumTextfield.text isEqualToString:@"1234"] && [self.confirNumTextfield.text isEqualToString:@"1234"])
    {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomeViewController *homeView = [story instantiateViewControllerWithIdentifier:@"home"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
//        [self presentViewController:(UIViewController*)homeView animated:YES completion:nil];
//        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
