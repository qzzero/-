//
//  AppDelegate.m
//  AWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "DiscoverViewController.h"
#import "MyViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    //UITabBarController
    
    UITabBarController *tabBarvc = [[UITabBarController alloc] init];
    //创建被tabBarvc管理的视图控制器
    
    //主页
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mainnav = mainStoryboard.instantiateInitialViewController;
    mainnav.tabBarItem.image = [UIImage imageNamed:@"ft_home_normal_ic"];
    mainnav.tabBarItem.selectedImage = [UIImage imageNamed:@"ft_home_selected_ic"];
    
    //调整tabBar位置，按照上左下右的顺序
    mainnav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    /*
    UIImage *mainselectimage = [UIImage imageNamed:@"ft_home_selected_ic"];
    //tabbar设置选中图片按照图片原始状态显示
    mainnav.tabBarItem.selectedImage = [mainselectimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    下同，这个是在StoryBoars里设置过，所以将代码注销
    */
    
    
    //发现
    UIStoryboard *DisStoryboard = [UIStoryboard storyboardWithName:@"Discover" bundle:nil];
    UINavigationController *Disnav = DisStoryboard.instantiateInitialViewController;
    Disnav.tabBarItem.image = [UIImage imageNamed:@"ft_found_normal_ic"];
    Disnav.tabBarItem.selectedImage = [UIImage imageNamed:@"ft_found_selected_ic"];
    
    //调整tabBar位置，按照上左下右的顺序
    mainnav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    //我的
    UIStoryboard *MyStoryboard = [UIStoryboard storyboardWithName:@"My" bundle:nil];
    UINavigationController *Mynav = MyStoryboard.instantiateInitialViewController;
    Mynav.tabBarItem.image = [UIImage imageNamed:@"ft_person_normal_ic"];
    Mynav.tabBarItem.selectedImage = [UIImage imageNamed:@"ft_person_selected_ic"];
    
    //调整tabBar位置，按照上左下右的顺序
    mainnav.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    
    //添加被管理的试图控制器
    tabBarvc.viewControllers = @[mainnav,Disnav,Mynav];
    tabBarvc.tabBar.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = tabBarvc;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
