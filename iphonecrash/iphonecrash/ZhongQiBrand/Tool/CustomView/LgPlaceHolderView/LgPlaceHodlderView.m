//
//  LgPlaceHodlderView.m
//  ScrollPage
//
//  Created by ios2 on 2019/4/8.
//  Copyright © 2019 LenSky. All rights reserved.
//

#import "LgPlaceHodlderView.h"

@implementation LgPlaceHodlderView
// ========== 初始化 ========= 方法 ================
-(instancetype)init
{
	self =  [super init];
	if (self) {
		_tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapAction:)];
		[self addGestureRecognizer:_tap];
		[self pearance];
	}
	return self;
}

-(void)onTapAction:(UITapGestureRecognizer *)tap
{
	//点击状态
	if (tap.state == UIGestureRecognizerStateEnded){
		//点击手势执行
		if (self.actionBlock) {
			self.actionBlock(self.state);
		}
	}
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
	[super willMoveToSuperview:newSuperview];
	[self removeKvo];
	if (_bg_View != newSuperview) {
		_bg_View = newSuperview;
		[self changeFrame];
		[self addKvo];
	}
}
-(void)addKvo
{
	[_bg_View addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:nil];
	if ([_bg_View isKindOfClass:[UIScrollView class]]) {
		[_bg_View addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
	}
}
-(void)removeKvo
{
	[self.superview removeObserver:self forKeyPath:@"bounds"];
	if ([self.superview isKindOfClass:[UIScrollView class]]) {
		[self.superview removeObserver:self forKeyPath:@"contentSize"];
	}
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"bounds"]||[keyPath isEqualToString:@"contentSize"]) {
		[self setNeedsLayout];
	}
}
-(void)changeFrame
{
	if (_bg_View) {
		UIEdgeInsets edg = self.placeEdgeInsets;
		CGFloat h = CGRectGetHeight(_bg_View.bounds);
		CGFloat w = CGRectGetWidth(_bg_View.bounds);
		CGRect f = self.frame;
		f.origin.x = edg.left;
		f.origin.y = edg.top;
		f.size.width = w - f.origin.x - edg.right;
		f.size.height = h - f.origin.y - edg.bottom;
		self.frame = f;
	}
}

// 调用子类初始化方法
-(void)pearance {}

-(void)layoutSubviews
{
	[super layoutSubviews];
	[self changeFrame];
}

// ==================================
-(void)setPlaceEdgeInsets:(UIEdgeInsets)placeEdgeInsets {
	_placeEdgeInsets = placeEdgeInsets;
	[self setNeedsLayout];
}

-(void)setTop:(CGFloat)top {
	_top = top;
	UIEdgeInsets edg = self.placeEdgeInsets;
	edg.top = top;
	self.placeEdgeInsets = edg;
}
-(void)setLeft:(CGFloat)left {
	_left = left;
	UIEdgeInsets edg = self.placeEdgeInsets;
	edg.left = left;
	self.placeEdgeInsets = edg;
}
-(void)setBottom:(CGFloat)bottom
{
	_bottom = bottom;
	UIEdgeInsets edg = self.placeEdgeInsets;
	edg.bottom = bottom;
	self.placeEdgeInsets = edg;
}
-(void)setRight:(CGFloat)right
{
	_right = right;
	UIEdgeInsets edg = self.placeEdgeInsets;
	edg.right = right;
	self.placeEdgeInsets = edg;
}
-(NSMutableDictionary *)customDictionary
{
	if (!_customDictionary) {
		_customDictionary = [[NSMutableDictionary alloc]init];
	}
	return _customDictionary;
}
//为修改占位文字设置kvc
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
	if (value&&key) {
		[self.customDictionary setObject:value forKey:key];
	}
}


@end
