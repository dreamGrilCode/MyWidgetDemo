//
//  WGButton.m
//  ICAHomePhoneInternational
//
//  Created by yan on 16/10/18.
//  Copyright © 2016年 ICA. All rights reserved.
//

#import "WGButton.h"

@implementation WGButton


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel.font = [UIFont systemFontOfSize: 14];
    }
    return self;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    // 设置图片的位置
    CGRect frame =  self.imageView.frame;
    frame.size.width = self.imageView.bounds.size.width;
    frame.size.height = self.imageView.bounds.size.width;
    frame.origin.x = (self.frame.size.width - self.imageView.bounds.size.width)/2;
    frame.origin.y = 10;
    self.imageView.frame = frame;
    
    // 设置label位置
    CGRect frame_lab = self.titleLabel.frame;
    frame_lab.origin.x = 0;
    frame_lab.origin.y = CGRectGetMaxY(self.imageView.frame) + 5;
    frame_lab.size.width = self.frame.size.width;
    frame_lab.size.height = self.frame.size.height - CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.frame = frame_lab;
    
    
}

@end
