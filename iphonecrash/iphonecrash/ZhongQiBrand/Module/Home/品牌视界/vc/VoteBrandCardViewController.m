//
//  VoteBrandCardViewController.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteBrandCardViewController.h"

@interface VoteBrandCardViewController ()
/** 背景 */
@property (nonatomic,strong) UIView *bgView;
/** 红色背景 */
@property (nonatomic,strong) UIImageView *redImageView;
/** 白色背景    */
@property (nonatomic,strong)  UIImageView*whiteImageView;
/** flag图片 */
@property (nonatomic,strong) UIImageView *flagImageView;
/** 排名 */
@property (nonatomic,strong) UILabel *rankNum;
/** 行业 */
@property (nonatomic,strong) UILabel *professionLabel;
/** 品牌图标 */
@property (nonatomic,strong) UIImageView *brandIcon;
/** 品牌名称 */
@property (nonatomic,strong) UILabel *brandName;
/** 公司名称 */
@property (nonatomic,strong) UILabel *companyLabel;
/** 公司地址 */
@property (nonatomic,strong) UILabel *addressLabel;
/** 网址 */
@property (nonatomic,strong) UILabel *webLabel;
/** 用户头像 */
@property (nonatomic,strong) UIImageView *userIcon;
/** 用户名称 */
@property (nonatomic,strong) UILabel *useName;
/** 红色标语 */
@property (nonatomic,strong) UILabel *flagitle;
/**二维码 */
@property (nonatomic,strong) UIImageView *qRImage;
/** 保存 */
@property (nonatomic,strong) UIButton *saveBtn;
/** 匿名 */
@property (nonatomic,strong) UILabel *unKnow;
/** switch */
@property (nonatomic,strong) UISwitch *unKnowSwitch;

@end

@implementation VoteBrandCardViewController

-(void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	BlackStatusBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"品牌名片";
    [self initNavView];
    [self initBackNavItem];
    [self setUpUI];
	self.userIcon.backgroundColor = [UIColor redColor];
	[self configerDataSource];//模拟配置数据
}
#pragma mark - 配置数据
-(void)configerDataSource
{
	self.rankNum .text  = @"1";  //排行数据
	self.professionLabel.text = @"润滑油行业"; //行业名称数据

	[self.brandIcon sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1568696188979&di=625b66b9f09b1637201c257bb4ee2a9f&imgtype=0&src=http%3A%2F%2Fpic24.nipic.com%2F20121012%2F6659396_153724664149_2.jpg"] placeholderImage:kGetImage(@"tpsq_btn_img")];
	self.brandName.text = @"晨阳科技";
	self.companyLabel.text = [NSString stringWithFormat:@"名称:  %@",@"天津市得秀丽有限任公司"];
	self.addressLabel.text = [NSString stringWithFormat:@"地址:  %@",@"天津市经济开发区"];
	self.webLabel.text = [NSString stringWithFormat:@"网址:  %@",@"https://www.baidu.com"];
	self.useName.text = @"猪八戒";
	[self.flagitle setText:@"来品牌网为得秀丽品牌贡献力量"];
}

-(void)initBackNavItem {
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"all_fahuia_btn"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(backClicked:)];
    self.navigationItem.leftBarButtonItem = backItem;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"ppsj_ppmp_fxtb_icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:(UIBarButtonItemStylePlain) target:self action:@selector(ShareClicked:)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
-(void)setUpUI{
    
    self.lineView.hidden = YES;
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.saveBtn];
	[self.view addSubview:self.unKnow];
	[self.view addSubview:self.unKnowSwitch];
    [self.bgView addSubview:self.redImageView];
    [self.bgView addSubview:self.whiteImageView];
	[self setUpLayout];
}

-(void)setUpLayout
{
	//从内部约束外部高度
	[self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_offset(0);
		make.top.mas_equalTo(self.navView.mas_bottom);
		make.bottom.equalTo(self.whiteImageView);
	}];

		//保存图片
	[self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_offset(px_scale(30));
		make.right.mas_offset(px_scale(-30));
		make.height.mas_equalTo(px_scale(88));
		make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(px_scale(18));
	}];

	[self.redImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.bgView);
		make.top.mas_offset(15);
		make.height.mas_equalTo(px_scale(626));
	}];

	[self.whiteImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.mas_equalTo(self.bgView);
		make.top.mas_equalTo(self.redImageView.mas_bottom).mas_offset(-px_scale(70));
		make.height.mas_equalTo(px_scale(452));
	}];
	[self.flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_offset(px_scale(36*2));
		make.top.mas_offset(px_scale(55));
	}];
	[self.rankNum mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerX.mas_equalTo(self.flagImageView);
		make.top.mas_offset(px_scale(24));

	}];
	[self.professionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_offset(px_scale(36*2));
		make.top.mas_equalTo(self.flagImageView.mas_bottom).mas_offset(px_scale(30));
	}];
	[self.brandIcon mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_offset(px_scale(36*2));
		make.top.mas_equalTo(self.professionLabel.mas_bottom).mas_offset(px_scale(44));
		make.width.mas_equalTo(px_scale(214));
		make.height.mas_equalTo(px_scale(114));
	}];
	[self.brandName mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(self.brandIcon);
		make.left.mas_equalTo(self.brandIcon.mas_right).mas_offset(px_scale(30));
	}];

	[self.companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_offset(px_scale(66));
		make.top.mas_equalTo(self.brandIcon.mas_bottom).mas_offset(px_scale(33));
		make.height.mas_equalTo(px_scale(37));
	}];
	[self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.companyLabel);
		make.top.mas_equalTo(self.companyLabel.mas_bottom).mas_offset(px_scale(8));
		make.height.mas_equalTo(px_scale(37));
	}];
	[self.webLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.addressLabel);
		make.top.mas_equalTo(self.addressLabel.mas_bottom).mas_offset(px_scale(8));
		make.height.mas_equalTo(px_scale(37));
	}];


	[self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_offset(px_scale(60));
		make.top.mas_offset(px_scale(48));
		make.height.width.mas_equalTo(px_scale(68));
	}];

	[self.useName mas_makeConstraints:^(MASConstraintMaker *make) {
		make.centerY.mas_equalTo(self.userIcon);
		make.left.mas_equalTo(self.userIcon.mas_right).offset(px_scale(32));
	}];

	[self.flagitle mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.mas_equalTo(self.userIcon);
		make.top.mas_equalTo(self.userIcon.mas_bottom).offset(px_scale(24));
	}];

	[self.qRImage mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.mas_equalTo(-px_scale(66));
		make.left.mas_offset(px_scale(36*2));
		make.height.width.mas_equalTo(px_scale(132));
	}];


	[self.unKnow mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_offset(-px_scale(36*2));
		make.top.equalTo(self.redImageView.mas_bottom);
	}];


	[self.unKnowSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.mas_equalTo(self.unKnow.mas_right);
		make.top.mas_equalTo(self.unKnow.mas_bottom);
		make.height.mas_equalTo(px_scale(48));
		make.width.mas_equalTo(px_scale(80));
	}];
}


#pragma mark ——— Method
-(void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)ShareClicked:(id)sender
{
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
-(void)saveBtnClick:(id)sender
{
	[self saveImageWithView:self.bgView andScale:2.0];//保存一张二倍图片
}

-(void)saveImageWithView:(UIView *)view andScale:(CGFloat)scale
{
	if (!view){SHOW_MSG(@"保存失败", 0.5) return;}

	CGRect bouds =  CGRectMake(0, 0, CGRectGetWidth(view.bounds)*scale, CGRectGetHeight(view.bounds)*scale);
	UIGraphicsBeginImageContext(bouds.size);
	[view drawViewHierarchyInRect:bouds afterScreenUpdates:YES];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark 协议方法
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
	NSString *msg = nil ;
	if(error){
		msg = @"保存图片失败" ;
	}else{
		msg = @"已保存到手机" ;
	}
	SHOW_MSG(msg, 0.5);
}

-(void)mySwtichValueChange:(UISwitch*)MySwitch{
    if (MySwitch.on == YES) {
        NSLog(@"开启状态");
        self.userIcon.hidden = YES;
        self.useName.hidden = YES;
        [self.flagitle mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(px_scale(64));
            make.top.mas_offset(px_scale(100));
        }];
    }else {
        NSLog(@"关闭状态");
        self.userIcon.hidden = NO;
        self.useName.hidden = NO;
        [self.flagitle mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userIcon);
            make.top.mas_equalTo(self.userIcon.mas_bottom).mas_offset(px_scale(24));
        }];
    }
    
}
#pragma mark ——— lazy

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
    }
    return _bgView;
}
- (UIImageView *)redImageView {
    if (!_redImageView) {
        _redImageView = [[UIImageView alloc]init];
        [_redImageView setImage:[UIImage imageNamed:@"ppsj_fxmp_dt_img"]];
		[_redImageView addSubview:self.flagImageView];
		[_redImageView addSubview:self.rankNum];
		[_redImageView addSubview:self.professionLabel];
		[_redImageView addSubview:self.brandIcon];
		[_redImageView addSubview:self.brandName];
		[_redImageView addSubview:self.companyLabel];
		[_redImageView addSubview:self.addressLabel];
		[_redImageView addSubview:self.webLabel];
    }
    return _redImageView;
}

- (UIImageView *)whiteImageView {
    if (!_whiteImageView) {
        _whiteImageView = [[UIImageView alloc]init];
        [_whiteImageView setImage:[UIImage imageNamed:@"ppsj_sdpp_xmdt_img"]];
		[_whiteImageView addSubview:self.userIcon];
		[_whiteImageView addSubview:self.useName];
		[_whiteImageView addSubview:self.flagitle];
		[_whiteImageView addSubview:self.qRImage];
    }
    return _whiteImageView;
}

- (UIImageView *)flagImageView {
    if (!_flagImageView) {
        _flagImageView = [[UIImageView alloc]init];
        [_flagImageView setImage:[UIImage imageNamed:@"ppsj_top_dtmk_icon"]];
    }
    return _flagImageView;
}

- (UILabel *)rankNum {
    if (!_rankNum) {
        _rankNum = [[UILabel alloc]init];
        [_rankNum setTextColor:[UIColor colorWithHexString:@"#D3141C"]];
        [_rankNum setFont:[UIFont boldSystemFontOfSize:16]];
        _rankNum.textAlignment = NSTextAlignmentCenter;
       
    }
    return _rankNum;
}
- (UILabel *)professionLabel {
    if (!_professionLabel) {
        _professionLabel = [[UILabel alloc]init];
        [_professionLabel setTextColor:[UIColor whiteColor]];
        [_professionLabel setFont:[UIFont boldSystemFontOfSize:18]];
        _professionLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _professionLabel;
}

- (UIImageView *)brandIcon {
    if (!_brandIcon) {
        _brandIcon = [[UIImageView alloc]init];
        _brandIcon.layer.cornerRadius = px_scale(10);
        _brandIcon.layer.masksToBounds = YES;
    }
    return _brandIcon;
}

- (UILabel *)brandName {
    if (!_brandName) {
        _brandName = [[UILabel alloc]init];
        [_brandName setTextColor:[UIColor whiteColor]];
        [_brandName setFont:[UIFont boldSystemFontOfSize:17]];
        _brandName.textAlignment = NSTextAlignmentLeft;
    }
    return _brandName;
}

- (UILabel *)companyLabel {
    if (!_companyLabel) {
        _companyLabel = [[UILabel alloc]init];
        [_companyLabel setTextColor:[UIColor whiteColor]];
        [_companyLabel setFont:[UIFont systemFontOfSize:13]];
        _companyLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _companyLabel;
}
- (UILabel *)addressLabel {
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]init];
        [_addressLabel setTextColor:[UIColor whiteColor]];
        [_addressLabel setFont:[UIFont systemFontOfSize:13]];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _addressLabel;
}
- (UILabel *)webLabel {
    if (!_webLabel) {
        _webLabel = [[UILabel alloc]init];
        [_webLabel setTextColor:[UIColor whiteColor]];
        [_webLabel setFont:[UIFont systemFontOfSize:13]];
        _webLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _webLabel;
}

- (UIImageView *)userIcon {
    if (!_userIcon) {
        _userIcon = [[UIImageView alloc]init];
        
    }
    return _userIcon;
}

- (UILabel *)useName {
    if (!_useName) {
        _useName = [[UILabel alloc]init];
        [_useName setTextColor:[UIColor blackColor]];
        [_useName setFont:[UIFont boldSystemFontOfSize:15]];
        _useName.textAlignment = NSTextAlignmentLeft;
    }
    return _useName;
}

- (UILabel *)flagitle {
    if (!_flagitle) {
        _flagitle = [[UILabel alloc]init];
        [_flagitle setTextColor:[UIColor colorWithHexString:@"#D3141C"]];
        [_flagitle setFont:[UIFont boldSystemFontOfSize:14]];
        _flagitle.textAlignment = NSTextAlignmentLeft;
    }
    return _flagitle;
}

- (UIImageView *)qRImage {
	if (!_qRImage) {
		_qRImage = [[UIImageView alloc]init];
		[_qRImage setImage:[UIImage imageNamed:@"ppsj_wxew_sys_img"]];
    }
	return _qRImage;
}

- (UIButton *)saveBtn {
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存至相册" forState:UIControlStateNormal];
        [_saveBtn setImage:[UIImage imageNamed:@"ppsj_bcxc_btn_icon"] forState:UIControlStateNormal];
        [_saveBtn setBackgroundColor:[UIColor colorWithHexString:@"#D3141C"]];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.layer.cornerRadius = px_scale(44);
        _saveBtn.layer.masksToBounds = YES;
    }
    return _saveBtn;
}

- (UILabel *)unKnow {
	if (!_unKnow) {
		_unKnow  = [[UILabel alloc]init];
		_unKnow.text = @"匿名";
		[_unKnow setTextColor:[UIColor colorWithHexString:@"#666666"]];
		[_unKnow setFont:[UIFont boldSystemFontOfSize:15]];
		_unKnow.textAlignment = NSTextAlignmentRight;
    }
	return _unKnow;
}

- (UISwitch *)unKnowSwitch {
	if (!_unKnowSwitch) {
		_unKnowSwitch = [[UISwitch alloc]init];
		_unKnowSwitch.transform = CGAffineTransformMakeScale(0.8, 0.8);
		_unKnowSwitch.onTintColor = [UIColor colorWithHexString:@"#D3141C"];
		[_unKnowSwitch addTarget:self action:@selector(mySwtichValueChange:) forControlEvents:UIControlEventValueChanged];
      
    }
	return _unKnowSwitch;
}
@end
