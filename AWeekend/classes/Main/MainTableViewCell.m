//
//  MainTableViewCell.m
//  AWeekend
//
//  Created by scjy on 16/1/4.
//  Copyright © 2016年 qzp. All rights reserved.
//

#import "MainTableViewCell.h"


@interface MainTableViewCell ()
//活动图片
@property (weak, nonatomic) IBOutlet UIImageView *Activityimage;
//活动价格
@property (weak, nonatomic) IBOutlet UILabel *ActivityLable;
//活动距离
@property (weak, nonatomic) IBOutlet UIButton *ActivityButton;
//活动名字



@end




@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
   
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
