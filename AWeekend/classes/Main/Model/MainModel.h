//
//  MainModel.h
//  AWeekend
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@interface MainModel : NSObject

@property(nonatomic,retain) NSString *address;//地址
@property(nonatomic,retain) NSString *image_big;//图片
@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *price;
@property(nonatomic,assign) CGFloat  lat;//维度
@property(nonatomic,assign) CGFloat  lng;//经度

@property(nonatomic,retain) NSString *counts;
@property(nonatomic,retain) NSString *startTime;
@property(nonatomic,retain) NSString *endTime;
@property(nonatomic,retain) NSString *activityId;
@property(nonatomic,retain) NSString *type;

@property(nonatomic,retain) NSString *activityDescription;



//定义一个公开的方法把外部的字典传进来进行转化加工（字典转化成model）
- (instancetype)initWithDictionary:(NSDictionary *)dict;


@end
