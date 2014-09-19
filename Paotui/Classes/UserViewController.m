//
//  UserViewController.m
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "UserViewController.h"
#import "MyOrderViewController.h"
#import "MySaveViewController.h"
#import "SettingViewController.h"

@interface UserViewController ()
{
    NSArray         *titleArray;
    
    CGRect          tableRect;
}

@end

@implementation UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
//    [self.userTableview setContentOffset:CGPointMake(0, 20)];
//    self.userTableview.frame = tableRect;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 270, self.view.frame.size.height)];
    tableview.delegate = self;
    tableview.dataSource = self;
    self.userTableview = tableview;
    
    [self.view addSubview:tableview];
    
    titleArray = [NSArray arrayWithObjects:@"我的订单",@"我的收藏",@"设置", nil];
    
    UIView *headTable = [[UIView alloc]initWithFrame:CGRectMake(0, 0, witheUser, 160)];
//    headTable.backgroundColor = [UIColor redColor];
    self.userTableview.tableHeaderView = headTable;
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(100, 60, 70, 70)];
    image.backgroundColor = [UIColor redColor];
    [headTable addSubview:image];
    
    UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake(80, 130, 120, 40)];
    numLab.text = @"12328278721";
    [headTable addSubview:numLab];
    
    tableRect = self.userTableview.frame;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";

    
//    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = nil;
    // Configure the cell...
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self.userTableview setContentOffset:CGPointMake(0, 20)];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    NSArray *segArray = [NSArray arrayWithObjects:@"order",@"save",@"setting", nil];
    
    UIViewController *subViewController = [story instantiateViewControllerWithIdentifier:[segArray objectAtIndex:indexPath.row]];
    
    [[QHSliderViewController sharedSliderController].navigationController pushViewController:subViewController animated:YES];
    
    
    
//    if (indexPath.row == 0) {
//        
//        
//    }
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
