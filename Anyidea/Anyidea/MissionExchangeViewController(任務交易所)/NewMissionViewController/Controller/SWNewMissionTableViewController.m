//
//  SWNewMissionTableViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2017/12/18.
//  Copyright © 2017年 shingwai chan. All rights reserved.
//


#define normalCellHeight 44
#define BigCellHeight 166

#import "SWNewMissionTableViewController.h"
#import "SWHotMissionViewCell.h"
#import "MainNavigationController.h"
#import "SWWorkDetailCollectionController.h"
#import "SWNewMissionsTableViewCell.h"
#import "SWScreenHelper.h"


@interface SWNewMissionTableViewController ()

@end


static NSString *const hotMissionCellID = @"SWHotMissionViewCell";
static NSString *const newMissionsTableViewCellID = @"SWNewMissionsTableViewCell";

@implementation SWNewMissionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:hotMissionCellID bundle:nil] forCellReuseIdentifier:hotMissionCellID];
//    [self.tableView registerNib:[UINib nibWithNibName:newMissionsTableViewCellID bundle:nil] forCellReuseIdentifier:newMissionsTableViewCellID];
//    self.tableView.estimatedRowHeight = 50.f;
}


//public function
-(void)selectCellWithIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    SWHotMissionViewCell * cell = [tableView dequeueReusableCellWithIdentifier:hotMissionCellID forIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SWWorkDetailCollectionController *workDetailVc =  [SWWorkDetailCollectionController workDetailColletionController];
    [self.mainNavVc pushViewController:workDetailVc animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(missionTableViewControllerDidScroll:andScrollView:)]) {
        [self.delegate missionTableViewControllerDidScroll:self andScrollView:scrollView];
    }
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
