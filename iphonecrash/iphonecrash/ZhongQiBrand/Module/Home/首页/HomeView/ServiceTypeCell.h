//
//  ServiceTypeCell.h
//  ZhongQiBrand
//
//  Created by iOS on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ServiceTypeCell : UITableViewCell

@property (nonatomic, strong) UILabel *serviceLabel;
@property (nonatomic, strong) UIImageView *serviceImg;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
