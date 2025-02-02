//
//  LgPlaceStateView.m
//  ScrollPage
//
//  Created by ios2 on 2019/4/8.
//  Copyright © 2019 LenSky. All rights reserved.
//

#import "LgPlaceStateView.h"
#import "UIImage+GIF.h"

@interface LgPlaceStateView()
//状态标签
@property (nonatomic,strong)UILabel *stateLable;
@end

@implementation LgPlaceStateView{
	UIImageView * _stateImageView;
	UIImage *_gifImage;
	UIButton * _refreshBtn;
}
-(void)pearance
{
	[super pearance];
	//加载子控件
	[self addSubview:self.stateLable];

	_stateImageView = [UIImageView new];

	[self addSubview:_stateImageView];

	_stateImageView.contentMode = UIViewContentModeScaleAspectFit;

	_stateImageView.bounds = CGRectMake(0, 0, px_scale(70), px_scale(70));

	self.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];

	_gifImage = [UIImage sd_animatedGIFNamed:@"loading"];

	_refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];

	[_refreshBtn setTitleColor:[UIColor colorWithHexString:@"#0F82D2"] forState:UIControlStateNormal];

	[_refreshBtn setTitle:@"点击刷新" forState:UIControlStateNormal];

	_refreshBtn.layer.cornerRadius = px_scale(54)/2.0;

	_refreshBtn.layer.borderColor = [UIColor colorWithHexString:@"#0F82D2"].CGColor;

	_refreshBtn.layer.borderWidth = 1.0;

	_refreshBtn.layer.masksToBounds = YES;

	_refreshBtn.titleLabel.font = [UIFont systemFontOfSize:12];

	[self addSubview:_refreshBtn];

	[_refreshBtn addTarget:self action:@selector(refreshClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)refreshClicked:(id)sender
{
	if (self.actionBlock) {
		self.actionBlock(self.state);
	}
}

-(UILabel *)stateLable {
	if (!_stateLable) {
		_stateLable = [[UILabel alloc]init];
		_stateLable.textColor = [UIColor colorWithHexString:@"#828D97"];
		_stateLable.textAlignment = NSTextAlignmentCenter;
		_stateLable.font = [UIFont systemFontOfSize:15.0];
	 }
	return _stateLable;
}

-(void)layoutSubviews
{
	[super layoutSubviews];
	[self changeSubFrame];
}
-(void)changeSubFrame {
	if (_bg_View) {
		if (self.state != LgPlaceLoadingState) {
			CGFloat scale = CGRectGetHeight(_bg_View.frame)/(CGRectGetHeight([UIScreen mainScreen].bounds)*0.6);
            if (scale <= 0.6) {
					_stateImageView.bounds = CGRectMake(0, 0, px_scale(300), CGRectGetHeight(_bg_View.frame)*scale);
            }
		}
		if (self.state == LgPlaceNoMsgState) {
			_stateImageView.bounds = CGRectMake(0, 0, px_scale(300), px_scale(250));
		}
		CGFloat h = CGRectGetHeight(self.bounds);
		CGFloat w = CGRectGetWidth(self.bounds);
		UIEdgeInsets edg = self.placeEdgeInsets;
		CGFloat cY = (h - edg.top)/2.0 + CGRectGetHeight(_stateImageView.bounds)/2.0 -_bg_View.frame.origin.y/2.0 - 70;
		CGFloat cX = w/2.0;
		CGRect b = _stateLable.bounds;
		b.size.width = w;
		b.size.height = 25;
		self.stateLable.bounds = b;
		self.stateLable.center = (CGPoint){cX,cY};
		CGFloat stateW = CGRectGetWidth(_stateImageView.bounds);
		_stateImageView.center = (CGPoint){cX,cY -stateW/2.0};
		if (self.state == LgPlaceLoadingState) {
			CGFloat l_Cy = (h - edg.top)/2.0 + CGRectGetHeight(_stateImageView.bounds)/2.0 -_bg_View.frame.origin.y/2.0;
			_stateImageView.center = (CGPoint){cX,l_Cy -stateW/2.0};
		}
		if (self.isCenter) {
//            _stateImageView.center = CGPointMake(CGRectGetMidX(_bg_View.bounds), CGRectGetMidY(_bg_View.bounds));
            _stateImageView.centerY = self.height / 2.0 - 35;
			_stateLable.y = _stateImageView.maxY + 10;
		}

		CGRect f =  _refreshBtn.frame;
		f.origin.y = CGRectGetMaxY(_stateLable.frame)+px_scale(49);
		f.size = CGSizeMake(px_scale(152), px_scale(54));
		_refreshBtn.frame = f;
		CGPoint c = _refreshBtn.center;
		c.x = CGRectGetWidth(self.frame)/2.0;
		_refreshBtn.center = c;
	}
}

-(void)setState:(LgPlaceholderState)state {
	[super setState:state];
	_tap.enabled = NO;
	_refreshBtn.hidden = YES;
	_stateImageView.image = nil;
	_stateImageView.frame = CGRectMake(0, 0, px_scale(440), px_scale(340));
	if (_bg_View) {
		CGFloat scale = CGRectGetHeight(_bg_View.frame)/ CGRectGetHeight([UIScreen mainScreen].bounds);
		if (scale <= 0.6) {
			_stateImageView.bounds = CGRectMake(0, 0, px_scale(300), px_scale(250)*scale*2.0);
		}
	}
	[_bg_View bringSubviewToFront:self];
	if (state == LgPlaceNormalState) {
		//正常不显示
		self.hidden = YES;
		self.stateLable.text = @"";
	}else if (state == LgPlaceNoDataState){
		//没有数据
		self.hidden = NO;
		self.stateLable.text = @"这里什么也没有呢";
		_stateImageView.image = [UIImage imageNamed:@"kongym_img"];
		_refreshBtn.hidden = YES;
		self.backgroundColor = [UIColor whiteColor];
		_tap.enabled = YES;
	}else if (state == LgPlaceLoadingState){
		//载入中
		self.hidden = NO;
		self.stateLable.text = @"";
		_stateImageView.image = _gifImage;
		_stateImageView.bounds = CGRectMake(0, 0, px_scale(70), px_scale(70));
	}else if (state == LgPlaceNonetState) {
		//没有网络
		self.hidden = NO;
		_tap.enabled = YES;
		self.stateLable.text = @"哎呀断网了...";
		_stateImageView.image = [UIImage imageNamed:@"mpublic_404_img"];
		_stateImageView.bounds = CGRectMake(0, 0, px_scale(400), px_scale(470));
	}else if(self.state == LgPlaceNoMsgState) {
		self.hidden = NO;
		self.stateLable.text = @"暂无消息~";
		_stateImageView.image =[UIImage imageNamed:@"mine_newskong_img"];
		_refreshBtn.hidden = NO;
		_tap.enabled = YES;
	}else if(self.state == LgPlaceNoSearchState||
		self.state == LgPlaceSearchSoFastState) {
		self.hidden = NO;
		self.stateLable.text = @"无结果";
		_stateImageView.image =[UIImage imageNamed:@"sousuowujieguo_img"];
	}
	NSString *title =  self.customDictionary[[@(state) stringValue]];
	if (title) {
		_stateLable.text = title;
	}
	[self changeSubFrame];
}

@end
