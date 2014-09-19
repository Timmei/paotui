//
//  EditViewController.m
//  Paotui
//
//  Created by Tim on 14-9-17.
//  Copyright (c) 2014年 Johnson. All rights reserved.
//

#import "EditViewController.h"


@interface EditViewController ()
{
    NSArray                 *titleArray;
    
    NSInteger               selectIndex;
    
}

@end

@implementation EditViewController

@synthesize addressDelegate;

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
    
    selectIndex = 0;
    
    self.delegate = self;
    self.myTitle.text = @"常用地址";
    self.rightBtn.hidden = NO;
    
    titleArray = [[NSArray alloc]initWithObjects:@"肇加浜路288号",@"陆家嘴213号",@"吴中路221号", nil];
    
    UITableView *settingTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, NavHeight, self.view.frame.size.width, self.view.frame.size.height-NavHeight)style:UITableViewStyleGrouped];
    settingTableview.delegate = self;
    settingTableview.dataSource = self;
    
    settingTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:settingTableview];
    
    
    
}
- (void)rightBtnClick
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AddViewController *addView = [story instantiateViewControllerWithIdentifier:@"add"];

    [self.navigationController pushViewController:addView animated:YES];

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
    
    if (indexPath.row == selectIndex) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = [titleArray objectAtIndex:indexPath.row];
    
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex = indexPath.row;
    [tableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    Address *seleAddress = [Address new];
    seleAddress.addressTitle = [titleArray objectAtIndex:indexPath.row];
    [addressDelegate selectAddress:seleAddress];
    
//    if (indexPath.row == 0)
//    {
//        //
//        
//    }
//    else if (indexPath.row == 1)
//    {
//        //
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
