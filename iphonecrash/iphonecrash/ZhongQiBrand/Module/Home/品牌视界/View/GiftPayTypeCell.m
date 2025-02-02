//
//  GiftPayTypeCell.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "GiftPayTypeCell.h"

@implementation GiftPayTypeCell
/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    GiftPayTypeCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
/* 自定义Cell */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self setUpView];
    }
    return self;
}
-(void)setUpView{
    [self.contentView addSubview:self.payType];
    [self.contentView addSubview:self.payName];
    [self.payType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_offset(px_scale(30));
        make.height.width.mas_equalTo(px_scale(50));
    }];
    [self.payName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.payType);
        make.left.mas_equalTo(self.payType.mas_right).mas_offset(px_scale(30));
    }];
}
#pragma mark ——— lazy

- (UIImageView *)payType {
    if (!_payType) {
        _payType = [[UIImageView alloc]init];
    }
    return _payType;
}

- (UILabel *)payName {
    if (!_payName) {
        _payName = [[UILabel alloc]init];
        [_payName setFont:[UIFont systemFontOfSize:15]];
        _payName.textColor = [UIColor colorWithHexString:@"#333333"];
        _payName.textAlignment = NSTextAlignmentLeft;
    }
    return _payName;
}
@end
