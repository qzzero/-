//
//  ActivityDetaViewController.m
//  AWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "ActivityDetaViewController.h"
#import <AFHTTPSessionManager.h>
#import <MBProgressHUD.h>
@interface ActivityDetaViewController ()

@end

@implementation ActivityDetaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self getModel];
    
    self.title = @"活动详情";
    
    
}


#pragma -----Custom Model
- (void)getModel{

    
   AFHTTPSessionManager *sessionManager =  [AFHTTPSessionManager manager];
    [sessionManager GET:[NSString stringWithFormat:@"%@&id = %@",KActivityDeta,self.activityId] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responsObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];



}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
