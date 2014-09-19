//
//  AddViewController.m
//  Paotui
//
//  Created by Tim on 14-9-17.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
{
    NSArray             *titleArray;
    
    UITextField         *writeAddress;
}

@end

@implementation AddViewController

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
    self.myTitle.text = @"添加地址";
    self.rightBtn.hidden = NO;
    self.rightBtn.titleLabel.text = @"确定";
    
    titleArray = [NSArray arrayWithObjects:@"肇加浜路112号",@"肇加浜路116号",@"肇加浜路122号",@"肇加浜路142号", nil];
    
    UITableView *settingTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, self.view.frame.size.width, self.view.frame.size.height-NavHeight)style:UITableViewStylePlain];
    settingTableview.delegate = self;
    settingTableview.dataSource = self;
    
    settingTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:settingTableview];
    
    
    UIView *headTableview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    settingTableview.tableHeaderView = headTableview;
    
    writeAddress = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, self.view.frame.size.width-20, 44)];
    [headTableview addSubview:writeAddress];
    
//    UIView *hedd = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
//    hedd.backgroundColor = [UIColor blueColor];
//    writeAddress.inputView = hedd;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdetify = @"SvTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdetify];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdetify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
//    if (indexPath.row == selectIndex) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    }
//    else
//    {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
    
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    writeAddress.text = [titleArray objectAtIndex:indexPath.row];
    
}
- (void)rightBtnClick
{

    [self.navigationController popViewControllerAnimated:YES];
    
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
