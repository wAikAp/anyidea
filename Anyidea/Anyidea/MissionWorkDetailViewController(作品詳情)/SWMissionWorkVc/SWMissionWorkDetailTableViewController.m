//
//  SWMissionWorkDetailTableViewController.m
//  Anyidea
//
//  Created by shingwai chan on 18/1/2019.
//  Copyright © 2019 shingwai chan. All rights reserved.
//

#import "SWMissionWorkDetailTableViewController.h"
#import "SWMissionWorkDetailHeader.h"
#import "SWMissionWorkDetaiilTableViewCell.h"
#import "SWUserIconViewController.h"
#import "SWUserCenterViewController.h"

#import "ANnetworkManage.h"
#import "MissionWorkModel.h"
#import "SWCalculateTool.h"
#import "UIImageView+WebCache.h"
#import "SWScreenHelper.h"
//#import "UserModel.h"

#import "SVProgressHUD.h"

@interface SWMissionWorkDetailTableViewController ()<SWMissionWorkDetailHeaderDelegate>
@property (nonatomic, weak) SWMissionWorkDetailHeader *workHeader;
@property (nonatomic, strong) MissionWorkModel *workModel;
@end

static NSString *const cellID = @"SWMissionWorkDetaiilTableViewCell";
@implementation SWMissionWorkDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        self.navigationItem.largeTitleDisplayMode = UINavigationItemLargeTitleDisplayModeAlways;
    } else {
        // Fallback on earlier versions
    }
    self.title = @"作品詳情";
    SWMissionWorkDetailHeader *workHeader = [SWMissionWorkDetailHeader missionWorkDetailHeader];
    workHeader.delegate = self;
    self.workHeader = workHeader;
    self.tableView.tableHeaderView = workHeader;
    
    [self.tableView registerNib:[UINib nibWithNibName:cellID bundle:nil] forCellReuseIdentifier:cellID];
//    self.tableView.estimatedRowHeight =
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self mapData];
}
-(void)mapData{
    [SVProgressHUD showWithStatus:@"Loading..."];
    [[ANnetworkManage shareNetWorkManage]getWorkDetailWithWorkID:self.workID success:^(id  _Nonnull responseObject, NSString * _Nonnull errorMsg) {
//        NSLog(@"work detail seuccess = %@",responseObject);
        MissionWorkModel *work = [[MissionWorkModel alloc]initWithJsonToModel:responseObject];
        self.workModel = work;
        [self updateUI:work];
    } Error:^(NSError * _Nonnull errorBack) {
        NSLog(@"work detail error = %@",errorBack);
        [SVProgressHUD showErrorWithStatus:@"Server error，請稍後重試"];
        [SVProgressHUD dismissWithDelay:1.f];
    }];
}
-(void)updateUI:(MissionWorkModel *)work{
    self.workHeader.workTitleDisplay.text = work.work_title;
    self.workHeader.workIdLabel.text = work.work_id;
    
    self.workHeader.descDisplay.text =[SWCalculateTool stringFilterHTMLTag:work.work_description];
    self.workHeader.time.text = [SWCalculateTool formatDateTo_yyyy_MM_dd_HH_mm_ss:work.created_date];
    self.workHeader.viewsLabel.text = work.views;
    self.workHeader.likeLabel.text = work.votes;
    
    [self.workHeader.icon sd_setImageWithURL:[NSURL URLWithString:work.postWorkUser.profile_picture]];
    self.workHeader.userName.text = work.postWorkUser.username;
    NSString *wintagStr = work.is_finalist? @"入圍作品":@"";
    NSString *wintagStr2 = work.is_winner? @"中標作品":@"";
    [self.workHeader.winTag setTitle:[NSString stringWithFormat:@"%@%@",wintagStr,wintagStr2] forState:UIControlStateNormal];
    [self.tableView reloadData];
    [SVProgressHUD dismiss];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWMissionWorkDetaiilTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    [cell.workImage sd_setImageWithURL:[NSURL URLWithString:self.workModel.attachment_url] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.privateBtn.hidden = !self.workModel.is_protected;
//    [cell.workImage sd_setImageWithURL:[NSURL URLWithString:self.workModel.attachment_url] placeholderImage:[UIImage imageNamed:@"placeholder"] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"image heght %@",image);
//    }];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGFloat)(Screen_Height * 0.5);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.workModel.is_protected) {
        return;
    }
    SWUserIconViewController *imageVc = [[SWUserIconViewController alloc]init];
    imageVc.imageUrl = self.workModel.attachment_url;
    imageVc.navTitle = @"作品詳情";
    [self.navigationController pushViewController:imageVc animated:YES];
}

-(void)headerViewTopViewDidClick:(UIView *)header{
    SWUserCenterViewController *userCenterVc = [[SWUserCenterViewController alloc]init];
    userCenterVc.title = @"創意人資料";
    userCenterVc.isCurrentUser = NO;
    userCenterVc.userModel = self.workModel.postWorkUser;
    [self.navigationController pushViewController:userCenterVc animated:YES];
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
