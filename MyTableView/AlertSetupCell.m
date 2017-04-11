//
//  AlertSetupCell.m
//  AbellStar_Light
//
//  Created by 易骏 on 17/4/10.
//  Copyright © 2017年 xjc. All rights reserved.
//

#import "AlertSetupCell.h"
#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width

@implementation AlertSetupCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

-(void)createUI
{
    [self addSubview:self.alertLabel];
    [self addSubview:self.alertSwitch];
}

-(UILabel *)alertLabel
{
    if (!_alertLabel) {
        self.alertLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, 200, 30)];
        self.alertLabel.backgroundColor = [UIColor clearColor];
        self.alertLabel.font = [UIFont systemFontOfSize:14];
    }
    return _alertLabel;
}

-(ZJSwitch *)alertSwitch
{
    if (!_alertSwitch) {
        self.alertSwitch = [[ZJSwitch alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-70, 10, 55, 30)];
        self.alertSwitch.tintColor = [UIColor lightGrayColor];
        self.alertSwitch.onTintColor = [UIColor cyanColor];
        self.alertSwitch.onText = @"ON";
        self.alertSwitch.offText = @"OFF";
        self.alertSwitch.textFont = [UIFont systemFontOfSize:14.0];
        self.alertSwitch.on = NO;
    }
    return _alertSwitch;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
