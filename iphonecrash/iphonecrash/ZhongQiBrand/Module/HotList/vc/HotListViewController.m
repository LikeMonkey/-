//
//  HotListViewController.m
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "HotListViewController.h"
#import "HotListTableViewCell.h"
#import "HostListDetailController.h"
#import "HotListResponse.h"

@interface HotListViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HotListViewController
-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    [self.myTableView setContentOffset:CGPointZero animated:YES];
	BlackStatusBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavView];
    [self initSearchItem];
    self.navigationItem.title = @"热门榜单";
    [self setUpUI];
	self.view.lgPlaceholder.state = LgPlaceLoadingState;
	__weak typeof(self)ws = self;
	[self.view.lgPlaceholder setActionBlock:^(LgPlaceholderState state) {

	}];
}
-(void)setUpUI
{
    [self.view addSubview:self.myTableView];
    [self.myTableView registerClass:[HotListTableViewCell class] forCellReuseIdentifier:@"HotListTableViewCell"];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    
    UIView *tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth, px_scale(350))];
    self.myTableView.tableHeaderView = tableHeaderView;
    tableHeaderView.backgroundColor  = [UIColor whiteColor];
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(px_scale(30), px_scale(30), MAINScreenWidth-px_scale(60), px_scale(320)) delegate:self placeholderImage:[UIImage imageNamed:@"ppsj_banner_img"]];
    cycleScrollView.localizationImageNamesGroup = @[@"ppsj_banner_img"];
    [tableHeaderView addSubview:cycleScrollView];
    self.myTableView.tableHeaderView = tableHeaderView;
	MJHeader *header = [MJHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
	self.myTableView.mj_header = header;
	[header beginRefreshing];
}

-(void)pullDownRefresh
{
	[self requestData];
}

-(void)requestData
{
	TokenModel *token = [TokenModel new];
	token.method = @"home";
	NSMutableDictionary *parm = [token.dictionary mutableCopy];
	parm[@"action"] = @"hotlist";
	[RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, Brand_listTable_prefix)
					   andParms:parm
				  andCompletion:^(id obj) {
					  NSLog(@"输出结果：|%@",obj);
					  HotListResponse *response = [[HotListResponse alloc]initWithDictionary:obj];
					  if ([response.status isEqualToString:@"1"]) {
						  [self.dataSource removeAllObjects];//测试先清理
						  [self.dataSource addObjectsFromArray:response.data];
					  }else{
						  SHOW_MSG(response.msg, 0.5);
					  }
					  if (ArrayIsEmpty(self.dataSource)) {
						  self.view.lgPlaceholder.state = LgPlaceNoDataState;
					  }else{
						  self.view.lgPlaceholder.state = LgPlaceNormalState;
					  }
					  [self.myTableView reloadData];
					  [self.myTableView.mj_header endRefreshing];
				  } Error:^(NSError *errror) {
					   [self.myTableView.mj_header endRefreshing];
				  }];
}

-(void)initSearchItem
{
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"rmbd_sstb_icon"]imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)] style:(UIBarButtonItemStylePlain) target:self action:@selector(searchClicked:)];
    self.navigationItem.rightBarButtonItem = searchItem;
}
-(void)searchClicked:(id)sender
{
    UIViewController *searchVc = [[NSClassFromString(@"HotListSearchViewController") alloc]init];
    [self.navigationController pushViewController:searchVc animated:NO];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"HotListTableViewCell" forIndexPath:indexPath];
	if (indexPath.row<self.dataSource.count) {
		[cell setValue:self.dataSource[indexPath.row] forKey:@"model"];
	}
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HostListDetailController *detailVC = [[HostListDetailController alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return px_scale(212);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark - getter
-(UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _myTableView.platformView.title = @"————  我们是有底线的  ————";
        _myTableView.platformView.textColor = [UIColor colorWithHexString:@"#999999"];
        _myTableView.platformView.textFont = [UIFont systemFontOfSize:12];
        _myTableView.platformView.isNotBottom = YES;
    }
    return _myTableView;
}
-(NSMutableArray *)dataSource
{
	if (!_dataSource) {
		_dataSource = [[NSMutableArray alloc]init];
	 }
	return _dataSource;
}



@end

