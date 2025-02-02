//
//  VoteRulePopView.m
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteRulePopView.h"
#import "UIWindow+FrontWindow.h"

@interface VoteRulePopView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UIImageView *rightImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *knowBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation VoteRulePopView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self maskView];
        [self bgView];
        [self leftImg];
        [self rightImg];
        [self titleLabel];
        [self contentLabel];
        [self knowBtn];
        [self shareBtn];
        [self closeBtn];
    }
    return self;
}

+ (instancetype)showContent:(NSString *)content ruleType:(VoteRuleType)ruleType{
    
    VoteRulePopView *ruleView = [[VoteRulePopView alloc] initWithFrame:CGRectMake(0, 0, MAINScreenWidth, MAINScreenHeight)];
    [ruleView showContent:content ruleType:ruleType];
    [ruleView show];
    return ruleView;
    
}

#pragma mark - Private Method
- (void)showContent:(NSString *)content ruleType:(VoteRuleType)ruleType{
    self.contentLabel.text = content;
    if (ruleType == VoteRuleTypeOverTime) {
        
        self.shareBtn.hidden = YES;
        [self.knowBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.knowBtn.backgroundColor = [UIColor colorWithHexString:@"#CF141B"];
        self.knowBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [_knowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(33 * scaleX);
            make.width.mas_equalTo(114 * scaleX);
            make.height.mas_equalTo(35 * scaleX);
        }];
        
    }else if (ruleType == VoteRuleTypeDuring) {
        
        self.shareBtn.hidden = NO;
        [self.knowBtn setTitleColor:[UIColor colorWithHexString:@"#CF141B"] forState:UIControlStateNormal];
        self.knowBtn.backgroundColor = [UIColor whiteColor];
        self.knowBtn.layer.borderColor = [UIColor colorWithHexString:@"#CF141B"].CGColor;
        
        [_knowBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(29 * scaleX);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(33 * scaleX);
            make.width.mas_equalTo(114 * scaleX);
            make.height.mas_equalTo(35 * scaleX);
        }];
    }
}

- (void)show{
    UIWindow *window = [UIWindow frontWindow];
    [window addSubview:self];
}

- (void)hiden{
    [self removeFromSuperview];
}

- (void)knowBtnClicked:(UIButton *)sender {
    [self hiden];
}

- (void)shareBtnClicked:(UIButton *)sender {
    [self hiden];
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
        _bgView.layer.cornerRadius = 10 * scaleX;
        _bgView.clipsToBounds = YES;
        _bgView.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#FFFFFF"]);
        _bgView.layer.borderWidth = 1 * scaleX;
        
        [self.maskView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-5 * scaleX);
            make.width.mas_equalTo(300 * scaleX);
            make.height.mas_equalTo(193 * scaleX);
        }];
    }
    return _bgView;
}

- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc]init];
        _leftImg.contentMode = UIViewContentModeScaleAspectFit;
        _leftImg.image = [UIImage imageNamed:@"vote_left_img"];
        
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
        _rightImg.image = [UIImage imageNamed:@"vote_right_img"];
        
        [self.bgView addSubview:_rightImg];
        [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-50 * scaleX);
            make.top.mas_equalTo(36 * scaleX);
            make.width.mas_equalTo(49 * scaleX);
            make.height.mas_equalTo(6 * scaleX);
        }];
        
    }
    return _rightImg;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"投票规则";
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

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _contentLabel.font = [UIFont systemFontOfSize:13];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.bgView addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(27 * scaleX);
        }];
    }
    return _contentLabel;
}

- (UIButton *)knowBtn {
    if (!_knowBtn) {
        _knowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_knowBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [_knowBtn setTitleColor:[UIColor colorWithHexString:@"#CF141B"] forState:UIControlStateNormal];
        _knowBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _knowBtn.backgroundColor = [UIColor whiteColor];
        _knowBtn.layer.cornerRadius = 17.5 * scaleX;
        _knowBtn.layer.borderColor = [UIColor colorWithHexString:@"#CF141B"].CGColor;
        _knowBtn.layer.borderWidth = 1.5 * scaleX;
        [_knowBtn addTarget:self action:@selector(knowBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgView addSubview:_knowBtn];
        [_knowBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(29 * scaleX);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(33 * scaleX);
            make.width.mas_equalTo(114 * scaleX);
            make.height.mas_equalTo(35 * scaleX);
        }];
    }
    return _knowBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setTitle:@"分享" forState:UIControlStateNormal];
        [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _shareBtn.backgroundColor = [UIColor colorWithHexString:@"#CF141B"];
        _shareBtn.layer.cornerRadius = 17.5 * scaleX;
        _shareBtn.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor colorWithHexString:@"#CF141B"]);
        _shareBtn.layer.borderWidth = 1.5 * scaleX;
        [_shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.bgView addSubview:_shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-29 * scaleX);
            make.top.equalTo(self.contentLabel.mas_bottom).offset(33 * scaleX);
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

