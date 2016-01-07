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
#import "SeleCityViewController.h"
#import "SearchViewController.h"
#import "ActivityXiangQingViewController.h"
#import "ActivityZhuanTiViewController.h"
#import "ClassifyViewController.h"
#import "GoodViewController.h"
#import "HotActivityViewController.h"
#import "ActivityDetaViewController.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIPageViewControllerDelegate,UIPageViewControllerDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong) NSMutableArray *listArray;//全部列表数据
//推荐活动数组
@property(nonatomic,strong) NSMutableArray *activityArray;//全部列表数据
//推荐专题数组
@property(nonatomic,strong) NSMutableArray *specialArray;//全部列表数据
//广告
@property(nonatomic,strong) NSMutableArray *adArray;

@property(nonatomic,strong) UIScrollView *scarouselView;

@property(nonatomic,strong) UIPageControl *pageControl;

//定时器，用于图片滚动播放
@property(nonatomic,strong) NSTimer *timer;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.title = @"切换城市";
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    // Do any additional setup after loading the view.
    //导航栏上按钮和文字颜色
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //导航栏颜色
    //  self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:27/255.0f green:185/255.0f blue:189/255.0f alpha:1.0];
    
    //导航栏上navigationItem
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightBarAction)];
    //1.设置导航栏上的左右按钮  把leftBarButton设置为navigationItem左按钮
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    //左按钮
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithTitle:@"北京≡" style:UIBarButtonItemStylePlain target:self action:@selector(selectCityAction:)];
    
    self.navigationItem.leftBarButtonItem = leftBarButton;
    //设置按钮的透明度
    // self.automaticallyAdjustsScrollViewInsets = NO;
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:@"MainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //自定义头部cell
    [self configTableView];
    
    //请求网络数据
    [self requestModel];
    
    
    //启动定时器
    [self starttimer];
    
    
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
    
    //添加轮播图
    self.scarouselView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWideth, 186)];
    //整屏滑动
    
    
    //不显示水平方向滚动条
    
    
    
   //添加代理
    
    
    
    
    //小圆点
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 186-30, kWideth, 30)];
    self.pageControl.numberOfPages = self.adArray.count;
    self.pageControl.currentPageIndicatorTintColor = [UIColor cyanColor];
    
    
    
    [tableHeaderView addSubview:self.pageControl];
    
    
   
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







#pragma marks 实现代理方法
//行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.activityArray.count;
    }
    return  self.specialArray.count;
}
//分区
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.listArray.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MainTableViewCell *mainCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSMutableArray *array = self.listArray[indexPath.section];
    mainCell.mainmodel = array[indexPath.row];
    
    return mainCell;
}
#pragma mark -----每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 203;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath == 0) {
        ActivityXiangQingViewController *acticityxqvc = [[ActivityXiangQingViewController alloc] init];
        [self.navigationController pushViewController:acticityxqvc animated:YES];
    }else{
    
        ActivityZhuanTiViewController *acticityztvc = [[ActivityZhuanTiViewController alloc] init];
        [self.navigationController pushViewController:acticityztvc animated:YES];
    
    }

    
    
}

//点击广告

- (void)touchAdvertisment:(UIButton *)adButton{
//从数组中的字典里取出type类型
    NSString *type = self.adArray[adButton.tag - 100][@"type"];
    
    if ([type integerValue] == 1) {
        
    }
    
    
    
    //活动id
    
    


}

#pragma --------- 首页轮播图

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    //第一步：获取scarouselView页面宽度
    CGFloat pageWidth = self.scarouselView.frame.size.width;
    
    //第二步：获取scarouselView停止时的偏移量
    //contentOffset是当前scrollView距离原点偏移的位置
    CGPoint offset = self.scarouselView.contentOffset;
    
    //第三步：通过偏移量和页面宽度计算当前页数
    NSInteger pagenumber = offset.x / pageWidth;
    self.pageControl.currentPage = pagenumber ;
    
}

//少写个方法






//左按钮选择城市
-(void)selectCityAction:(UIBarButtonItem *)bar{
    
    SeleCityViewController *selectCityVC = [[SeleCityViewController alloc]init];
    
    [self.navigationController presentViewController:selectCityVC animated:YES completion:nil];
    
    
    
}
//右按钮查找
- (void)rightBarAction{
    
    
    SearchViewController *searchvc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:searchvc animated:YES];
    
}
#pragma mark ------网络请求解析 获得数据
-(void)requestModel{
    NSString *str = @"http://e.kumi.cn/app/v1.3/index.php?_s_=02a411494fa910f5177d82a6b0a63788&_t_=1451307342&channelid=appstore&cityid=1&lat=34.62172291944134&limit=30&lng=112.4149512442411&page=1";
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    
    [sessionManager GET:str parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        QZPLog(@"%@",downloadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        QZPLog(@"%@",responseObject);//json数据
        
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
        QZPLog(@"%@",error);
    }];
    
    
}
#pragma mark -----分区标题高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 26;
}
#pragma mark ------自定义分区头部view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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

#pragma mark -----懒加载listArray   activityArray  specialArray
-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        self.listArray = [NSMutableArray new];
    }
    return _listArray;
}
-(NSMutableArray *)activityArray{
    if (_activityArray == nil) {
        self.activityArray = [NSMutableArray new];
    }
    return _activityArray;
}

-(NSMutableArray *)specialArray{
    if (_specialArray == nil) {
        self.specialArray = [NSMutableArray new];
    }
    return _specialArray;
}

-(NSMutableArray *)adArray{
    if (_adArray == nil) {
        self.adArray = [NSMutableArray new];
    }
    return _adArray;
}

//分类列表
- (void)ClassifyButton{
    ClassifyViewController *classifyvc = [[ClassifyViewController alloc] init];
    [self.navigationController pushViewController:classifyvc animated:YES];
    
}

//热门主题
- (void)HotActivityButton{
    HotActivityViewController *hotvc = [[HotActivityViewController alloc] init];
    [self.navigationController pushViewController:hotvc animated:YES];
}


//精选活动
- (void)goodActivityButton{
    GoodViewController *goodvc = [[GoodViewController alloc] init];
    [self.navigationController pushViewController:goodvc animated:YES];
}




//轮播图
- (void)starttimer {
    //if判断是防止定时器重复创建
    if (self.timer != nil) {
        return;
    }
   
    self.timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(rollAnimation) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}
//每两秒执行一次，图片自动轮播
- (void)rollAnimation{

    //把page当前页加一
    
    NSInteger page = self.pageControl.currentPage += 1;
    
    //计算出scrollView应该滚动的X轴坐标
    CGFloat offsetx = page * kWideth;
    [self.scarouselView setContentOffset:CGPointMake(offsetx, 0) animated:YES];
    
    //当手动去滑动scrollView的时候，定时器依然在计算时间，可能我们刚刚滑动到下一页，定时器时间又刚好触发，导致在当前页停留时间不足2秒
    //解决方案，在scrollView移动的时候结束定时器，移动停止后再启动定时器
    
    
    /*
     scrollView将要开始拖拽
     
     */
    
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{

//停止定时器
    [self.timer invalidate];

    self.timer = nil;//停止定时器后并置为  才能保证正常执行
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation the progrem ended with code exit
could not find the object
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 } */

@end
