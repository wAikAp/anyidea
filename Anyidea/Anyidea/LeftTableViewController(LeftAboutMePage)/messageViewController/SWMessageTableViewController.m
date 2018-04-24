//
//  SWMessageTableViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/15.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWMessageTableViewController.h"
#import "SWMessageDetailViewController.h"
#import "SWMessageTableViewCell.h"

#import "UIViewController+MMDrawerController.h"

@interface SWMessageTableViewController ()

@property (nonatomic, strong) NSArray *tableDateArr;

@end


static NSString *const messageTableViewCellID = @"SWMessageTableViewCell";
@implementation SWMessageTableViewController

-(NSArray *)tableDateArr
{
    if (!_tableDateArr) {
        _tableDateArr = @[@"你的獎金已發放",@"新任務通知",@"新任務通知"];
    }
    return _tableDateArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"短消息";
    self.tableView.estimatedRowHeight = 60;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backBtn"] style:UIBarButtonItemStylePlain target:self action:@selector(navLeftBtnDidClick)];
    [self.tableView registerNib:[UINib nibWithNibName:messageTableViewCellID bundle:nil] forCellReuseIdentifier:messageTableViewCellID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)navLeftBtnDidClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tableDateArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SWMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageTableViewCellID];
    if (indexPath.row==0) {
        cell.messageImageView.image = [UIImage imageNamed:@"bonus"];
    }else
    {
        cell.messageImageView.image = [UIImage imageNamed:@"newmissionNotive"];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWMessageDetailViewController *detailVc = [SWMessageDetailViewController messageDetailViewController];
    [self.navigationController pushViewController:detailVc animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
