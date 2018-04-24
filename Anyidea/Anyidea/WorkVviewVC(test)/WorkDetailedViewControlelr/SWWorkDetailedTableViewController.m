//
//  SWWorkDetailedTableViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/1/22.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWWorkDetailedTableViewController.h"
#import "SWWorkDetailTableViewCell.h"
#import "Masonry.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface SWWorkDetailedTableViewController () 
@property (nonatomic, strong) NSString *workDetailCellID;
@property (nonatomic, weak) SWWorkDetailTableViewCell *cell;
@property (nonatomic, assign) CGFloat detailHeight;
@end

@implementation SWWorkDetailedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.workDetailCellID = @"SWWorkDetailTableViewCell";
    [self setUpUI];
    
}

-(void)setUpUI{
    self.title = @"任務詳情";
    
    UINib *WorkDetailNib = [UINib nibWithNibName:self.workDetailCellID bundle:nil];
    [self.tableView registerNib:WorkDetailNib forCellReuseIdentifier:self.workDetailCellID];

    
}

//change self size
-(void)setImageArr:(NSArray *)imageArr
{
    _imageArr = imageArr;
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SWWorkDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.workDetailCellID forIndexPath:indexPath];
    cell.imageArr = self.imageArr;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //                 item個數 *  一行2個item的高度    + 任務詳細view的height
    return self.imageArr.count * (SCREEN_HEIGHT/3)/2 + SCREEN_HEIGHT;
}

-(void)dealloc
{
    NSLog(@"SWWorkDetailedTableViewController - dealloc");
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
