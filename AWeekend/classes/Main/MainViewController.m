//
//  MainViewController.m
//  AWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "MainModel.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//全部列表数据
@property (nonatomic, strong) NSMutableArray *listArray;
//推荐活动数据
@property (nonatomic, strong) NSMutableArray *activityArray;
//推荐专题数据
@property (nonatomic, strong) NSMutableArray *themeArray;


@end




@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 //left
    UIBarButtonItem *leftBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"北京" style:UIBarButtonItemStylePlain target:self action:@selector(selectcityAction)];
    leftBarBtn.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftBarBtn;
    
    //right
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom ];
    rightbtn.frame = CGRectMake(0, 0, 14, 14);
    [rightbtn setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(searchActiveAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
//    self.navigationItem.leftBarButtonItem = rightBarBtn;
    [self.view addSubview:rightbtn];
    
    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    
    
    
    //请求网络数据
    [self requestModel];

    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:urlString parameters:nil progress:^(NSProgress *_Nonnull  downloadProgress) success:^(NSURLSessionDataTask *_Nonnull task,id _Nullable responseObject){
        NSDictionary *resultDic  = responseObject;
        NSString *status = resiltDic[@"status"];
        NSInteger code = [resiltDic[@"code"]integerValue];
        
        if ([status isEqualToString:@"success"] && code == 0) {
            NSDictionary *dic = resultDic[@"success"];
             NSDictionary *acDataArray = resultDic[@"acData"];
            for (NSDictionary *dict in acDataArray) {
                
            }
            
            
            //广告
             NSDictionary *adDataArray = resultDic[@"adData"];
            //推荐主题
             NSDictionary *rcDataArray = resultDic[@"rcData"];
            
            for (NSDictionary *dic in rcDataArray) {
                MainModel *model = [[MangoModel alloc] initWithDictionary:dic];
            }
             NSDictionary *cityname = resultDic[@"cityname"];
            
            
            
            //以请求回来的城市作为导航栏按钮标题
            NSString *cityname = dic[@"cityname"]
            self.navigationItem.leftBarButtonItem = cityname;
        }
    
    } failure:<#^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)failure#>];
    
    
    
}
#pragma mark ------- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{


    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MainTableViewCell *maincell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    

        
    return maincell;

}


#pragma mark ------- UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.listArray.count;


}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (section == 0) {
//        return 343;
//    }
    return 203;

}

//自定义分区头部

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 343)];
    view.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = view;
    return nil;
}


#pragma mark --------
//选择城市
- (void)selectcityAction{




}
//搜索关键字
- (void)searchActiveAction{
    
    
    
   

}

//自定义tableview头部
- (void)configTableViewHeadView{





}



- (void)requestModel{
//



}


- (NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }

    return _listArray;

}

- (NSMutableArray *)activityArray{
    if (_activityArray == nil) {
        self.activityArray = [NSMutableArray new];
    }
    
    return _activityArray;
    
}

- (NSMutableArray *)themeArray{
    if (_themeArray == nil) {
        self.themeArray = [NSMutableArray new];
    }
    
    return _themeArray;
    
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
