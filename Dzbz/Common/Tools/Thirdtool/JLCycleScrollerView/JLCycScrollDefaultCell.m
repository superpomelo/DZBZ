//
//  JLCycScrollDefaultCell.m
//  JLCycleScrollView
//
//  Created by yangjianliang on 2017/9/24.
//  Copyright © 2017年 yangjianliang. All rights reserved.
//

#import "JLCycScrollDefaultCell.h"
#import "UIImageView+WebCache.h"
#define SCR_W     [UIScreen mainScreen].bounds.size.width
#define SCR_H     [UIScreen mainScreen].bounds.size.height
#define AppPlaceholderLunboImage   [UIImage imageNamed:@"bg_sign"]

@implementation JLCycScrollDefaultCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor lightGrayColor];
        self.contentView.layer.cornerRadius = 3;
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.blackView];
        [self.contentView addSubview:self.titlesLabel];




    }
    return self;
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.layer.cornerRadius = 3;
        imageView.clipsToBounds = YES;
        imageView.backgroundColor = [UIColor lightGrayColor];
        _imageView = imageView;
    }
    return _imageView;
}

- (UILabel *)titlesLabel{
    if (!_titlesLabel) {
        UILabel *label = [[UILabel alloc] init];
//        self.titlesLabel.frame = CGRectMake(15, self.bounds.size.height-23, SCR_W-140, 18);
        label.frame = CGRectMake(15, self.bounds.size.height-23, SCR_W-140, 18);
        label.textColor = [UIColor whiteColor];
        _titlesLabel = label;
    }
    return _titlesLabel;
}
- (UIView *)blackView{
    if (!_blackView) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, self.bounds.size.height-30, SCR_W-30, 30);
//        self.blackView.frame = CGRectMake(0, self.bounds.size.height-30, SCR_W-30, 30);
        _blackView = view;
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,SCR_W-30,_blackView.bounds.size.height);
        gl.startPoint = CGPointMake(1, 1);
        gl.endPoint = CGPointMake(1, 0);

        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor,(__bridge id)[UIColor clearColor].CGColor];
        gl.locations = @[@(0.0),@(1.0)];

        [_blackView.layer addSublayer:gl];

    }
    return _blackView;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;




}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

/**
 协议方法
 
 @param data 传入的sourceArray[integer]
 */
-(void)setJLCycSrollCellData:(nullable id)data titlesData:(nullable id)titlesdata
{
    if (data) {
        if ([data isKindOfClass:[NSString class]]) {
            if ([data hasPrefix:@"http"]) {
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:data] placeholderImage:AppPlaceholderLunboImage];
            }
        }else if ([data isKindOfClass:[NSURL class]]) {
            [self.imageView sd_setImageWithURL:data placeholderImage:AppPlaceholderLunboImage];
        }else if ([data isKindOfClass:[UIImage class]]) {
            self.imageView.image = data;
        }else{
            NSLog(@"只支持数据类型(NSString,NSURL,UIImage),其他类型可以在DataSource直接根据代理方法[rerturn NSString、NSURL、UIImage],或者dataSource中cel直接设置eg：cell.imageView...然后return nil");
        }
    }
    if (titlesdata) {
//        self.titlesLabel.text = titlesdata;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titlesdata attributes:@{NSFontAttributeName: [UIFont boldSystemFontOfSize:17],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
        self.titlesLabel.attributedText = attributedString;
        
    }
}
@end
