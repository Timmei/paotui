//
//  SettingViewController.m
//  Paotui
//
//  Created by Tim on 14-9-12.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "SettingViewController.h"

#import "FeedbackViewController.h"

@interface SettingViewController ()
{
    NSArray                     *titleArray;
    
    UITableView                 *settingTableview;
    
    Address                     *defaulAddModel;
}

@end

@implementation SettingViewController

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
    self.myTitle.text = @"设置";
    
    titleArray = [[NSArray alloc]initWithObjects:@"默认地址",@"建议与反馈", nil];
    
    defaulAddModel = [Address new];
    defaulAddModel.addressTitle = @"肇加浜路111号";
    
    settingTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, self.view.frame.size.width, self.view.frame.size.height-NavHeight)style:UITableViewStyleGrouped];
    settingTableview.delegate = self;
    settingTableview.dataSource = self;
    
    settingTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:settingTableview];
    
    //退出登录按钮
    UIView *footTableview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 60)];
    
    settingTableview.tableFooterView = footTableview;
    
    UIButton *logoutBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, (self.view.frame.size.width-20), 50)];
    [logoutBtn setTitle:@"退出登录"forState:UIControlStateNormal];
    [logoutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [logoutBtn addTarget:self action:@selector(logoutClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footTableview addSubview:logoutBtn];
    
}

- (void)selectAddress:(Address *)address
{
    defaulAddModel = address;
    [settingTableview reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        //
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        EditViewController *editView = [story instantiateViewControllerWithIdentifier:@"edit"];
        editView.addressDelegate = self;
        [self.navigationController pushViewController:editView animated:YES];
    }
    else if (indexPath.row == 1)
    {
        //
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FeedbackViewController *feedbackView = [story instantiateViewControllerWithIdentifier:@"feedback"];
        
        [self.navigationController pushViewController:feedbackView animated:YES];
        
    }
}

- (void)logoutClick:(UIButton *)sender
{
    
}
- (void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
//    [[QHSliderViewController sharedSliderController] closeSideBarWithAnimate:NO complete:^(BOOL finished) {}];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdetify = @"SvTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        static UILabel *defaulAddress = nil;
        if (defaulAddress==nil) {
            defaulAddress = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, 210, 44)];
            defaulAddress.textAlignment = NSTextAlignmentRight;
            defaulAddress.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:defaulAddress];
        }
        defaulAddress.text = defaulAddModel.addressTitle;
        
        
        
    }
    
    return cell;
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
