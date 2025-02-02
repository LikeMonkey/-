//
//  GiftOrderPayResultViewController.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "GiftOrderPayResultViewController.h"
#import "GiftOrderPayResultInfoCell.h"
#import "VoteBrandDetailViewController.h"
@interface GiftOrderPayResultViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 列表 */
@property (nonatomic,strong) UITableView *tableView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/** info */
@property (nonatomic,strong) NSMutableArray *infoDataArr;
/** 支付金额 */
@property (nonatomic,strong) UILabel *payNum;

@end

@implementation GiftOrderPayResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"订单结果";
    [self initNavView];
    [self initBackNavItem];
    [self initData];
    self.resultState = payResultSuccess;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    BlackStatusBar;
}
-(void)initData{
    self.dataArr = @[@"耐克",@"20190916534127265",@"微信",@"20190916534127265"].mutableCopy;
    self.infoDataArr = @[@"品牌名称:",@"订单号:",@"支付方式:",@"支付账号:"].mutableCopy;
}
-(void)initBackNavItem {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
    self.navigationItem.leftBarButtonItem = backItem;
    
}

#pragma mark - tableView


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.infoDataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GiftOrderPayResultInfoCell *cell=[GiftOrderPayResultInfoCell cellWithTableView:tableView withIdentifier:NSStringFromClass([GiftOrderPayResultInfoCell class]) indexPath:indexPath];
    cell.infoLabel.text = self.infoDataArr[indexPath.row];
    cell.contentLabel.text = self.dataArr[indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *payResultImage = [[UIImageView alloc]init];
    UILabel *payResultLabel = [[UILabel alloc]init];
    payResultLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:payResultImage];
    [view addSubview:payResultLabel];
    [view addSubview:self.payNum];
    [payResultImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_offset(px_scale(160));
    }];
    [payResultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(payResultImage.mas_bottom).mas_offset(px_scale(33));
    }];
    [self.payNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view);
        make.top.mas_equalTo(payResultLabel.mas_bottom).mas_offset(px_scale(10));
    }];
    
    [payResultLabel setFont:[UIFont boldSystemFontOfSize:17]];
    [payResultLabel setTextColor:[UIColor colorWithHexString:@"#333333"]];
    switch (self.resultState) {
        case payResultSuccess:
            [payResultImage setImage:[UIImage imageNamed:@"gift_zfjg_cgdd_icon"]];
            [payResultLabel setText:@"恭喜您, 支付成功"];
            self.payNum.text = [NSString stringWithFormat:@"¥%@",@"180.00"];
            break;
        case payResultfailer:
            [payResultImage setImage:[UIImage imageNamed:@"gift_zfjg_sbdd_icon"]];
            [payResultLabel setText:@"支付失败"];
            self.payNum.text = @"支付平台返回失败原因:余额不足...";
            self.payNum.textColor = [UIColor colorWithHexString:@"#999999"];
            self.payNum.font = [UIFont systemFontOfSize:12];
            break;
        default:
            break;
    }
    
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UIButton *Btn  = [UIButton buttonWithType:UIButtonTypeCustom];
    Btn.layer.cornerRadius = px_scale(44);
    Btn.layer.masksToBounds = YES;
    [Btn.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
    [view addSubview:Btn];
    [Btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(px_scale(124));
        make.left.mas_offset(px_scale(99));
        make.right.mas_offset(-px_scale(99));
        make.height.mas_equalTo(px_scale(88));
    }];
    switch (self.resultState) {
        case payResultSuccess:
            [Btn setTitle:@"完成" forState:UIControlStateNormal];
            [Btn setBackgroundColor:[UIColor colorWithHexString:@"#D3141C"]];
            [Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            break;
        case payResultfailer:
            [Btn setTitle:@"返回" forState:UIControlStateNormal];
            [Btn setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
            [Btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return px_scale(600);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return px_scale(300);
}
#pragma mark ——— method
-(void)backClicked:(UIButton *)sender{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[VoteBrandDetailViewController class]]) {
            //跳转到品牌详情
            VoteBrandDetailViewController *vc =(VoteBrandDetailViewController *)controller;
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}
-(void)BtnClick:(UIButton *)sender{
    [self backClicked:sender];
}
#pragma mark - Setter & Getter
-(UITableView *)tableView {
    
    if(!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[GiftOrderPayResultInfoCell class] forCellReuseIdentifier:NSStringFromClass([GiftOrderPayResultInfoCell class])];
        _tableView.rowHeight = px_scale(50);
        _tableView.scrollEnabled = NO;
        
    }
    return _tableView;
}

- (UILabel *)payNum {
    if (!_payNum) {
        _payNum = [[UILabel alloc]init];
        [_payNum setFont:[UIFont boldSystemFontOfSize:30]];
        _payNum.textColor = [UIColor colorWithHexString:@"#D3141C"];
    }
    return _payNum;
}
@end
