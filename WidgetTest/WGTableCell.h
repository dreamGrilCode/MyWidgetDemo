//
//  WGTableCell.h
//  ICAHomePhoneInternational
//
//  Created by yan on 16/10/17.
//  Copyright © 2016年 ICA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WGTopic,WGTableCell;

@protocol WGTableCellDelegate <NSObject>

@optional
- (void)WGTableCell:(WGTableCell *)cell topic:(WGTopic *)topic;

@end

@interface WGTableCell : UIView

@property(nonatomic,assign)CGFloat cellH;
@property(nonatomic,strong)WGTopic *topic;
@property(nonatomic,weak)id<WGTableCellDelegate> delegate_;
@end
