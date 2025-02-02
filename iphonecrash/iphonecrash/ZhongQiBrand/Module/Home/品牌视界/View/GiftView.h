//
//  text.h
//  giftDemo
//
//  Created by ios 001 on 2019/10/11.
//  Copyright © 2019 flymanshow. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol GiftViewDelegate <NSObject>

@required // 必须实现的方法 默认

@optional // 可选实现的方法
- (void)SuccessClickSengBtnWithGiftIndex:(NSInteger)indexNum AndGiftNum:(NSInteger)giftNum;

@end


@interface GiftView : UIView

/** 送礼物标题 */
@property (nonatomic,strong) UILabel *title;
/**荣誉勋章  */
@property(nonatomic,strong)UILabel *honerLabel;
/** 减号*/
@property (nonatomic,strong) UIButton *DownBtn;
/** 加号 */
@property (nonatomic,strong) UIButton *UpBtn;
/** 数量 */
@property (nonatomic,strong) UILabel *giftNum;
/** 票数 */
@property (nonatomic,strong) UILabel *ticketsNum;
/** 合计 */
@property (nonatomic,strong) UILabel *totalNum;
/** 底部btn */
@property (nonatomic,strong) UIButton *sendBtn;
/** 选中 的礼物index */
@property (nonatomic,strong) NSIndexPath* selectedIndex;
/** 代理 */
@property(nonatomic, weak) id<GiftViewDelegate> delegate;

-(void)show;
-(void)hiddenGiftView;

@end
