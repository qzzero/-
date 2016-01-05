//
//  MainModel.h
//  AWeekend
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {

    RecommendTypeActivity = 1,//推荐活动
    RecommendTypeTheme//推荐专题


}RecommendType;


@interface MainModel : NSObject

//首页大图
@property(nonatomic, copy)NSString *image_big;
//标题
@property(nonatomic, copy)NSString *title;
//价格
@property(nonatomic, copy)NSString *price;

//经纬度
@property(nonatomic, assign)CGFloat lat;
@property(nonatomic, assign)CGFloat lng;

@property(nonatomic, copy)NSString *address;
@property(nonatomic, copy)NSString *counts;
@property(nonatomic, copy)NSString *startTime;
@property(nonatomic, copy)NSString *endTime;
@property(nonatomic, copy)NSString *type;

@property(nonatomic, copy)NSString *activityId;

@property(nonatomic, copy)NSString *activityDescription;

//定义一个公开的方法把外部的字典传进来进行转化加工（字典转化成model）
- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
