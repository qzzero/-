//
//  UIViewController+Common.m
//  AWeekend
//
//  Created by scjy on 16/1/6.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "UIViewController+Common.h"

@implementation UIViewController (Common)

- (void)showBackBtn{

    
    UIButton *backbtn  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [backbtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem = leftBarBtn;


    [self.navigationController popToRootViewControllerAnimated:YES];

}



@end
