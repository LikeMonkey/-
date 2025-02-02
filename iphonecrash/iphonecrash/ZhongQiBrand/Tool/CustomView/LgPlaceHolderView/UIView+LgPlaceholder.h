//
//  UIView+LgPlaceholder.h
//  ScrollPage
//
//  Created by ios2 on 2019/4/8.
//  Copyright © 2019 LenSky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LgPlaceStateView.h"
#import "UIScrollView+Bottom.h"
@interface UIView (LgPlaceholder)

@property (nonatomic,strong)LgPlaceHodlderView *lgPlaceholder;

@end


/*
 LgPlaceNormalState    =   0, //正常状态
 LgPlaceNonetState       =  1, //没有网络状态     //没有
 LgPlaceNoDataState     =  2,//没有数据状态     //有
 LgPlaceLoadingState     =  3, //加载中状态       //没有
 LgPlaceNoMsgState       = 4, //没有消息状态
 LgPlaceNoSearchState    = 5,  // 搜索无结果    // 没有按钮
 LgPlaceSearchSoFastState    = 6  // 搜索太快无结果

 # 加载中
 view.lgPlaceholder.state = LgPlaceLoadingState; 执行加载动画

 # 点击
 view.lgPlaceholder.actionBlock = ^(LgPlaceholderState state){
  if(state != LgPlaceLoadingState){
    weakView.lgPlaceholder.state = LgPlaceLoadingState;
  }
 };

 */
