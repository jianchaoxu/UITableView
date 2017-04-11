//
//  ViewController.m
//  MyTableView
//
//  Created by 易骏 on 17/4/10.
//  Copyright © 2017年 xjc. All rights reserved.
//

#import "ViewController.h"
#import "SetupCell.h"
#import "AlertSetupCell.h"
#define CellHeight 50
#define DEVICE_WIDTH  [UIScreen mainScreen].bounds.size.width
#define  Color(r, g, b )     [UIColor colorWithRed:r/255.0 green:g/255.0f blue:b/255.0f alpha:1.0f]
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *settingTableview;
    NSMutableArray *datasource;
    NSMutableArray *sectionArray;
    NSMutableArray *stateArray;
}
@property(nonatomic,strong)NSIndexPath *lastPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"haha";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initalizeDataSourace];
    [self createTable];
}


-(void)initalizeDataSourace
{
    sectionArray  = [NSMutableArray arrayWithObjects:@"个人",@"衣服",@"设置",@"连接",@"电池",@"通用",@"版本", nil];
    NSArray *bb = @[@"姓名",@"年龄",@"生日",@"性别"];
    NSArray *dd = @[@"一般",@"好的"];
    NSArray *aa = @[@"闹铃模式",@"震动模式",@"防扰模式",@"系统开关",@"飞行模式"];
    NSArray *cc = @[];
    NSArray *mm = @[];
    NSArray *ee = @[];
    NSArray *vv = @[];
    datasource  = [NSMutableArray arrayWithObjects:bb,dd,aa,cc,mm,ee,vv, nil];
    stateArray  = [NSMutableArray array];
    for (int i = 0; i<datasource.count; i++) {
        [stateArray addObject:@"0"];
    }
}

-(void)createTable
{
    settingTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    settingTableview.dataSource = self;
    settingTableview.delegate   = self;
    settingTableview.tableFooterView = [UIView new];
    [self.view addSubview:settingTableview];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return datasource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([stateArray[section] isEqualToString:@"1"]) {
        NSArray *arr = datasource[section];
        return arr.count;
    } else
        return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellId = @"cell";
        SetupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[SetupCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
        }
        cell.kindLabel.text = datasource[indexPath.section][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        return cell;
    } else if (indexPath.section == 1) {
        static NSString *cellidentifier = @"diapercell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier];
        }
        cell.textLabel.text = datasource[indexPath.section][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        NSInteger row = [indexPath row];
        NSInteger oldRow = [self.lastPath row];
        if (row == oldRow && self.lastPath!=nil)
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        return cell;
    } else if (indexPath.section == 2) {
        static NSString *CellIdentifier = @"UITableViewCell";
        AlertSetupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[AlertSetupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.alertLabel.text = datasource[indexPath.section][indexPath.row];
        cell.alertSwitch.tag = 100 + indexPath.row;
        [cell.alertSwitch addTarget:self action:@selector(msgalertSetting:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }
    return nil;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sectionArray[section];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [button setTag:section+1];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsZero];
    [button addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(0, button.frame.size.height-1, button.frame.size.width, 1)];
    [line setImage:[UIImage imageNamed:@"line_real"]];
    [button addSubview:line];
    
    UIImageView *_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width-30, 22, 10, 6)];
    if (section<3) {

    if ([stateArray[section] isEqualToString:@"0"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listdown"];
    }else if ([stateArray[section] isEqualToString:@"1"]) {
        _imgView.image = [UIImage imageNamed:@"ico_listup"];
    }
    [button addSubview:_imgView];
    }
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 10, 200, 30)];
    [tlabel setBackgroundColor:[UIColor clearColor]];
    [tlabel setFont:[UIFont systemFontOfSize:16]];
    [tlabel setText:sectionArray[section]];
    [button addSubview:tlabel];
    [self sectionViewContentWithsection:section superview:button];
    return button;
}
#pragma mark
#pragma mark  -select cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self didSelectTableviewRow:indexPath withTableView:tableView];
}


-(void)didSelectTableviewRow:(NSIndexPath *)indexpath withTableView:(UITableView *)tableview
{
    switch (indexpath.section) {
        case 0: //
            
            break;
        case 1: {
            NSInteger newRow = indexpath.row;
            NSInteger oldRow = (self .lastPath !=nil)?[self .lastPath row]:-1;
            if (newRow != oldRow) {
                UITableViewCell *newCell = [tableview cellForRowAtIndexPath:indexpath];
                newCell.accessoryType = UITableViewCellAccessoryCheckmark;
                UITableViewCell *oldCell = [tableview cellForRowAtIndexPath:self.lastPath];
                oldCell.accessoryType = UITableViewCellAccessoryNone;
                self .lastPath = indexpath;
            }
            NSLog(@"第二项单选的内容 = %ld",indexpath.row);
        }
            break;
        default:
            break;
    }
    
}



- (void)buttonPress:(UIButton *)sender//headButton点击
{
    //判断状态值
    if ([stateArray[sender.tag - 1] isEqualToString:@"1"]){
    //修改
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"0"];
    }else{
        [stateArray replaceObjectAtIndex:sender.tag - 1 withObject:@"1"];
    }
    [settingTableview reloadSections:[NSIndexSet indexSetWithIndex:sender.tag-1] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CellHeight;
}

#pragma mark ----uiswich value change
-(void)msgalertSetting:(UISwitch *)alertsetting
{
    switch (alertsetting.tag) {
        case 100: //开关1
            NSLog(@"开关1");
            break;
        case 101: //开关2
            NSLog(@"开关2");
            break;
        case 102: //开关3
            NSLog(@"开关3");
            break;
        case 103: //开关4
            NSLog(@"开关4");
            break;
        case 104: //开关5
            NSLog(@"开关5");
            break;
        default:
            break;
    }
}

-(void)sectionViewContentWithsection:(NSInteger)section superview:(UIButton *)spv
{
    switch (section) {
        case 3:{
            ZJSwitch *loseSwitch = [[ZJSwitch alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-70, 10, 55, 30)];
            loseSwitch.tintColor = [UIColor lightGrayColor];
            loseSwitch.onTintColor = [UIColor cyanColor];
            loseSwitch.onText = @"ON";
            loseSwitch.offText = @"OFF";
            loseSwitch.textFont = [UIFont systemFontOfSize:14.0];
            loseSwitch.on = NO;
            [loseSwitch addTarget:self action:@selector(authConnect:) forControlEvents:UIControlEventValueChanged];
            [spv addSubview:loseSwitch];
        }
            break;
        case 4:
            [self addLableWithFrame:CGRectMake(DEVICE_WIDTH-145, 10, 130, 30) withText:@"100%" superView:spv];
            break;
        case 5: {
            [self addLableWithFrame:CGRectMake(DEVICE_WIDTH-95, 10, 80, 30) withText:@"123" superView:spv];
        }
            break;
        case 6:{
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            CFShow((__bridge CFTypeRef)(infoDictionary));
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            [self addLableWithFrame:CGRectMake(DEVICE_WIDTH-95, 10, 80, 30) withText:app_Version superView:spv];
        }
            break;
        default:
            break;
    }

}

-(void)authConnect:(UISwitch *)sender
{
    
}


-(void)addLableWithFrame:(CGRect)frame withText:(NSString *)labeltext superView:(UIView *)supview
{
    UILabel *ll = [[UILabel alloc]initWithFrame:frame];
    ll.text = labeltext;
    ll.textAlignment = NSTextAlignmentRight;
    ll.textColor = [UIColor grayColor];
    ll.font = [UIFont systemFontOfSize:12];
    [supview addSubview:ll];
}
@end
