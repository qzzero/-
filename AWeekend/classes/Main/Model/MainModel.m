//
//  MainModel.m
//  AWeekend
//
//  Created by scjy on 16/1/5.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "MainModel.h"

@implementation MainModel

- (instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        self.type = dict[@"type"];
        if ([self.type integerValue] == RecommendTypeActivity) {
            //如果是推荐活动
            self.price = dict[@"price"];
            self.endTime = dict[@"endTime"];
            self.lat = [dict[@"lat"] floatValue];
            self.lng = [dict[@"lng"] floatValue];
            self.counts = dict[@"counts"];
            self.address = dict[@"address"];
            self.startTime = dict[@"startTime"];
            
        }else{
         //如果是推荐专题
            self.activityDescription = dict[@"activityDescription"];
        }
        
        self.activityId = dict[@"id"];
        self.image_big = dict[@"image_big"];
        self.title = dict[@"title"];
        
    }


    return self;

}




@end
