//
//  WorldOfTheBrandDetailCecll.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/23.
//  Copyright © 2019 CY. All rights reserved.
//

#import "WorldOfTheBrandDetailCecll.h"

@implementation WorldOfTheBrandDetailCecll
/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    WorldOfTheBrandDetailCecll *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
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
    [self.contentView addSubview:self.infoLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.left.mas_offset(px_scale(50));
      
       
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoLabel.mas_top);
        make.left.mas_equalTo(self.infoLabel.mas_right).mas_offset(px_scale(8));
        make.right.mas_offset(px_scale(-50));
        make.bottom.mas_offset(px_scale(-30));
    }];
   
    [self.infoLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
  
}
-(void)confingContentLableWithString:(NSString *)ContentString{
    //设置文字两端对齐
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString: ContentString];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle1.alignment=NSTextAlignmentJustified;
    paragraphStyle1.lineSpacing = px_scale(8);
    NSDictionary * dic =@{
        NSParagraphStyleAttributeName:paragraphStyle1,
        NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleNone],
    };
    [attributedString1 setAttributes:dic range:NSMakeRange(0, attributedString1.length)];
    self.contentLabel.attributedText = attributedString1;
}

#pragma mark ——— lazy

- (UILabel *)infoLabel {
    if (!_infoLabel) {
        _infoLabel = [[UILabel alloc]init];
        [_infoLabel setFont:[UIFont systemFontOfSize:13]];
        [_infoLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
        [_infoLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _infoLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setFont:[UIFont systemFontOfSize:13]];
        [_contentLabel setTextColor:[UIColor colorWithHexString:@"333333"]];
        [_contentLabel setTextAlignment:NSTextAlignmentLeft];
        _contentLabel.numberOfLines  = 0;
        
    }
    return _contentLabel;
}
@end
