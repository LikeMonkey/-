//
//  JoninBrandWorldViewController.m
//  ZhongQiBrand
//
//  Created by ios2 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//
#import "JoninBrandWorldViewController.h"
#import "JoinBrandInputTableViewCell.h"
#import "UploadCertificateCell.h"
#import "JoinTextViewTableViewCell.h"
#import "JoinPhoneInputTableViewCell.h"
#import "JoinTopView.h"
#import "JoinCommitView.h"
#import "TZImagePickerController.h"
#import "JoinInputCache.h"

#import "JoinWorldWaitView.h"   //审核中请等待

@interface JoninBrandWorldViewController ()
<UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate>
//输入其他信息
@property (nonatomic,strong)NSArray *textViewTitles;
//品牌信息标题
@property (nonatomic,strong)NSArray *brandMsgTitles;
//是否进行 身份验证
@property(nonatomic,assign)BOOL isShowCode;
@property (nonatomic,strong)UITableView *myTableView;
@property (nonatomic,strong)NSMutableDictionary *brandMsgDic;  //公司名称。。。  ，经营范围。。。。
//证件图片
@property (nonatomic,strong)NSMutableDictionary *cerThumbsDic;
//当前点击的是第几个 ---
@property(nonatomic,assign)NSInteger currentThumbIndex;
@property (nonatomic,strong)JoinWorldWaitView *waitView; //等待View
@end

@implementation JoninBrandWorldViewController

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self addTextFiledNotification];
}
-(void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	[self removeTextFiledNotification];
	[JoinInputCache share].imagesCache = [self.cerThumbsDic copy];
	[JoinInputCache share].brandMsgCache = [self.brandMsgDic copy];

}
-(void)addTextFiledNotification
{
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)removeTextFiledNotification
{
	[[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)textFiledDidChangeNotification:(NSNotification *)noti
{
	UITextField *tf = noti.object;
	if (!tf) return;
	NSString *key = [@(tf.tag) stringValue];
	if (tf.tag >=BrandMsgBegainTag &&tf.tag <=(BrandMsgBegainTag + 3)) {
		self.brandMsgDic[key] = tf.text; //对数据进行存储
	}else if (tf.tag >= PhoneMsgBegainTag &&tf.tag <=(PhoneMsgBegainTag +2)){
		//手机号、验证码、短信验证码 、
		self.brandMsgDic[key] = tf.text;
	}
}
- (void)viewDidLoad {
    [super viewDidLoad];
	_textViewTitles = @[@"经营范围",@"品牌简介",@"公司简介"];
	_brandMsgTitles = @[@"公司名称",@"品牌名称",@"成立时间",@"官方网站"];
	_isShowCode = YES;
	[self setupUI];
	[self initBackNavItem];
	self.waitView.hidden = NO;
}

-(void)setupUI
{
	[self initNavView];
	self.navigationItem.title = @"加入品牌视界";
	[self.view addSubview:self.myTableView];
	[self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.bottom.equalTo(self.view);
		make.top.equalTo(self.navView.mas_bottom);
	}];

	[self.myTableView registerClass:[JoinBrandInputTableViewCell class] forCellReuseIdentifier:@"JoinBrandInputTableViewCell"];
	[self.myTableView registerClass:[UploadCertificateCell class] forCellReuseIdentifier:@"UploadCertificateCell"];
	[self.myTableView registerClass:[JoinTextViewTableViewCell class] forCellReuseIdentifier:@"JoinTextViewTableViewCell"];
	[self.myTableView registerClass:[JoinPhoneInputTableViewCell class] forCellReuseIdentifier:@"JoinPhoneInputTableViewCell"];
	self.myTableView.delegate = self;
	self.myTableView.dataSource = self;
	//表尾
	JoinCommitView *bottomView = [[JoinCommitView alloc]initWithFrame:CGRectMake(0, 0, MAINScreenWidth, px_scale(207))];
	self.myTableView.tableFooterView = bottomView;
	WS(ws);
	[bottomView setButtonOnClickedAction:^(id  _Nonnull sender, NSInteger index) {
		if (index==0) {
			[ws customserverClicked:sender];
		}else{
			[ws commitClicked:sender];
		}
	}];
}

#pragma mark - 协议方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	//是否显示身份验证
	return !_isShowCode?3:4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
	if (section==0) {
		return 4;
	}else if (section==1){
		return 1;
	}else if(section == 2){
		return 3;
	}else{
		return 1;
	}
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = nil;
	if (indexPath.section == 0) {
		JoinBrandInputTableViewCell *inputCell =  [tableView dequeueReusableCellWithIdentifier:@"JoinBrandInputTableViewCell" forIndexPath:indexPath];
		inputCell.leftTitle = self.brandMsgTitles[indexPath.row];
		NSInteger tag = BrandMsgBegainTag + indexPath.row;
		inputCell.inputFiled.tag = tag;
		NSString *key = [@(tag) stringValue];
		inputCell.inputFiled.text = self.brandMsgDic[key]; //读取值
		if (indexPath.row != 3) {
			inputCell.inputFiled.keyboardType = UIKeyboardTypeDefault;
		}else{
			inputCell.inputFiled.keyboardType = UIKeyboardTypeURL;
		}
		cell = inputCell;
	}else if (indexPath.section == 1){
		UploadCertificateCell *cerCell = [tableView dequeueReusableCellWithIdentifier:@"UploadCertificateCell" forIndexPath:indexPath];
		//赋值图片
		cerCell.thumbsDic = self.cerThumbsDic;
		__weak typeof(self)ws = self;
		//添加图片
		[cerCell setDidClickedCameraItem:^(NSInteger index, id  _Nonnull sender) {
			ws.currentThumbIndex = index;
			[ws openCamaraLibrary];
		}];
		//删除图片
		[cerCell setDeleteClickedCameraItem:^(NSInteger index, id  _Nonnull sender) {
			NSString *thumKey = [@(index) stringValue];
			ws.cerThumbsDic[thumKey] = nil;
			[ws.myTableView reloadData];
		}];
		cell = cerCell;
	}else if (indexPath.section==2){
		//文本输入
		JoinTextViewTableViewCell *textViewCell = [tableView dequeueReusableCellWithIdentifier:@"JoinTextViewTableViewCell" forIndexPath:indexPath];
		textViewCell.titleText = _textViewTitles[indexPath.row];
		textViewCell.textView.tag = BrandDetailBegainTag + indexPath.row;
		__weak typeof(self)ws = self;
		[textViewCell setTextViewDidChangeBlock:^(UITextView *textView, id sender) {
			NSString *key = [@(textView.tag) stringValue];
			ws.brandMsgDic[key] = textView.text;
		}];
		cell = textViewCell;
	}else{
		JoinPhoneInputTableViewCell *phoneCell =  [tableView dequeueReusableCellWithIdentifier:@"JoinPhoneInputTableViewCell" forIndexPath:indexPath];
		//配置参数
		[phoneCell configerWithDic:self.brandMsgDic];
		__weak typeof(self)ws = self;
		[phoneCell setShouldEditeCheck:^BOOL{
			return [ws checkScrollOrUpload:NO];
		}];
		cell = phoneCell;
	}
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"点击某个cell");
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return (section == 0)?px_scale(97):CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return CGFLOAT_MIN;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewAutomaticDimension;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (section == 0) {
		UIView *headerView = [UIView new];
		headerView.backgroundColor =[UIColor colorWithHexString:@"#F6F6F6"];
		headerView.frame = CGRectMake(0, 0, MAINScreenWidth, px_scale(97));
		JoinTopView *joinTopV = [[JoinTopView alloc]initWithFrame:CGRectZero];
		joinTopV.titleLable.text = @"品牌信息";
		[headerView addSubview:joinTopV];
		[joinTopV mas_makeConstraints:^(MASConstraintMaker *make) {
			make.bottom.left.right.mas_equalTo(0);
			make.top.mas_equalTo(px_scale(20));
		}];
		return headerView;
	}
	return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	return nil;
}
#pragma mark - getter
-(UITableView *)myTableView
{
	if (!_myTableView)
 {
	_myTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
	_myTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
	_myTableView.estimatedRowHeight = 44.0;
 }
	return _myTableView;
}
-(NSMutableDictionary *)brandMsgDic
{
	if (!_brandMsgDic) {
		NSDictionary *brandMsgCache = [JoinInputCache share].brandMsgCache;
		if (brandMsgCache) {
			_brandMsgDic = [brandMsgCache mutableCopy];
		}else{
			_brandMsgDic = [[NSMutableDictionary alloc]init];
		}
	 }
	return _brandMsgDic;
}
-(NSMutableDictionary *)cerThumbsDic
{
	if (!_cerThumbsDic) {
		NSDictionary *thumCache = [JoinInputCache share].imagesCache;
		if (thumCache) {
			_cerThumbsDic = [thumCache mutableCopy];
		}else{
			_cerThumbsDic = [[NSMutableDictionary alloc]init];
		}
	 }
	return _cerThumbsDic;
}
// ____________________________________________________________
#pragma mark 相册 ~
-(void)openCamaraLibrary {
	TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1  delegate:self];
	imagePickerVc.allowTakePicture = YES;
	imagePickerVc.naviBgColor = [UIColor whiteColor];
	imagePickerVc.naviTitleColor = [UIColor blackColor];
	imagePickerVc.needShowStatusBar = YES;
	imagePickerVc.barItemTextColor = [UIColor blackColor];
	imagePickerVc.allowPickingOriginalPhoto = NO;
	imagePickerVc.allowPickingVideo = NO;
	imagePickerVc.maxImagesCount = 1;
	imagePickerVc.modalPresentationStyle = UIModalPresentationOverFullScreen;
	[self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
	NSString *key = [@(self.currentThumbIndex) stringValue];
	self.cerThumbsDic[key] = photos.firstObject;
	[self.myTableView reloadData];
}

#pragma mark - target method
-(void)commitClicked:(id)sender
{
	[self checkScrollOrUpload:YES];
}
// isUpload 是否是点击的提交按钮
-(BOOL)checkScrollOrUpload:(BOOL)isUpload
{
	NSString *logokey = [@(0) stringValue];
	NSString *licensekey = [@(1) stringValue];
	NSString *trademarkKey =[@(2) stringValue];
	NSString *otherkey0 = [@(3) stringValue];
	NSString *otherkey1 = [@(4) stringValue];
	NSString *otherkey2 =[@(5) stringValue];
	NSString *phoneKey = [@(PhoneMsgBegainTag+0) stringValue];
	NSString *codeKey = [@(PhoneMsgBegainTag+1) stringValue];
	NSString *smsKey = [@(PhoneMsgBegainTag+2) stringValue];
	NSString *tvKey0 = [@(BrandDetailBegainTag) stringValue];
	NSString *tvKey1 = [@(BrandDetailBegainTag+1) stringValue];
	NSString *tvKey2 = [@(BrandDetailBegainTag+2) stringValue];
	NSString *cNameKey =  [@(BrandMsgBegainTag+0) stringValue];
	NSString *bNameKey =  [@(BrandMsgBegainTag+1) stringValue];
	NSString *timeKey =  [@(BrandMsgBegainTag+2) stringValue];
	NSString *websideKey =  [@(BrandMsgBegainTag+3) stringValue];


	NSString *cName =self.brandMsgDic[cNameKey];//公司名称
	NSString *bName =self.brandMsgDic[bNameKey];//品牌名称
	NSString *time =self.brandMsgDic[timeKey];//成立时间
	NSString *webside =self.brandMsgDic[websideKey];//公司官网
	id logo = self.cerThumbsDic[logokey];	//logo
	id license = self.cerThumbsDic[licensekey];//营业执照
	id trademark = self.cerThumbsDic[trademarkKey];//商标注册
	//其他图片
	id thumb0 = self.cerThumbsDic[otherkey0];
	id thumb1 = self.cerThumbsDic[otherkey1];
	id thumb2 = self.cerThumbsDic[otherkey2];
	//-------
	NSString *tvText0 = self.brandMsgDic[tvKey0];//经营范围
	NSString *tvText1 = self.brandMsgDic[tvKey1];//品牌简介
	NSString *tvText2 = self.brandMsgDic[tvKey2]; //公司简介

	NSString *phone = self.brandMsgDic[phoneKey]; //手机号
	NSString *code = self.brandMsgDic[codeKey];  //验证码
	NSString *sms = self.brandMsgDic[smsKey]; //短信验证

	if (NullString(cName)) {
		SHOW_MSG(@"请输公司名称", 0.5);
		[self inputCellBecomfirstResponse:0 andSection:0 isAnimation:NO];
		return NO;
	}
	if (NullString(bName)) {
		SHOW_MSG(@"请输品牌名称", 0.5);
		[self inputCellBecomfirstResponse:1 andSection:0 isAnimation:NO];
		return NO;
	}
	if (NullString(time)) {
		SHOW_MSG(@"请输成立时间", 0.5);
		[self inputCellBecomfirstResponse:2 andSection:0 isAnimation:NO];
		return NO;
	}
	if (NullString(webside)) {
		SHOW_MSG(@"请输公司官网", 0.5);
		[self inputCellBecomfirstResponse:3 andSection:0 isAnimation:NO];
		return NO;
	}
	if (!logo) {
		SHOW_MSG(@"请添加品牌logo", 0.5);
		[self inputCellBecomfirstResponse:0 andSection:1 isAnimation:YES];
		return NO;
	}
	if (!license) {
		SHOW_MSG(@"请添加营业执照", 0.5);
		[self inputCellBecomfirstResponse:0 andSection:1 isAnimation:YES];
		return NO;
	}
	if (!trademark) {
		SHOW_MSG(@"请添加商标注册", 0.5);
		[self inputCellBecomfirstResponse:0 andSection:1 isAnimation:YES];
		return NO;
	}
	if (self.isShowCode) {
		if (NullString(phone)) {
			if (isUpload) {
				SHOW_MSG(@"请输入手机号", 0.5);
				[self inputCellBecomfirstResponse:0 andSection:3 isAnimation:NO];
			}
			return YES;
		}
		if (NullString(code)) {
			if (isUpload) {
				SHOW_MSG(@"请输入验证码", 0.5);
				[self inputCellBecomfirstResponse:0 andSection:3 isAnimation:YES];
			}
			return YES;
		}
		if (NullString(sms)) {
			if (isUpload) {
				SHOW_MSG(@"请输入短信验证码", 0.5);
				[self inputCellBecomfirstResponse:0 andSection:3 isAnimation:YES];
			}
			return YES;
		}
	}
	//进行数据上传
	if (isUpload) {
		/*
		[RequestBaseTool upload:@"" andParmrs:@{} andIsEcode:NO andMaxKb:500 andImagesInfo:@{} andCompletion:^(id obj) {

		} andProgress:^(float prog) {

		} Error:^(NSError *errror) {

		}];
		 */
	}
	return YES;
}
//输入部分执行第一响应
-(void)inputCellBecomfirstResponse:(NSInteger)indexRow andSection:(NSInteger)section isAnimation:(BOOL)isAnimation
{
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:indexRow inSection:section];
	[self.myTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:isAnimation];
	UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
	[cell becomeFirstResponder];
}
-(void)customserverClicked:(id)sender
{
	NSLog(@"点击客服按钮");
}
-(void)initBackNavItem
{
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
	self.navigationItem.leftBarButtonItem = backItem;
}
-(void)backClicked:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

-(JoinWorldWaitView *)waitView {
	if (!_waitView) {
		_waitView = [[JoinWorldWaitView alloc]initWithFrame:self.view.bounds];
		_waitView.hidden = YES;
		[self.view addSubview:_waitView];
		[_waitView setCustomServerBlock:^{
			NSLog(@"点击客服按钮");
		}];
		[_waitView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(self.navView.mas_bottom);
			make.left.right.bottom.mas_equalTo(0);
		}];
	 }
	//放到最顶层
	[self.view bringSubviewToFront:_waitView];
	return _waitView;
}

@end
