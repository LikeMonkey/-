//
//  GiftOrderInfoCell.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/21.
//  Copyright © 2019 CY. All rights reserved.
//

#import "GiftOrderInfoCell.h"

@implementation GiftOrderInfoCell

/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    GiftOrderInfoCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
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
    [self.contentView addSubview:self.infolabel];
    [self.contentView addSubview:self.numLabel];
    [self.infolabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.left.mas_offset(px_scale(30));
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.right.mas_offset(px_scale(-30));
    }];
    
}
#pragma mark ——— lazy

- (UILabel *)infolabel {
    if (!_infolabel) {
        _infolabel = [[UILabel alloc]init];
        [_infolabel setFont:[UIFont boldSystemFontOfSize:15]];
        _infolabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _infolabel.textAlignment = NSTextAlignmentLeft;
    }
    return _infolabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [[UILabel alloc]init];
        [_numLabel setFont:[UIFont boldSystemFontOfSize:15]];
        _numLabel.textColor = [UIColor colorWithHexString:@"#333333"];
        _numLabel.textAlignment = NSTextAlignmentRight;
    }
    return _numLabel;
}
@end
