//
//  MineViewController.m
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "MineViewController.h"
#import "LoginViewController.h"
#import "HelpCenterController.h"
#import "MineHeaderView.h"
#import "MineTableViewCell.h"
#import "SettingViewController.h"
#import "NewsViewController.h"
#import "FeedBackController.h"


@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UILabel *_navTitleLable;
}
@property (nonatomic, strong) UIImageView *bgImgView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) MineHeaderView *headerView;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) NSArray *titleArray;


@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iconArray  = @[@"wd_help_icon", @"wd_kefu_icon", @"wd_feedBack_icon"];
    self.titleArray = @[@"帮助中心", @"联系客服", @"立即反馈"];
    [self setUpNavView];
    [self setUpUI];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.myTableView];
    BlackStatusBar;
}

- (void)setUpNavView {
    
    [self initNavView];
    self.navView.backgroundColor=[[UIColor whiteColor]colorWithAlphaComponent:0];
    self.lineView.hidden = YES;
    _navTitleLable = [UILabel new];
    _navTitleLable.textAlignment = NSTextAlignmentCenter;
    _navTitleLable.text = @" ";
    _navTitleLable.textColor  = [UIColor colorWithHexString:@"#000000"];
    _navTitleLable.font = [UIFont boldSystemFontOfSize:18.0];
    [self.navView addSubview:_navTitleLable];
    [_navTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    UIBarButtonItem *setItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"wd_tool_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(setClicked:)];
    
    
    UIBarButtonItem *newsItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"wd_news_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(newsClicked:)];
    self.navigationItem.rightBarButtonItems = @[newsItem, setItem];
    
}

-(void)setUpUI
{
   
    [self.view addSubview:self.myTableView];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    [self.view insertSubview:self.bgImgView atIndex:0];
    [self.myTableView registerClass:[MineTableViewCell class] forCellReuseIdentifier:NSStringFromClass([MineTableViewCell class])];
    self.myTableView.tableHeaderView = self.headerView;
    UIView *footView = [UIView new];
    self.myTableView.tableFooterView = footView;
}

#pragma mark UITableViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.iconArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MineTableViewCell class]) forIndexPath:indexPath];
    cell.clipsToBounds = YES;
    cell.img.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    cell.textLbl.text = [NSString stringWithFormat:@"%@", self.titleArray[indexPath.row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        HelpCenterController *helpVc = [[HelpCenterController alloc]init];
        [self.navigationController pushViewController:helpVc animated:YES];
        
    }else if (indexPath.row == 1) {
        
        
    }else if (indexPath.row == 2) {
        
        FeedBackController *feeedBackVc = [[FeedBackController alloc]init];
        [self.navigationController pushViewController:feeedBackVc animated:YES];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return px_scale(109);
}

#pragma mark - ScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetY = scrollView.contentOffset.y;
    CGFloat alpha =  offSetY/(px_scale(400) - CGRectGetHeight(self.navView.frame));
    alpha = MAX(alpha, 0);
    alpha = MIN(alpha, 1);
    if (alpha >=0.5) {
        _navTitleLable.text = @"我的";
        BlackStatusBar;
    }else{
        _navTitleLable.text = @"";
        LightStatusBar;
    }
    self.navView.backgroundColor = [[UIColor colorWithHexString:@"#ffffff"]colorWithAlphaComponent:alpha];
}

#pragma mark - private Method

- (void)setClicked:(UIButton *)sender {
    SettingViewController *settingVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)newsClicked:(UIButton *)sender {
    NewsViewController *newsVC = [[NewsViewController alloc]init];
    [self.navigationController pushViewController:newsVC animated:YES];
}

- (void)login{
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    UINavigationController *loginNav = [[NSClassFromString(@"VoteNavigationController") alloc]initWithRootViewController:loginVC];
    [self presentViewController:loginNav animated:YES completion:nil];
}

#pragma mark - getter
-(UITableView *)myTableView {
    if (!_myTableView)  {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor clearColor];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
    }
    return _myTableView;
}

- (UIImageView *)bgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc]init];
        _bgImgView.image = [UIImage imageNamed:@"wd_bg_img"];
        _bgImgView.frame  = CGRectMake(0, 0, MAINScreenWidth, 1334/2 * scaleX);
    }
    return _bgImgView;
}

- (MineHeaderView *)headerView {
    if (!_headerView) {
		CGFloat headerHeight = NavBarHeight + (px_scale(551) - 64);
        _headerView = [[MineHeaderView alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth, headerHeight)];
        _headerView.islogin = IS_LOGIN;// 切换登录与未登录时的界面
        __weak MineViewController *weakSelf = self;
        _headerView.clickLoginBlock = ^{
            [weakSelf login];
        };
    }
    return _headerView;
}

@end
