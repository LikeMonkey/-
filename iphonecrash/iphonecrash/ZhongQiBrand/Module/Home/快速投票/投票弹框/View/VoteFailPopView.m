//
//  VoteFailPopView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteFailPopView.h"
#import "UIWindow+FrontWindow.h"
#import "WXApi+MiniProgram.h"
@interface VoteFailPopView ()
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UIImageView *rightImg;
@property (nonatomic, strong) UIImageView *logoImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *brandName;
@property (nonatomic, strong) UILabel *descripLabel;
@property (nonatomic, strong) UIButton *smallProgramBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation VoteFailPopView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self maskView];
        [self bgView];
        [self leftImg];
        [self rightImg];
        [self logoImg];
        [self titleLabel];
        [self brandName];
        [self descripLabel];
        [self smallProgramBtn];
        [self shareBtn];
        [self closeBtn];
    }
    return self;
}

+ (instancetype)showVoteFailWithModel:(VoteFailModel *)model {
    VoteFailPopView *failView = [[VoteFailPopView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
    [failView showFailPopViewWithModel:model];
    [failView show];
    return failView;
}

#pragma mark - Private Method
- (void)showFailPopViewWithModel:(VoteFailModel *)model {
    
    [self.logoImg sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@""]];
    self.brandName.text = [NSString stringWithFormat:@"%@",model.brandName];
    self.descripLabel.text = [NSString stringWithFormat:@"%@",model.failError];
}


- (void)show{
    UIWindow *window = [UIWindow frontWindow];
    [window addSubview:self];
}

- (void)hiden{
    [self removeFromSuperview];
}

- (void)smallProgramBtnClicked:(UIButton *)sender {
    [self hiden];
    //SHOW_MSG(@"跳转到小程序", 1);
	NSLog(@"跳转到小程序");
	[WXApi openMiniProgramWithPath:nil andCompletion:^(BOOL isSucess) {

	}];
}

- (void)shareBtnClicked:(UIButton *)sender {
    [self hiden];
    SHOW_MSG(@"分享", 1);
}

- (void)closeBtnClicked:(UIButton *)sender {
    [self hiden];
}

#pragma mark - 懒加载
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]init];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        [self addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _maskView;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.backgroundColor =  [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10*scaleX;
        _bgView.clipsToBounds = YES;
        _bgView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#FFFFFF"]);
        _bgView.layer.borderWidth = 1 * scaleX;
        
        [self.maskView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(300 * scaleX);
            make.height.mas_equalTo(300 * scaleX);
        }];
    }
    return _bgView;
}

- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc]init];
        _leftImg.contentMode = UIViewContentModeScaleAspectFit;
        _leftImg.image = [UIImage imageNamed:@"fail_left_img"];
        
        [self.bgView addSubview:_leftImg];
        [_leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(50 * scaleX);
            make.top.mas_equalTo(36 * scaleX);
            make.width.mas_equalTo(49 * scaleX);
            make.height.mas_equalTo(6 * scaleX);
        }];
    }
    return _leftImg;
}

- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = [[UIImageView alloc]init];
        _rightImg.contentMode = UIViewContentModeScaleAspectFit;
        _rightImg.image = [UIImage imageNamed:@"fail_right_img"];
        
        [self.bgView addSubview:_rightImg];
        [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-50 * scaleX);
            make.top.mas_equalTo(35.5 * scaleX);
            make.width.mas_equalTo(49 * scaleX);
            make.height.mas_equalTo(6 * scaleX);
        }];
        
    }
    return _rightImg;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"投票失败";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _titleLabel.font = [UIFont boldSystemFontOfSize:19];
        
        [self.bgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.equalTo(self.leftImg.mas_centerY).offset(0);
        }];
    }
    return _titleLabel;
}

- (UIImageView *)logoImg {
    if (!_logoImg) {
        _logoImg = [[UIImageView alloc]init];
        _logoImg.contentMode = UIViewContentModeScaleAspectFit;
		_logoImg.layer.borderColor = [UIColor colorWithHexString:@"#C7C7C7"].CGColor;
		_logoImg.layer.borderWidth = 2;
		_logoImg.layer.cornerRadius = 5*scaleX;
		_logoImg.layer.masksToBounds = YES;
        [self.bgView addSubview:_logoImg];
        [_logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(15 * scaleX);
            make.width.mas_equalTo(118 * scaleX);
            make.height.mas_equalTo(63 * scaleX);
        }];
    }
    return _logoImg;
}

- (UILabel *)brandName {
    if (!_brandName) {
        _brandName = [[UILabel alloc]init];
        _brandName.textColor = [UIColor colorWithHexString:@"#333333"];
        _brandName.font = [UIFont boldSystemFontOfSize:17];
        _brandName.textAlignment = NSTextAlignmentCenter;
        
        [self.bgView addSubview:_brandName];
        [_brandName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.logoImg.mas_bottom).offset(8 * scaleX);
        }];
    }
    return _brandName;
}

- (UILabel *)descripLabel {
    if (!_descripLabel) {
        _descripLabel = [[UILabel alloc]init];
        _descripLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _descripLabel.font = [UIFont systemFontOfSize:13];
        _descripLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.bgView addSubview:_descripLabel];
        [_descripLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.brandName.mas_bottom).offset(25 * scaleX);
        }];
    }
    return _descripLabel;
}

- (UIButton *)smallProgramBtn {
    if (!_smallProgramBtn) {
        _smallProgramBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_smallProgramBtn setTitle:@"小程序投票" forState:UIControlStateNormal];
        [_smallProgramBtn setTitleColor:[UIColor colorWithHexString:@"#CF141B"] forState:UIControlStateNormal];
        _smallProgramBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _smallProgramBtn.backgroundColor = [UIColor whiteColor];
        _smallProgramBtn.layer.cornerRadius = 17.5*scaleX;
        _smallProgramBtn.layer.borderColor = [UIColor colorWithHexString:@"#CF141B"].CGColor;
        _smallProgramBtn.layer.borderWidth = 1.5 * scaleX;
        [_smallProgramBtn addTarget:self action:@selector(smallProgramBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgView addSubview:_smallProgramBtn];
        [_smallProgramBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(29 * scaleX);
            make.top.equalTo(self.descripLabel.mas_bottom).offset(30 * scaleX);
            make.width.mas_equalTo(114 * scaleX);
            make.height.mas_equalTo(35 * scaleX);
        }];
    }
    return _smallProgramBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _shareBtn.backgroundColor = [UIColor colorWithHexString:@"#CF141B"];
        _shareBtn.layer.cornerRadius = 17.5*scaleX;
        _shareBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#CF141B"]);
        _shareBtn.layer.borderWidth = 1.5 * scaleX;
        [_shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgView addSubview:_shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-29 * scaleX);
            make.top.equalTo(self.descripLabel.mas_bottom).offset(30 * scaleX);
            make.width.mas_equalTo(114 * scaleX);
            make.height.mas_equalTo(35 * scaleX);
        }];
    }
    return _shareBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"vote_close_icon"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.maskView addSubview:_closeBtn];
        [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.bgView.mas_bottom).offset(25 * scaleX);
            make.width.mas_equalTo(35 * scaleX);
            make.height.mas_equalTo(35 * scaleX);
        }];
    }
    return _closeBtn;
}
@end
