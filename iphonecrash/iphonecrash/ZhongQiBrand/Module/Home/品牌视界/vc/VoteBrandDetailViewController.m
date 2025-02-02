//
//  VoteBrandDetailViewController.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteBrandDetailViewController.h"
#import "VoteBrandDetaiHeaderView.h"
#import "VoteBrandDetailCell.h"
#import "UIImage+GIF.h"
#import "GiftView.h"
#import "VoteBrandCardViewController.h"
#import "GiftOrderViewController.h"
#import "WXApi+MiniProgram.h"

@interface VoteBrandDetailViewController ()<UITableViewDelegate, UITableViewDataSource,GiftViewDelegate>
@property (nonatomic,strong)NSMutableDictionary *heightCache;
@property (nonatomic,strong) UITableView *tableView;
/** 头试图 */
@property (nonatomic,strong)  VoteBrandDetaiHeaderView*headerView;
/** 数据源 */
@property (nonatomic,strong) NSMutableArray *dataArr;
/** 数据源名称 */
@property (nonatomic,strong) NSMutableArray *infoArr;
/** gift动图 */
@property (nonatomic,strong) UIImageView *giftImageView;
/** gifBtn */
@property (nonatomic,strong) UIButton *gifBtn;
/** 礼物列表 */
@property (nonatomic,strong) GiftView *giftView;
/**小程序按钮 */
@property (nonatomic,strong) UIButton *miniProgrmeBtn;

@end

@implementation VoteBrandDetailViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    LightStatusBar
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavView];
    [self initBackNavItem];
    [self setUpUI];
    [self initData];
    
}
-(void)initData{
    self.infoArr =@[@"品牌行业:",@"企业网址:",@"企业名称:",@"企业地址:"].mutableCopy;
    self.dataArr =@[@"晨阳科技",@"http://baidu.com",@"晨阳科技网络有限责任公司",@"液压气动成套设备生产(限分支经营)销售机 械设备冶金设备金属材料建筑装潢材。"].mutableCopy;
    [self.headerView.icon sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568696188979&di=625b66b9f09b1637201c257bb4ee2a9f&imgtype=0&src=http%3A%2F%2Fpic24.nipic.com%2F20121012%2F6659396_153724664149_2.jpg"] placeholderImage:kGetImage(@"tpsq_btn_img")];
    self.headerView.brandName.text = @"晨阳科技";
}
-(void)setUpUI{
    
    UILabel *titleLable = [UILabel new];
    titleLable.font  =[UIFont systemFontOfSize:16];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.text = @"品牌详情";
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;
    self.lineView.hidden = YES;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self.view addSubview:self.miniProgrmeBtn];
    [self.miniProgrmeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).mas_offset(px_scale(727));
        make.right.mas_offset(-px_scale(13));
        make.height.width.mas_equalTo(px_scale(114));
    }];

	[self.headerView.qRBtn addTarget:self action:@selector(QRBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.tableView.tableHeaderView = self.headerView;
    self.navView.backgroundColor = [UIColor colorWithHexString:@"#C03128"];

    self.giftImageView = [[UIImageView alloc]init];
    [self.giftImageView setImage:[UIImage sd_animatedGIFNamed:@"gift"]];
    [self.view addSubview:self.giftImageView];
    [self.giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_offset(px_scale(-103));
    }];
    [self.view addSubview:self.gifBtn];
    [self.gifBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.giftImageView);
    }];
}
#pragma mark ——— giftDelegate
-(void)SuccessClickSengBtnWithGiftIndex:(NSInteger)indexNum AndGiftNum:(NSInteger)giftNum{
    GiftOrderViewController *vc = [[GiftOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Private Method

-(void)initBackNavItem {
     UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[[UIImage imageNamed:@"all_fahuia_btn"]imageWithColor:[UIColor whiteColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
    self.navigationItem.leftBarButtonItem = backItem;
}
#pragma mark - tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VoteBrandDetailCell *cell=[VoteBrandDetailCell cellWithTableView:tableView withIdentifier:NSStringFromClass([VoteBrandDetailCell class]) indexPath:indexPath];
    cell.contentLabel.text = self.infoArr[indexPath.row];
    [cell confingTextLableWithString:self.dataArr[indexPath.row]];
    return cell;
}
#pragma mark - <UITableViewDelegate>
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSNumber *heightNum =  self.heightCache[indexPath];
	return heightNum?heightNum.floatValue:44.0;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	CGFloat cellHeight =  CGRectGetHeight(cell.frame);
	self.heightCache[indexPath] = @(cellHeight);
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

#pragma mark - Setter & Getter
-(UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate =self;
        _tableView.dataSource =self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        [_tableView registerClass:[VoteBrandDetailCell class] forCellReuseIdentifier:NSStringFromClass([VoteBrandDetailCell class])];
        _tableView.scrollEnabled = YES;
        _tableView.estimatedRowHeight = px_scale(68);
    }
    return _tableView;
}
- (GiftView *)giftView {
    if (!_giftView) {
        _giftView = [[GiftView alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
        _giftView.delegate = self;
      
    }
    return _giftView;
}
- (UIButton *)gifBtn {
    if (!_gifBtn) {
        _gifBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_gifBtn addTarget:self action:@selector(giftBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _gifBtn.backgroundColor = [UIColor clearColor];
    }
    return _gifBtn;
}

- (VoteBrandDetaiHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[VoteBrandDetaiHeaderView alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth, px_scale(571))];
    }
    return _headerView;
}

- (UIButton *)miniProgrmeBtn {
    if (!_miniProgrmeBtn) {
        _miniProgrmeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_miniProgrmeBtn setImage:[UIImage imageNamed:@"ppsj_ppxq_xcxm_icon"] forState:UIControlStateNormal];
        [_miniProgrmeBtn addTarget:self action:@selector(miniProgrmeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _miniProgrmeBtn;
}
-(NSMutableDictionary *)heightCache
{
	if (!_heightCache) {
		_heightCache = [[NSMutableDictionary alloc]init];
	 }
	return _heightCache;
}
#pragma mark - Target Mehtods

-(void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)giftBtnClick{ 
    [self.giftView show];
}
    

-(void)QRBtnClick{
    VoteBrandCardViewController *vc= [[VoteBrandCardViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)miniProgrmeBtnClick:(UIButton *)sender{
    NSLog(@"跳转小程序");
	[WXApi openMiniProgramWithPath:nil andCompletion:^(BOOL isSucess) {
		
	}];
}


-(void)giftNumChange:(UIButton *)sender{
    NSInteger num  = [self.giftView.giftNum.text integerValue];
    if (num==0&&sender.tag==0)  return;
    //减
    if (sender.tag == 0) {
        num-= 1;
        self.giftView.giftNum.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
    //加
    if (sender.tag == 1) {
        num+= 1;
        self.giftView.giftNum.text = [NSString stringWithFormat:@"%ld",(long)num];
    }
    
}
-(void)sendGift:(UIButton *)sender{
    if (!self.giftView.selectedIndex) {
        [WDAlert showAlertWithMessage:@"请选择礼物" time:0.5f];
        return;
    }
    if ([self.giftView.giftNum.text isEqualToString:@"0"]) {
        [WDAlert showAlertWithMessage:@"请选择礼物数量" time:0.5f];
        return;
    }
    [self.giftView hiddenGiftView];
    GiftOrderViewController *vc = [[GiftOrderViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
