//
//  WGTableCell.m
//  ICAHomePhoneInternational
//
//  Created by yan on 16/10/17.
//  Copyright © 2016年 ICA. All rights reserved.
//

#import "WGTableCell.h"
#import "UIImageView+WebCache.h"
#import "WGTopic.h"

#define screenW [UIScreen mainScreen].bounds.size.width

@interface WGTableCell()

@property(nonatomic, weak)UIImageView *image_view;
@property(nonatomic, weak)UILabel  *title_Lab;
@property(nonatomic, weak)UILabel  *subtitle_Lab;

@end

@implementation WGTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.8)];
        lineView.backgroundColor = [UIColor grayColor];
        lineView.layer.opacity = 0.5;
        [self addSubview:lineView];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 5;
        [self addSubview:imageView];
        self.image_view = imageView;
        
        UILabel *title_lab = [[UILabel alloc] init];
        title_lab.textColor = [UIColor blackColor];
        title_lab.numberOfLines = 1;
        title_lab.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:title_lab];
        self.title_Lab = title_lab;
        
        UILabel *subtitle_lab = [[UILabel alloc] init];
        subtitle_lab.textColor = [UIColor blackColor];
        subtitle_lab.numberOfLines = 2;
        subtitle_lab.font = [UIFont systemFontOfSize:13];
        [self addSubview:subtitle_lab];
        self.subtitle_Lab = subtitle_lab;
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
- (void)tap{

    if ([self.delegate_ respondsToSelector:@selector(WGTableCell:topic:)]) {
        
        [self.delegate_ WGTableCell:self topic:self.topic];
    }
}
- (void)setCellH:(CGFloat)cellH{

    _cellH = cellH;
    [self setView];
}
- (void)setView{

    CGFloat magin = 5;
    CGFloat imageH = self.cellH - 2 * magin;
    CGFloat imageW = imageH * 5/4;
    self.image_view.frame = CGRectMake(magin, magin, imageW, imageH);
    
    CGFloat labX = CGRectGetMaxX(self.image_view.frame) + magin;
    CGFloat labW = self.bounds.size.width - labX - magin * 4;
    CGFloat labH = 15;
    self.title_Lab.frame = CGRectMake(labX, magin * 2, labW, labH);
    
    CGFloat labY = labH + magin *2;
    self.subtitle_Lab.frame = CGRectMake(labX, labY, labW, imageH - labH);
}

- (void)setTopic:(WGTopic *)topic{

    _topic = topic;
    [self.image_view sd_setImageWithURL:[NSURL URLWithString:topic.cover]];
    self.title_Lab.text = topic.title;
    self.subtitle_Lab.text = topic.subtitle;
    
}

@end
