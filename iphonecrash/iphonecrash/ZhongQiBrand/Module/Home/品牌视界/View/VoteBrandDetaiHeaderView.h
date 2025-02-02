//
//  VoteBrandDetaiHeaderView.h
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VoteBrandDetaiHeaderView : UIView
/** 背景 */
@property (nonatomic,strong) UIImageView *bgImageView;
/** 白色背景 */
@property (nonatomic,strong) UIImageView  *bgView;
/** 品牌图片 */
@property (nonatomic,strong) UIImageView *icon;
/** 名称 */
@property (nonatomic,strong) UILabel *brandName;
/** 二维码 */
@property (nonatomic,strong) UIButton *qRBtn;
/** 排名数 */
@property (nonatomic,strong) UILabel *rankNum;
/** 票数 */
@property (nonatomic,strong) UILabel *ticketsNum;
/** 距离上一票 */
@property (nonatomic,strong) UILabel *fromUpNum;
/** 排名 */
@property (nonatomic,strong) UILabel *rank;
/** 当前票数 */
@property (nonatomic,strong) UILabel *tickets;
/** 距上一票 */
@property (nonatomic,strong) UILabel *fromUp;
/** 竖线1 */
@property (nonatomic,strong) UIView *line1;
/** 竖线2 */
@property (nonatomic,strong) UIView *line2;
/** 品牌详情文字 */
@property (nonatomic,strong) UILabel *BrandDetail;
/** 底部线 */
@property (nonatomic,strong) UIView *bottomView;
@end

NS_ASSUME_NONNULL_END
