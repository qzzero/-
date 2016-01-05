//
//  MainViewController.m
//  AWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 qzp. All rights reserved.
//
#define kWideth  [UIScreen mainScreen].bounds.size.width
#import "MainViewController.h"
#import "MainTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "MainModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
//全部列表数据
@property (nonatomic, strong) NSMutableArray *listArray;
//推荐活动数据
@property (nonatomic, strong) NSMutableArray *activityArray;
//推荐专题数据
@property (nonatomic, strong) NSMutableArray *specialArray;
//广告
@property (nonatomic, strong) NSMutableArray *adArray;

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
//    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeCustom ];
//    rightbtn.frame = CGRectMake(0, 0, 14, 14);
//    [rightbtn setImage:[UIImage imageNamed:@"btn_search"] forState:UIControlStateNormal];
//    [rightbtn addTarget:self action:@selector(searchActiveAction) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
//    self.navigationItem.leftBarButtonItem = rightBarBtn;
   
    
    
    //right
    //导航栏上navigationItem
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchActiveAction)];
    //1.设置导航栏上的左右按钮  把leftBarButton设置为navigationItem左按钮
    self.navigationItem.rightBarButtonItem = rightBarButton;

    
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //自定义头部cell
    [self configTableView];
    
    
    
    //请求网络数据
    [self requestModel];

    
}
#pragma mark -----自定义TableView头部
//自定义头部
- (void)configTableView{

    UIView *tableHeaderView = [[UIView alloc]init];
    tableHeaderView.frame = CGRectMake(0, 0, kWideth, 343);
    
    
    
#pragma mark --------给ScrollView添加图片
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWideth, 186)];
    //控制滑动属性
    scrollView.contentSize = CGSizeMake(self.adArray.count*kWideth, 186);
    
    for (int i = 0; i < self.adArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kWideth * i, 0, kWideth, 186)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.adArray[i]] placeholderImage:nil];
        [scrollView addSubview:imageView];
        
    }
    
    [self.tableView addSubview:scrollView];
    self.tableView.tableHeaderView = tableHeaderView;//tableView区头
#pragma mark -----添加六个按钮
    //按钮
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * kWideth / 4, 186, kWideth / 4, kWideth / 4);
        NSString *imageStr = [NSString stringWithFormat:@"home_icon_%d",i + 1];
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        button.tag = i + 1;
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [tableHeaderView addSubview:button];
    }
    //精选
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * kWideth / 2 , 260 , kWideth / 2, kWideth / 4);
        NSString *imageStr = [NSString stringWithFormat:@"home_%d",i + 1];
        [button setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
        button.tag = 101 + i;
        [button addTarget:self action:@selector(actionButton:) forControlEvents:UIControlEventTouchUpInside];
        [tableHeaderView addSubview:button];
    }


}



#pragma mark ------- UITableViewDataSource实现代理方法
//行

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.activityArray.count;
    }
    return  self.specialArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MainTableViewCell *maincell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

    NSMutableArray *array = self.listArray[indexPath.section];
    maincell.mainmodel = array[indexPath.row];

        
    return maincell;

}


#pragma mark ------- UITableViewDelegate
//分区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.listArray.count;


}

#pragma mark -----每行高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 26;

}

//自定义分区头部

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    
    UIImageView *sectionView = [[UIImageView alloc]init];
    sectionView.frame = CGRectMake(kWideth/2 - 160, 5,320, 16);
    
    if (section == 0) {
        
        sectionView.image = [UIImage imageNamed:@"home_recommed_ac"];
        
    }else{
        
        sectionView.image = [UIImage imageNamed:@"home_recommd_rc"];
        
    }
    [view addSubview:sectionView];
    
    return view;
    
}
#pragma mark ---- 点击图片按钮
-(void)actionButton:(UIButton *)btn{
    if (btn.tag == 1) {
        
    }else if (btn.tag == 2){
        
    }else if (btn.tag == 3){
        
    }else if (btn.tag == 4){
        
    }else if (btn.tag == 101){
        
    }else if (btn.tag == 102){
        
    }
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


////按钮
//    for (int i = 0; i < 4; i ++) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(bounds.size.width/4, 186, [UIScreen mainScreen].bounds.size.width/4, [UIScreen mainScreen].bounds.size.width/4);
//        
//        NSString *imagestr = [NSString stringWithFormat:@"home_icon_2%d",i+1];
//        [btn setImage:imagestr forState:UIControlStateNormal];
//        
//        btn.tag = 100 + i;
//        [btn addTarget:self action:@selector(ffm) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:btn];
//    }


}




#pragma mark ------网络请求解析 获得数据
- (void)requestModel{
    NSString *str = @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1";
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [sessionManager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);//json数据
        
#pragma mark -----获取数据传值到model里面
        NSDictionary *resultDic = responseObject;
        NSString *status = resultDic[@"status"];
        NSInteger code = [resultDic[@"code"]integerValue];
        
        if ([status isEqualToString:@"success"] && code == 0) {
            
            NSDictionary *dic = resultDic[@"success"];
            //推荐活动
            NSArray *acDataArray = dic[@"acData"];
            for (NSDictionary *dic in acDataArray) {
                MainModel *mainModel = [[MainModel alloc]initWithDictionary:dic];
                [self.activityArray addObject:mainModel];
            }
            [self.listArray addObject:self.activityArray];
            
            //推荐专题
            NSArray *rcDataArray = dic[@"rcData"];
            for (NSDictionary *rc in rcDataArray) {
                MainModel *model = [[MainModel alloc]initWithDictionary:rc];
                [self.specialArray addObject:model];
                
            }
            [self.listArray addObject:self.specialArray];
            //刷新数据
            [self.tableView reloadData];
            
            //广告
            NSArray *adDataArray = dic[@"adData"];
            for (NSDictionary *dic in adDataArray) {
                [self.adArray addObject:dic[@"url"]];
            }
            //刷新数据 重新加载该方法configTableView
            [self configTableView];
            
            //请求城市
            NSString *cityname = dic[@"cityname"];
            self.navigationItem.leftBarButtonItem.title = cityname;
            
        }else{
            
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
}

#pragma mark -----懒加载listArray   activityArray  specialArray

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
    if (_specialArray == nil) {
        self.specialArray = [NSMutableArray new];
    }
    
    return _specialArray;
    
}

- (NSMutableArray *)adArray{
    if (_adArray == nil) {
        self.adArray = [NSMutableArray new];
    }
    return _adArray;
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
