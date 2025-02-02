//
//  VoteBrandDetaiHeaderView.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteBrandDetaiHeaderView.h"

@implementation VoteBrandDetaiHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpViews];
    }
    
    return self;
}

- (void)setUpViews {
    [self addSubview:self.bgImageView];
    [self addSubview:self.bgView];
    [self addSubview:self.BrandDetail];
    [self addSubview:self.bottomView];
    [self.bgView addSubview:self.icon];
    [self.bgView addSubview:self.brandName];
    [self.bgView addSubview:self.qRBtn];
    [self.bgView addSubview:self.rankNum];
    [self.bgView addSubview:self.ticketsNum];
    [self.bgView addSubview:self.fromUpNum];
    [self.bgView addSubview:self.rank];
    [self.bgView addSubview:self.tickets];
    [self.bgView addSubview:self.fromUp];
    [self.bgView addSubview:self.line1];
    [self.bgView addSubview:self.line2];
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(px_scale(297));
    }];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(px_scale(50));
        make.left.mas_offset(px_scale(30));
        make.right.mas_offset(px_scale(-30));
        make.height.mas_equalTo(px_scale(363));
    }];
    [self.BrandDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_bottom).mas_offset(px_scale(50));
        make.left.mas_offset(px_scale(60));
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(60));
        make.right.mas_offset(px_scale(-60));
        make.top.mas_equalTo(self.BrandDetail.mas_bottom).mas_offset(px_scale(30));
        make.height.mas_equalTo(px_scale(2));
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(px_scale(40));
        make.top.mas_offset(px_scale(40));
        make.height.mas_equalTo(px_scale(126));
        make.width.mas_equalTo(px_scale(236));
        
    }];
    [self.brandName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.icon);
        make.left.mas_equalTo(self.icon.mas_right).mas_offset(px_scale(40));
    }];
    [self.qRBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.icon.mas_top);
        make.right.mas_offset(-px_scale(40));
        make.height.width.mas_equalTo(px_scale(50));
    }];
    [self.rankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.icon.mas_bottom).mas_offset(px_scale(81));
        make.left.mas_offset(0);
        make.width.mas_equalTo((MAINScreenWidth-px_scale(60))/3);
    }];
    [self.ticketsNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rankNum.mas_right);
        make.centerY.mas_equalTo(self.rankNum);
        make.width.mas_equalTo((MAINScreenWidth-px_scale(60))/3);
    }];
    [self.fromUpNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.ticketsNum.mas_right);
        make.centerY.mas_equalTo(self.rankNum);
        make.width.mas_equalTo((MAINScreenWidth-px_scale(60))/3);
    }];
    [self.rank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rankNum);
        make.top.mas_equalTo(self.rankNum.mas_bottom).mas_offset(px_scale(10));
    }];
    [self.tickets mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.ticketsNum);
        make.top.mas_equalTo(self.ticketsNum.mas_bottom).mas_offset(px_scale(10));
    }];
    [self.fromUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.fromUpNum);
        make.top.mas_equalTo(self.fromUpNum.mas_bottom).mas_offset(px_scale(10));
    }];
    
    [self.line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rankNum.mas_right).mas_offset(1);
        make.centerY.mas_equalTo(self.rankNum.mas_bottom);
        make.height.mas_equalTo(px_scale(70));
        make.width.mas_equalTo(px_scale(2));
    }];
    [self.line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.ticketsNum.mas_right).mas_offset(1);
        make.centerY.mas_equalTo(self.line1);
        make.height.mas_equalTo(px_scale(70));
        make.width.mas_equalTo(px_scale(2));
    }];
    
    self.bgView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bgView.bounds].CGPath;
    self.bgView.layer.shadowColor = [[UIColor colorWithHexString:@"#525252"] CGColor];
    //6px
    self.bgView.layer.shadowOffset = CGSizeMake(2, 2);
    self.bgView.layer.shadowOpacity = 0.11;
    [self iconImgViewBoderColor:[UIColor colorWithHexString:@"#E9E9E9"] borderWidth:px_scale(2) cornerRadius:px_scale(10)];
}

#pragma mark ——— lazy
- (UIImageView *)bgImageView {
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]init];
        [_bgImageView setImage:[UIImage imageNamed:@"ppsj_ppxq_jpdt_img"]];
        
    }
    return _bgImageView;
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc]init];
        [_bgView setImage:[UIImage imageNamed:@"ppsj_tpmkp_img"]];
        
        _bgView.userInteractionEnabled = YES;
        
        
        
    }
    return _bgView;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
    }
    return _icon;
}

- (UILabel *)brandName {
    if (!_brandName) {
        _brandName = [[UILabel alloc]init];
        _brandName.textColor = [UIColor blackColor];
        _brandName.textAlignment = NSTextAlignmentLeft;
        _brandName.font = [UIFont boldSystemFontOfSize:18];
    }
    return _brandName;
}

- (UIButton *)qRBtn {
    if (!_qRBtn) {
        _qRBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_qRBtn setBackgroundImage:[UIImage imageNamed:@"ppsj_ppxq_ewm_icon"] forState:UIControlStateNormal];
        
    }
    return _qRBtn;
}

- (UILabel *)rankNum {
    if (!_rankNum) {
        _rankNum = [[UILabel alloc]init];
        _rankNum.textColor = [UIColor colorWithHexString:@"#C03128"];
        _rankNum.textAlignment = NSTextAlignmentCenter;
        _rankNum.font = [UIFont boldSystemFontOfSize:18];
        _rankNum.text = @"-";
        
    }
    return _rankNum;
}

- (UILabel *)rank {
    if (!_rank) {
        _rank = [[UILabel alloc]init];
        _rank.textColor = [UIColor blackColor];
        _rank.textAlignment = NSTextAlignmentCenter;
        _rank.font = [UIFont systemFontOfSize:13];
        _rank.text = @"当前排名";
    }
    return _rank;
}
- (UILabel *)ticketsNum {
    if (!_ticketsNum) {
        _ticketsNum = [[UILabel alloc]init];
        _ticketsNum.textColor = [UIColor colorWithHexString:@"#C03128"];
        _ticketsNum.textAlignment = NSTextAlignmentCenter;
        _ticketsNum.font = [UIFont boldSystemFontOfSize:18];
        _ticketsNum.text = @"-";
        
    }
    return _ticketsNum;
}

- (UILabel *)tickets {
    if (!_tickets) {
        _tickets = [[UILabel alloc]init];
        _tickets.textColor = [UIColor blackColor];
        _tickets.textAlignment = NSTextAlignmentCenter;
        _tickets.font = [UIFont systemFontOfSize:13];
        _tickets.text = @"当前票数";
    }
    return _tickets;
}
- (UILabel *)fromUpNum {
    if (!_fromUpNum) {
        _fromUpNum = [[UILabel alloc]init];
        _fromUpNum.textColor = [UIColor colorWithHexString:@"#C03128"];
        _fromUpNum.textAlignment = NSTextAlignmentCenter;
        _fromUpNum.font = [UIFont boldSystemFontOfSize:18];
        _fromUpNum.text = @"-";
        
    }
    return _fromUpNum;
}

- (UILabel *)fromUp {
    if (!_fromUp) {
        _fromUp = [[UILabel alloc]init];
        _fromUp.textColor = [UIColor blackColor];
        _fromUp.textAlignment = NSTextAlignmentCenter;
        _fromUp.font = [UIFont systemFontOfSize:13];
        _fromUp.text = @"距上一名(票)";
    }
    return _fromUp;
}

- (UIView *)line1 {
    if (!_line1) {
        _line1 = [[UIView alloc]init];
        _line1.backgroundColor =[UIColor colorWithHexString:@"#E5E5E5"];
    }
    return _line1;
}
- (UIView *)line2 {
    if (!_line2) {
        _line2 = [[UIView alloc]init];
        _line2.backgroundColor =[UIColor colorWithHexString:@"#E5E5E5"];
    }
    return _line2;
}

- (UILabel *)BrandDetail {
    if (!_BrandDetail) {
        _BrandDetail = [[UILabel alloc]init];;
        _BrandDetail.text = @"品牌详情";
        _BrandDetail.font = [UIFont boldSystemFontOfSize:17];
        _BrandDetail.textAlignment = NSTextAlignmentLeft;
    }
    return _BrandDetail;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor =[UIColor colorWithHexString:@"#E5E5E5"];
    }
    return _bottomView;
}
- (void)iconImgViewBoderColor:(UIColor *)color borderWidth:(CGFloat)borderWidth cornerRadius:(CGFloat)cornerRadius{
    self.icon.layer.cornerRadius = cornerRadius;
    self.icon.layer.borderColor = color.CGColor;
    self.icon.layer.borderWidth = borderWidth;
    self.icon.clipsToBounds = YES;
}
@end
