//
//  SetupCell.m
//  MyTableView
//
//  Created by 易骏 on 17/4/10.
//  Copyright © 2017年 xjc. All rights reserved.
//

#import "SetupCell.h"

@implementation SetupCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.kindLabel];
        [self addSubview:self.valueLabel];
    }
    return self;
}

-(UILabel *)kindLabel
{
    if (!_kindLabel) {
        self.kindLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 7, 200, 30)];
        self.kindLabel.font = [UIFont systemFontOfSize:14];
    }
    return _kindLabel;
}

-(UILabel *)valueLabel
{
    if (!_valueLabel) {
        self.valueLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-95, 7, 80, 30)];
        self.valueLabel.font = [UIFont systemFontOfSize:14];
    }
    return _valueLabel;
}


@end
