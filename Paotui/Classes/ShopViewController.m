//
//  ShopViewController.m
//  Paotui
//
//  Created by Tim on 14-9-18.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "ShopViewController.h"

#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"

@interface ShopViewController ()
{
    SendView                *sendview;
}

@end



@implementation ShopViewController

@synthesize myStore;

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
    
    self.delegate = self;
    self.myTitle.text = @"全家便利店";
    
    self.rightBtn.hidden = NO;
    
    self.storeName.text = myStore.shopName;
    self.address.text = myStore.shopAddress;
    self.phoneNum.text = myStore.shopPhone;
    
    sendview = [[SendView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-240, 320, 240)];
    sendview.backgroundColor = [UIColor redColor];
    [self.view addSubview:sendview];
    sendview.delegate = self;
    sendview.hidden = YES;
    
}

#pragma mark sendDelegate

- (void)yuyinPlay
{
    
}
- (void)sendConfirClick
{
    CGRect rect = sendview.frame;
    rect.origin.y += 100;
    
    
    [UIView animateWithDuration:0.5 animations:^{
        sendview.frame = rect;
        
        
        
    }];
    
    UIAlertView *aler = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已通知便利店，请等待" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [aler show];
    
}

- (void)dismissAler
{
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [alertView dismissWithClickedButtonIndex:1 animated:YES];
        CGRect rect = sendview.frame;
        rect.origin.y -= 100;
        sendview.hidden = YES;
        return;
    }
    
    CGRect rect = sendview.frame;
    rect.origin.y -= 100;
    
    [UIView animateWithDuration:0.5 animations:^{
        sendview.frame = rect;
        
        
        
    }];
}


- (void)rightBtnClick
{
    sendview.hidden = NO;
    sendview.frame = CGRectMake(0, self.view.frame.size.height-240, 320, 240);
    
//    NSString *urlString = [NSString stringWithFormat:@"http://192.168.0.101:8080/yunspeedserver/webapp/api/Order/sendOrder.api"];
//    
//    
//    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//
//    
//    NSMutableDictionary *parameters = [NSMutableDictionary new];
//    [parameters setObject:@"肇加浜路288号" forKey:@"orderAddress"];
//    [parameters setObject:@"0" forKey:@"tip"];
//    
//    [parameters setObject:@"2014-09-18 14:00" forKey:@"wantSendTime"];
//    
//    [parameters setObject:@"one" forKey:@"shopType"];
//    [parameters setObject:@"2014-09-18" forKey:@"sendTime"];
//    [parameters setObject:@"1" forKey:@"contentType"];
//    [parameters setObject:@"SDSADASD" forKey:@"content"];
//    [parameters setObject:@"15618355957" forKey:@"userId"];
//    [parameters setObject:@"12" forKey:@"shopId"];
//    [parameters setObject:@"0" forKey:@"orderState"];
//    
//    NSString *paraStr = [NSString stringWithFormat:@"{\"orderAddress\":\"肇嘉浜路222号\",\"tip\":\"20\",\"wantSendTime\":\"2014-09-18 14:00\",\"shopType\":\"one\",\"sendTime\":\"2014-09-18\",\"contentType\":\"1\",\"content\":\"SDSADASD\",\"userId\":\"15618355957\",\"shopId\":\"1\",\"orderState\":\"0\"}"];
//    
//    
////    NSString *transString = [NSString stringWithString:[paraStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    
//
//    NSMutableDictionary *orderDic = [NSMutableDictionary new];
//    [orderDic setObject:paraStr forKey:@"order"];
//    
//    [manager POST:urlString parameters:orderDic
//          success:^(AFHTTPRequestOperation *operation,id responseObject) {
//              NSLog(@"Success: %@", responseObject);
//              
//          }failure:^(AFHTTPRequestOperation *operation,NSError *error) {
//              NSLog(@"Error: %@", error);
//          }];

    
    
}
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
    //    [[QHSliderViewController sharedSliderController] closeSideBarWithAnimate:NO complete:^(BOOL finished) {}];
    
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

@end
