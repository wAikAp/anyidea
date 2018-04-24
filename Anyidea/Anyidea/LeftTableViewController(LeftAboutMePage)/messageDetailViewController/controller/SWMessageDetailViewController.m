//
//  SWMessageDetailViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/2/6.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWMessageDetailViewController.h"
#import "SWMessageDetailTableViewCell.h"
#import "SWMessageDetailViewHeader.h"

#import "SWScreenHelper.h"

@interface SWMessageDetailViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SWMessageDetailViewController

static NSString *const messageDetailTableViewCellID = @"SWMessageDetailTableViewCell";
+(instancetype)messageDetailViewController
{
    
    SWMessageDetailViewController *messageDetailVc = [[SWMessageDetailViewController alloc]initWithNibName:NSStringFromClass(SWMessageDetailViewController.class) bundle:nil];
    messageDetailVc.title =@"短消息";
    return messageDetailVc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:messageDetailTableViewCellID bundle:nil] forCellReuseIdentifier:messageDetailTableViewCellID];
    SWMessageDetailViewHeader *header = [SWMessageDetailViewHeader messageDetailViewHeader];
    self.tableView.tableHeaderView =header;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWMessageDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:messageDetailTableViewCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.content.text = @"aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
    return cell;
}


//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [SWScreenHelper screenHeight];
//}

@end
