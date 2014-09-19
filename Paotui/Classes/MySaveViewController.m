//
//  MySaveViewController.m
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "MySaveViewController.h"
#import "ShopViewController.h"

@interface MySaveViewController ()

@end

@implementation MySaveViewController

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
    self.myTitle.text = @"我的收藏";
    
    
    
    UITableView *orderTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, self.view.frame.size.width, self.view.frame.size.height-NavHeight)];
    orderTableview.delegate = self;
    orderTableview.dataSource = self;

    
    [self.view addSubview:orderTableview];
    
}


- (void)leftBtnClick
{
    
    [self.navigationController popViewControllerAnimated:YES];
//    [[QHSliderViewController sharedSliderController] closeSideBarWithAnimate:NO complete:^(BOOL finished) {}];

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"SvTableViewCell";
    SaveCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[SaveCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Shop" bundle:nil];
    ShopViewController *shopView = [story instantiateViewControllerWithIdentifier:@"shop"];
    
    Store *store = [Store new];
    store.shopName = @"全家便利店";
    store.shopAddress = @"肇加浜路122号";
    store.shopPhone = @"35295825";
    
    shopView.myStore = store;
    //    editView.addressDelegate = self;
    [[QHSliderViewController sharedSliderController].navigationController pushViewController:shopView animated:YES];
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
