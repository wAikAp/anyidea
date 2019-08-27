//
//  SWSubmitJobTableViewController.m
//  Anyidea
//
//  Created by shingwai chan on 2018/7/7.
//  Copyright © 2018年 shingwai chan. All rights reserved.
//

#import "SWSubmitJobTableViewController.h"
#import "SWSubmitJobTableViewCell.h"
#import "SWSubmitJobHeader.h"
#import "MainNavigationController.h"

#import "SWScreenHelper.h"
#import "UIView+Extension.h"
#import "MissionWorkModel.h"
#import "LoginUserTokenInfo.h"
#import "ANnetworkManage.h"
#import "SVProgressHUD.h"
#import <Photos/Photos.h>

static NSString * const SWSubmitJobTableViewCellID = @"SWSubmitJobTableViewCell";

@interface SWSubmitJobTableViewController () <SWSubmitJobTableViewCellDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) NSString *workTitle;
@property (nonatomic, strong) NSString *workDescription;
@property (nonatomic, strong) UIImage *attImage;
@property (nonatomic, strong) UIImagePickerController *pickerVc;

@end

@implementation SWSubmitJobTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellSubmitDidClick:) name:@"SubmiWorkCellSubmitBtnDidClick" object:nil];
;
    self.title = @"投稿作品";
    SWSubmitJobHeader *header = [SWSubmitJobHeader submitHeader];
    header.bonusTitle.text = self.missionModel.winner_amount_display;
    header.missionDate.text = self.missionModel.submit_date;
    header.missionTitle.text = self.missionModel.job_title;
    header.idLabel.text = [NSString stringWithFormat:@"#%@",self.missionModel.job_id];
    self.tableView.tableHeaderView = header;
    [self.tableView registerNib:[UINib nibWithNibName:SWSubmitJobTableViewCellID bundle:nil] forCellReuseIdentifier:SWSubmitJobTableViewCellID];
    
    UIImagePickerController *pickController = [[UIImagePickerController alloc]init];
    pickController.delegate = self;
    pickController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickController.view.backgroundColor = [UIColor whiteColor];
    pickController.allowsEditing = YES;
    self.pickerVc = pickController;
    self.tableView.estimatedRowHeight = 300;
}

static const CGFloat SEC = 1.5f;
-(void)cellSubmitDidClick:(NSNotification *)notif{
    MissionWorkModel *workModel = notif.object;
    NSString *errStr = @"";
    if ([workModel.work_title  isEqual: @""] || !workModel.work_title) {
        errStr = [errStr stringByAppendingString:@"作品名稱不能留空！\n"];
    }
    if(!self.attImage){
        errStr = [errStr stringByAppendingString:@"請選擇一張圖片作為附件！"];
    }
    
    if (![errStr isEqualToString:@""]) {
        [SVProgressHUD showInfoWithStatus:errStr];
        [SVProgressHUD dismissWithDelay:SEC];
        return;
    }
    LoginUserTokenInfo *info = [LoginUserTokenInfo shareLogingUsrToken];
    [SVProgressHUD showWithStatus:@"Loading..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    NSString *work_visibility = workModel.is_protected? @"2":@"3";
    [[ANnetworkManage shareNetWorkManage] workSubmitWithMissionJobId:self.missionModel.job_id andAccessTkn:info.access_token tknType: info.token_type andImage:self.attImage work_title:workModel.work_title work_description:workModel.work_description work_visibility:work_visibility success:^(id  _Nonnull responseObject, NSString * errorMsg) {
        NSString *status = responseObject[@"status"];
        if (status.integerValue) {
            [SVProgressHUD showSuccessWithStatus:@"成功投稿！\nGood luck!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"提交投稿失敗\n%@",responseObject[@"error_message"]]];
        }
        [SVProgressHUD dismissWithDelay:SEC];
    } Error:^(NSError * error) {
        NSLog(@"服務器錯誤 class:%@ Error:%@",self.class,error);
        
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"Server Error,請稍後重試 code:%ld",error.code]];
    }];
}

-(void)submitJobCelldidClickAttBtn:(UIButton *)btn{

    [self checkDevicePermissionAndPhotoLibraryAuth];
}

#pragma mark - imagePicker
-(void)alertActionShow{
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:@"App獲取不了相冊權限" message:@"請在本機中設置允許訪問相冊權限" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *set = [UIAlertAction actionWithTitle:@"前往設置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
    }];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [actionSheet addAction:set];
    [actionSheet addAction:ok];
    [self presentViewController:actionSheet animated:YES completion:nil];
    
}
- (void)checkDevicePermissionAndPhotoLibraryAuth{
    
    BOOL auth = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
    if (!auth) return;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) { //pop up the alterBox
        if (status == PHAuthorizationStatusAuthorized) { // has right
            dispatch_async(dispatch_get_main_queue(),^{
                
                self.pickerVc.sourceType   = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:self.pickerVc animated:YES completion:nil];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(),^{ // no right
                [self alertActionShow];
            });
            
        }
    }];
}
-(void)checkPhotoLibraryAndOpenPhotoPicker{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        [self alertActionShow];
        return;
    }
    
    if (@available(iOS 11.0, *)) {
        PHAuthorizationStatus  stauts = [PHPhotoLibrary authorizationStatus];
        if (stauts == PHAuthorizationStatusDenied || stauts == PHAuthorizationStatusRestricted) {
            [self alertActionShow];
            return;
        }
        
    }
   
    
//    pickController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    
    [self presentViewController:self.pickerVc animated:YES completion:nil];
}

#pragma mark - picker call back
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = (UIImage *)[info objectForKey:UIImagePickerControllerOriginalImage];
    self.attImage = image;
    [[NSNotificationCenter defaultCenter]postNotificationName:@"imagePickerVcFinishedPickCallBack" object:image];
//    NSLog(@"call = %@",image);
    
//    UIImageWriteToSavedPhotosAlbum(image, self, selectorToCall, NULL);
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - didReceiveMemoryWarning
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
    
    SWSubmitJobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SWSubmitJobTableViewCellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(void)dealloc{
    NSLog(@"%@ dealloc",self.class);
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
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
