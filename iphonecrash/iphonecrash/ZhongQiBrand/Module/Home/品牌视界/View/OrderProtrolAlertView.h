//
//  OrderProtrolAlertView.h
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/22.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderProtrolAlertView : UIView<UIScrollViewDelegate>
/** 背景黑色 */
@property (nonatomic, strong) UIView *maskView;
/** 白色背景 */
@property (nonatomic,strong) UIView *alertView;
/** 标题 */
@property (nonatomic,strong) UILabel *titlelabel;
/** 滚动试图 */
@property (nonatomic,strong) UIScrollView *backView;
/** 内容 */
@property (nonatomic,strong) UILabel *content;
/** 文字 */
@property (nonatomic,copy) NSString *contentString;
/** 滚动条背景 */
@property (nonatomic,strong) UIView *sliderBackView;
/** 滚动条 */
@property (nonatomic,strong) UIView *slider;
/** 标题背景*/
@property (nonatomic,strong) UIImageView *titleBackView;
/** 取消按钮 */
@property (nonatomic,strong) UIButton *offBtn;
/** 快速创建弹框*/
+ (instancetype)showAlertWithContentString:(NSString *)ContentString;

@end

NS_ASSUME_NONNULL_END
