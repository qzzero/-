//
//  MainTableViewCell.m
//  AWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "MainTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MainTableViewCell ()
//活动图片
@property (weak, nonatomic) IBOutlet UIImageView *Activityimage;
//活动价格
@property (weak, nonatomic) IBOutlet UILabel *ActivityLable;
//活动距离
@property (weak, nonatomic) IBOutlet UIButton *ActivityButton;
//活动名字
@property (weak, nonatomic) IBOutlet UILabel *ActivityName;



@end




@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
   
    
    
}
//在model的set方法中赋值
- (void)setMainmodel:(MainModel *)mainmodel{
    [self.Activityimage sd_setImageWithURL:[NSURL URLWithString:mainmodel.image_big]placeholderImage:nil];
    self.ActivityLable.text = mainmodel.title;
    self.ActivityName.text = mainmodel.price;


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
