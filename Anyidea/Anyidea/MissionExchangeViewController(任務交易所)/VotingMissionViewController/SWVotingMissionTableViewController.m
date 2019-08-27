//
//  SWVotingMissionTableViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2017/12/19.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//

#define BigCellHeight 166

#import "SWVotingMissionTableViewController.h"
#import "SWHotMissionViewCell.h"
#import "SWVotingMissionTableViewCell.h"
#import "MainTableViewHeader.h"
#import "SWWorkDetailCollectionController.h"
#import "SWScreenHelper.h"

@interface SWVotingMissionTableViewController ()


@end

//cellid
static NSString * const hotMissionCellID = @"SWHotMissionViewCell";
static NSString * const VotingMissionCellID = @"SWVotingMissionTableViewCell";
@implementation SWVotingMissionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpUi];
}

-(void)setUpUi {
    [self.tableView registerNib:[UINib nibWithNibName:hotMissionCellID bundle:nil] forCellReuseIdentifier:hotMissionCellID];
    [self.tableView registerNib:[UINib nibWithNibName:VotingMissionCellID bundle:nil] forCellReuseIdentifier:VotingMissionCellID];
    self.tableView.estimatedRowHeight = BigCellHeight;
}

-(void)selectCellWithIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:hotMissionCellID forIndexPath:indexPath];
    }
    
    if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:hotMissionCellID forIndexPath:indexPath];
    }

    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerID = @"sectionID";
    UITableViewHeaderFooterView *sectionHeaderView = [[UITableViewHeaderFooterView alloc]initWithReuseIdentifier:headerID];
        if (section == 0) {
            sectionHeaderView.textLabel.text = @"民眾最愛投票區";
        }else if (section == 1){
            sectionHeaderView.textLabel.text = @"投票中任務";
        }
    
    return sectionHeaderView;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor  = [UIColor redColor];
//    header.contentView.backgroundColor = [UIColor whiteColor];
    
}

//
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(votingMissionTableViewVcDidScroll:andScrollView:)]) {
        [self.delegate votingMissionTableViewVcDidScroll:self andScrollView:scrollView];
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SWWorkDetailCollectionController *workDetailVc =  [SWWorkDetailCollectionController workDetailColletionController];
    [self.mainNavVc pushViewController:workDetailVc animated:YES];
    
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
