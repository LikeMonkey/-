//
//  VoteViewController.m
//  ZhongQiBrand
//
//  Created by 孙程 on 2019/9/16.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteViewController.h"
#import "VoteBrandDetailViewController.h"
#import "VoteTableViewCell.h"
#import "VoteHeaderView.h"
#import "VoteSuccessModel.h"
#import "VoteFailModel.h"
#import "VoteModel.h"
#import "ShareManager.h"
#import "UserTouchManager.h"
#import "SharePopView.h"
#import "ServicePopView.h"
#import "VoteSuccessPopView.h"
#import "VoteCerImgTextPopView.h"
#import "VoteRulePopView.h"
#import "VoteDetailPopView.h"
#import "VoteFailPopView.h"
#import "SharePopView.h"

@interface VoteViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *backgroudImg;
@property (nonatomic, strong) UITableView *voteTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableArray *searchDataArray;//搜索的数据
@property (nonatomic, strong) VoteHeaderView *headerView;
@property (nonatomic, strong) UIButton *customerServiceBtn;
@property (nonatomic, strong) UIButton *shareBtn;

@property(nonatomic,assign)ActivityState activityState; //活动状态
//投票的响应结果
@property (nonatomic,strong)VoteRequestResponse *response;

//是否是正在搜索
@property(nonatomic,assign)BOOL isSearch;

@end

@implementation VoteViewController
-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	BlackStatusBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    WS(ws);
    [self.view.lgPlaceholder setActionBlock:^(LgPlaceholderState state) {
        if (state == LgPlaceLoadingState) {
            ws.view.lgPlaceholder.state = LgPlaceLoadingState;
            [ws.voteTableView.mj_header beginRefreshing];
        }
    }];
	self.view.lgPlaceholder.state = LgPlaceLoadingState; //设置为加载中
}
#pragma mark - Initial Methods

/** 视图初始化 */
- (void)setupUI {
    [self initNavView];
    [self initBackNavItem];
    [self.view addSubview:self.voteTableView];
    [self.view addSubview:self.customerServiceBtn];
    [self.view addSubview:self.shareBtn];
    [self.voteTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self.customerServiceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-px_scale(15));
        make.top.mas_equalTo(px_scale(971));
        make.width.height.mas_equalTo(px_scale(110));
    }];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-px_scale(15));
        make.top.equalTo(self.customerServiceBtn.mas_bottom).offset(0);
        make.width.height.mas_equalTo(px_scale(110));
    }];
    [self initHeaderView];
}

//初始化表头
- (void)initHeaderView {
    self.voteTableView.tableHeaderView = self.headerView;
}

#pragma mark - Target Mehtods
-(void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)joinClicked:(UIBarButtonItem *)bar{
    // 参加活动
	NSLog(@"点击了参加活动按钮");
}
- (void)customerServiceBtnClick:(UIButton *)btn{
    // 客服
	__weak typeof(self)ws = self;
    ServicePopView *serverPopView = [ServicePopView showInWindow];
	[serverPopView setCustomClickedBlock:^(NSInteger index) {
		[ws customserClickedWithIdnex:index];
	}];
}
//客服点击时候调用
-(void)customserClickedWithIdnex:(NSInteger)index
{
	if (index== 0) {
			//点击了微信
	}else if (index==1){
			//点击了QQ
	}else{
		//点击了打电话
		NSString *phoneUrl = [NSString stringWithFormat:@"tel://%@",self.response.votePhone];
		[[UIApplication sharedApplication]openURL:[NSURL URLWithString:phoneUrl]];
	}
}

- (void)shareBtnClick{
    // 分享
    SharePopView *popV =[SharePopView showShare];
    [popV setShareAction:^(ShareType type, id shareImge) {
    [ShareManager shareWithType:(UMSocialPlatformType)type
                           andImage:@""
                      andShareTitle:@"测试数据"
                        andShareUrl:@""
                       andShareDesc:@"这是一条分享的测试数据"
                      andCompletion:^(BOOL isSuccess) {
                          NSLog(@"分享结果回调");
                      }];
    }];
}

#pragma mark - Private Method

#pragma mark - Public Method


#pragma mark - Private Method

#pragma mark - Public Method


#pragma mark - UITableView Delegate &Datasource
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (self.isSearch) {
		return self.searchDataArray.count;
	}else{
		  return self.dataArray.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	WS(ws);
    VoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VoteTableViewCell class]) forIndexPath:indexPath];
	cell.buttonClickBlock = ^(id sender){
		[ws voteClicked:sender];
	};
	if (!self.isSearch) {
		VoteModel *m = self.dataArray[indexPath.row];
		m.type = self.activityState;
		m.index = m.ranking;
		cell.model = m;
	}else{
		VoteModel *m = self.searchDataArray[indexPath.row];
		m.type = self.activityState;
		m.index = m.ranking;
		cell.model = m;
	}
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//显示图文验证
-(void)showImageTextViewCerView
{
	//[VoteCerImgTextPopView showInWindow];
	[self showInSleepTime];
}

-(void)showVoteFailView
{
	VoteFailModel *failModel = [[VoteFailModel alloc]init];
	failModel.iconUrl = @"http://hbimg.b0.upaiyun.com/828e72e2855b51a005732f4e007c58c92417a61e1bcb1-61VzNc_fw658";
	failModel.brandName = @"耐克";
	failModel.failError = @"网络好像出了点问题";
	[VoteFailPopView showVoteFailWithModel:failModel];
}
-(void)showVoteSucess
{
	// 测试投票成功弹框显示
	VoteSuccessModel *model = [[VoteSuccessModel alloc]init];
	model.iconUrl = @"http://hbimg.b0.upaiyun.com/828e72e2855b51a005732f4e007c58c92417a61e1bcb1-61VzNc_fw658";
	model.votesNum = @"3654";
	model.brandName = @"晨阳科技";
	model.voteDtae = @"2019年07月18日";
	model.voteTime = @"12:00:00";
	VoteSuccessPopView *popView =[VoteSuccessPopView showVoteSuccessWithModel:model];
	[popView setClickedBlock:^(NSInteger type) {
		if (type==1) {
			NSLog(@"分享");
			[[SharePopView showShare] setShareAction:^(ShareType type, id  _Nonnull shareImge) {
				NSLog(@"分享调用");
			}];
		}
	}];
}
-(void)voteWithItem:(id)model andVoteType:(NSString *)voteType
{
	[self showVoteFailView];

	NSLog(@"投票类型：|%@",voteType);
	NSInteger timeLine =  [[NSString spaceTimeLine] integerValue] + 30 * 60;
	[[NSUserDefaults standardUserDefaults]setObject:@(timeLine) forKey:@"last_voteTimeLine"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	//开启首页定时器
    [HomeTimeManager startTime];
}
//不在投票时间点内
-(void)showInSleepTime
{
	[VoteRulePopView showContent:@"晚24:00 — 早7:00之间不可进行投票" ruleType:VoteRuleTypeOverTime];
}
-(void)voteClose
{
	[VoteRulePopView showContent:@"您在30分钟后，即10：30可继续参与投票" ruleType:VoteRuleTypeDuring];
}
-(void)voteClicked:(id)sender
{
	//活动揭榜了去揭榜
	if (self.activityState >=ActivityUnCoverInThreeDayState ) {
		NSLog(@"活动揭榜了去揭榜");
		SHOW_MSG(@"去揭榜", 1);
		return;
	}
	//活动没有在进行中不进行投票
	if (self.activityState !=ActivityInProgressState) return;
	__weak typeof(self)ws = self;
	NSIndexPath *indexPath = [self.voteTableView indexPathForCell:sender];
	[UserTouchManager useFaceOrTouch:^(TouchIdAuthorState state) {
		if (state != AuthorSucessType) {
			[ws showImageTextViewCerView];//使用图文验证进行投票
		}else if(state == AuthorSucessType){
			[ws voteWithItem:indexPath andVoteType:@"1"]; //指纹投票 验证成功
		}
	}];
}
#pragma mark - Table view delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VoteModel*votemodel = self.dataArray[indexPath.row];
    if (votemodel.type == 6) {
        return px_scale(238);
    }else{
        return px_scale(188);
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    VoteBrandDetailViewController *vc= [[VoteBrandDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

#pragma mark - Setter & Getter
- (UIImageView *)backgroudImg {
    if (!_backgroudImg) {
        _backgroudImg = [[UIImageView alloc]init];
        _backgroudImg.image = [UIImage imageNamed:@"ppsj_bd_dwy_img"];
    }
    return _backgroudImg;
}
- (UITableView *)voteTableView{
    if (!_voteTableView) {
        _voteTableView = [[UITableView alloc] init];
		 [_voteTableView registerClass:[VoteTableViewCell class] forCellReuseIdentifier:NSStringFromClass([VoteTableViewCell class])];
        _voteTableView.dataSource = self;
        _voteTableView.delegate = self;
        _voteTableView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        _voteTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _voteTableView.platformView.title = @"————  我们是有底线的  ————";
        _voteTableView.platformView.textColor = [UIColor colorWithHexString:@"#999999"];
        _voteTableView.platformView.textFont = [UIFont systemFontOfSize:12];
        _voteTableView.platformView.isNotBottom = YES;
		MJHeader *mjHeader = [MJHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestDataSource)];
		_voteTableView.mj_header = mjHeader;
		[mjHeader beginRefreshing];
    }
    return _voteTableView;
}

-(void)searchRequestText:(NSString *)text
{
	NSPredicate *pred = [NSPredicate predicateWithFormat:@"brandName contains %@",text];
	NSArray *array =  [self.dataArray filteredArrayUsingPredicate:pred];
	[self.searchDataArray removeAllObjects];
	[self.searchDataArray addObjectsFromArray:array];
	[self.voteTableView reloadData];
}
//显示活动详情
-(void)showActivityDetail
{
	NSString *title = [NSString stringWithFormat:@"中国%@",self.response.catname];
	[VoteDetailPopView show:title
					   time:self.response.hdtime
			  participation:@"进入中企品牌网\n官方网站参与活动"];
}
#pragma mark - getter
- (VoteHeaderView *)headerView{
	if (!_headerView) {
		WS(ws);
		_headerView = [[VoteHeaderView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, px_scale(380 + 36))];
		_headerView.buttonClickBlock = ^(UIButton * _Nonnull btn) {
			if (btn.tag == 101){
				[ws joinClicked:nil];
			}else if (btn.tag == 102){
				[ws showActivityDetail];
			}
		};
		[_headerView setSearchReturnBlock:^(NSString * _Nonnull searchText) {
			ws.isSearch = YES;
			[ws searchRequestText:searchText];//调用搜索点击的词汇
		}];
		[_headerView setSearchTextDidChange:^(NSString * _Nonnull searchText) {
			if (NullString(searchText)) {
				ws.isSearch = NO;
				[ws.voteTableView reloadData];
			}
		}];
	}
	return _headerView;
}
- (UIButton *)customerServiceBtn{
    if (!_customerServiceBtn) {
        _customerServiceBtn = [[UIButton alloc] init];
        [_customerServiceBtn setImage:kGetImage(@"app_kfdh_icon") forState:UIControlStateNormal];
        [_customerServiceBtn addTarget:self action:@selector(customerServiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customerServiceBtn;
}
- (UIButton *)shareBtn{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setImage:kGetImage(@"app_fxtb_icon") forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
-(NSMutableArray *)searchDataArray
{
	if (!_searchDataArray)  {
		_searchDataArray = [[NSMutableArray alloc]init];
	 }
	return _searchDataArray;
}

-(NSMutableArray *)dataArray {
	if (!_dataArray) {
		_dataArray = [[NSMutableArray alloc]init];
	 }
	return _dataArray;
}

-(void)initBackNavItem {
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
	self.navigationItem.leftBarButtonItem = backItem;
	UIBarButtonItem *joinItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"app_cjhd_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(joinClicked:)];
	self.navigationItem.rightBarButtonItem = joinItem;
}
// -------------------  模拟数据 -----------------------------
#pragma mark - Network
-(void)requestDataSource
{
	TokenModel *token = [TokenModel new];
	token.method = @"vote";
	token.auth = @"vote";
	NSMutableDictionary *parm = [token.dictionary mutableCopy];
	parm[@"ouid"] = @"0";
	parm[@"openid"] =  @"0";
	parm[@"auth"] = @"0";
	parm[@"sid"] = @"ab22807e5ee23577"; //测试使用
	//使用本地 mac 电脑服务器进行调试
	WS(ws);
	[RequestBaseTool getUrlStr:@"http://192.168.1.18/vote/index.php" andParms:@{} andCompletion:^(id obj) {
		NSLog(@"输出请求数据：|%@",obj);
		VoteRequestResponse *response = [[VoteRequestResponse alloc]initWithDictionary:obj];
		if ([response.status isEqualToString:@"1"]) {
			ws.response = response;
			ws.activityState = [response.voteStatus integerValue];//测试数据具体不太清楚字段意思
			if (ws.activityState == 6) {
				self.voteTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ppsj_bd_dwy_img"]];
			}else{
				self.voteTableView.backgroundColor = [UIColor clearColor];
			}
			[ws.dataArray removeAllObjects];
			[ws.dataArray addObjectsFromArray:response.data];
			[ws.voteTableView reloadData];
			ws.view.lgPlaceholder.state = LgPlaceNormalState;
			ws.headerView.runLab.text = response.voteNotice;
			ws.headerView.titleLab.text = response.title;
			ws.headerView.descriptionLab.text = response.catname;
			ws.navigationItem.title = response.title;
		}else{
			SHOW_MSG(response.msg, 1);
		}
		[ws.voteTableView.mj_header endRefreshing];
	} Error:^(NSError *errror) {
	}];
//	return;
//	[RequestBaseTool postUrlStr:AppendAPI(APPURL_prefix, @"/vote/index.php")
//					   andParms:parm
//				  andCompletion:^(id obj) {
//					  NSLog(@"输出请求结果：|%@",obj);
//	} Error:^(NSError *errror) {
//		NSLog(@"输出请求结果：|%@",errror);
//	}];
}

@end

