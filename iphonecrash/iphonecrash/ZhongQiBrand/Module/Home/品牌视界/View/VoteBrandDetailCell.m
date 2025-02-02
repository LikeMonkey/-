//
//  VoteBrandDetailCell.m
//  ZhongQiBrand
//
//  Created by ios 001 on 2019/10/18.
//  Copyright © 2019 CY. All rights reserved.
//

#import "VoteBrandDetailCell.h"
@implementation VoteBrandDetailCell
/* 快速创建Cell */
+(instancetype)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)cellIdentifier indexPath:(NSIndexPath *)indexPath{
    
    VoteBrandDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
    
}
/* 自定义Cell */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self){
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self setUpView];
    }
    return self;
}

-(void)setUpView{
    
    
    self.cycleImage = [[UIImageView alloc]init];
    [self.cycleImage setImage:[UIImage imageNamed:@"ppsj_ppxq_dzqq_img"]];
    [self.contentView addSubview:self.cycleImage];
    [self.cycleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(px_scale(57));
        make.height.width.mas_equalTo(px_scale(26));
    }];
    
    
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_equalTo(self.cycleImage.mas_right).mas_offset(px_scale(10));
    }];
    
    [self.contentView addSubview:self.textLab];
    [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLabel.mas_top);
        make.left.mas_equalTo(self.contentLabel.mas_right).mas_offset(px_scale(8));
        make.right.mas_offset(px_scale(-50));
        make.bottom.mas_offset(px_scale(-30));
    }];
    //抗压缩
    [self.contentLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.textLab setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}
-(void)confingTextLableWithString:(NSString *)ContentString{
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
    self.textLab.attributedText = attributedString1;
}

#pragma mark ——— lazy

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        [_contentLabel setFont:[UIFont systemFontOfSize:13]];
        [_contentLabel setTextColor:[UIColor colorWithHexString:@"#666666"]];
        [_contentLabel setTextAlignment:NSTextAlignmentLeft];
    }
    return _contentLabel;
}

- (UILabel *)textLab {
    if (!_textLab) {
        _textLab = [[UILabel alloc]init];
        [_textLab setFont:[UIFont systemFontOfSize:13]];
        [_textLab setTextColor:[UIColor colorWithHexString:@"333333"]];
        [_textLab setTextAlignment:NSTextAlignmentLeft];
        _textLab.numberOfLines  = 0;
        
    }
    return _textLab;
}
@end
