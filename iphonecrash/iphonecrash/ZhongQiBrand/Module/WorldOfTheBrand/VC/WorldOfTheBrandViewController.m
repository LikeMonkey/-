//
//  WorldOfTheBrandViewController.m
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "WorldOfTheBrandViewController.h"
#import "WorldBrandTableViewCell.h"
#import "WorldOfTheBrandDetailController.h"
#import "WorldOfBrandListModel.h"

@interface WorldOfTheBrandViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *myTableView;
/** 列表数据源 */
@property (nonatomic,strong) WorldOfBrandListModel *listModel;
/** 分页 */
@property (nonatomic,assign) NSInteger nextPage;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation WorldOfTheBrandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self initNavView];
	self.lineView.hidden = YES;
	[self loadTopButton];
    self.navigationItem.title = @"品牌世界";
	[self setUpUI];
     self.nextPage = 0;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.myTableView setContentOffset:CGPointZero animated:YES];
    BlackStatusBar;
}
-(void)setUpUI
{
	[self.view addSubview:self.myTableView];
	self.myTableView.estimatedRowHeight = 44;
	[self.myTableView registerClass:[WorldBrandTableViewCell class] forCellReuseIdentifier:@"WorldBrandTableViewCell"];
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
    MJHeader *refreshHeader = [MJHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    self.myTableView.mj_header = refreshHeader;
    [self.myTableView.mj_header beginRefreshing];
    
   // foot 需要分页参数
     MJFooter *refreshfoot = [MJFooter footerWithRefreshingTarget:self refreshingAction:@selector(LoadMoreRefresh)];
     self.myTableView.mj_footer = refreshfoot;
      WS(ws);
    self.view.lgPlaceholder.state =  LgPlaceLoadingState ;
        [self.view.lgPlaceholder setActionBlock:^(LgPlaceholderState state) {
            if (!(state == LgPlaceLoadingState)) {
                ws.view.lgPlaceholder.state = LgPlaceLoadingState;
                [ws.myTableView.mj_header beginRefreshing];
            }
        }];
}


-(void)loadTopButton
{
	UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
	addButton.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
	addButton.imageEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
	addButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
	addButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
	[addButton setTitleColor:[UIColor colorWithHexString:@"#333333"] forState:UIControlStateNormal];
	[addButton setTitle:@"品牌视界" forState:UIControlStateNormal];
	[addButton setImage:[UIImage imageNamed:@"tjpp_btn_icon"] forState:UIControlStateNormal];
	addButton.layer.cornerRadius = 14;
	addButton.layer.masksToBounds = YES;
	addButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
	[self.navView addSubview:addButton];
	[addButton addTarget:self action:@selector(joinBrandWorldAction:) forControlEvents:UIControlEventTouchUpInside];
	[addButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(14);
		make.width.mas_equalTo(200/2+14);
		make.bottom.mas_equalTo(-8);
		make.height.mas_equalTo(28);
	}];
}

#pragma mark - request dataSource
-(void)requestFromServer
{
    TokenModel *token = [TokenModel new];
    token.method = @"home";//特殊参数
    token.auth = @"home";
    //  self.nextPage
    NSMutableDictionary *parm = [token.dictionary mutableCopy];
    WS(ws);
    [RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, Brand_world_prefix)
                       andParms:parm
                  andCompletion:^(id obj) {
      
        [self.myTableView.mj_footer endRefreshing];
        [self.myTableView.mj_header endRefreshing];
        NSLog(@"%@",obj);
       WorldOfBrandListModel *listModel = [[WorldOfBrandListModel alloc]initWithDictionary:obj];
                         if ([listModel.status isEqualToString:@"1"]) {
                             self.listModel = listModel;
                         }
         [ws requestResponse:listModel];
    } Error:^(NSError *errror) {
   
        SHOW_MSG(@"请重新尝试", 1)
        [self.myTableView.mj_footer endRefreshing];
        [self.myTableView.mj_header endRefreshing];
        NSLog(@"%@",errror);
    }];
}
-(void)requestResponse:(WorldOfBrandListModel *)listModle
{
    if ([listModle.status isEqualToString:@"1"]) {
        [self.dataArr removeAllObjects];//临时测试使用。。。
        [self.dataArr addObjectsFromArray:listModle.data];
    }else{
        SHOW_MSG(listModle.msg, 1);
    }
    if (ArrayIsEmpty(self.dataArr)) {
        self.view.lgPlaceholder.state =LgPlaceNoDataState;
    }else{
        self.view.lgPlaceholder.state = LgPlaceNormalState;
    }
    if(self.nextPage == 0){
        self.myTableView.mj_footer.hidden = YES;
		self.myTableView.platformView.hidden = NO;
	}else{
		self.myTableView.platformView.hidden = YES;
		self.myTableView.mj_footer.hidden = NO;
	}
    [self.myTableView reloadData];
}

#pragma mark - MJRefresh Target Method
-(void)pullDownRefresh {
    if ([Server netWorkAvailable]) {
         NSLog(@"网络连接成功");
        [self loadDataWithBool:YES];
     }else{
         [self.myTableView.mj_header endRefreshing];
        if (ArrayIsEmpty(self.dataArr)) {
           self.view.lgPlaceholder.state = LgPlaceNonetState;
        }else{
            SHOW_MSG(@"网络连接失败，请检查网络设置",1);
        }
     }
   
}
-(void)LoadMoreRefresh{
    if ([Server netWorkAvailable]) {
        NSLog(@"网络连接成功");
       [self loadDataWithBool:NO];
    }else{
        SHOW_MSG(@"网络连接失败，请检查网络设置",1);
        [self.myTableView.mj_footer endRefreshing];
    }
}

#pragma mark --请求数据
/** yes:刷新 no:下一页数据 */
-(void)loadDataWithBool:(BOOL)type{
    //分页处理
//    if (!type) {
//        self.nextPage+=1;
//    }else{
//        self.nextPage=1;
//    }
    [self requestFromServer];
}
#pragma mark - target method
-(void)joinBrandWorldAction:(id)sender
{
	UIViewController *joninVc = [[NSClassFromString(@"JoninBrandWorldViewController") alloc]init];
	[self.navigationController pushViewController:joninVc animated:YES];
}
#pragma mark ——— tableViewdelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.dataArr) {
        return self.dataArr.count;
    }
	return self.listModel.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	   WorldBrandTableViewCell *cell=[WorldBrandTableViewCell cellWithTableView:tableView withIdentifier:NSStringFromClass([WorldBrandTableViewCell class]) indexPath:indexPath];
       cell.model = self.dataArr[indexPath.row];
	return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WorldOfTheBrandDetailController*detailVc = [[WorldOfTheBrandDetailController alloc]init];
    detailVc.listModel = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return px_scale(15);
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return px_scale(15);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewAutomaticDimension;
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
        [_myTableView registerClass:[WorldBrandTableViewCell class] forCellReuseIdentifier:NSStringFromClass([WorldBrandTableViewCell class])];
		_myTableView.platformView.title = @"————  我们是有底线的  ————";
		_myTableView.platformView.textColor = [UIColor colorWithHexString:@"#999999"];
		_myTableView.platformView.textFont = [UIFont systemFontOfSize:12];
		_myTableView.platformView.isNotBottom = YES;
	}
	return _myTableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
@end
