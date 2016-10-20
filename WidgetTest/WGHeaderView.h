//
//  WGHeaderView.h
//  ICAHomePhoneInternational
//
//  Created by yan on 16/10/18.
//  Copyright © 2016年 ICA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WGHeaderView;
@protocol WGHeaderViewDelegate <NSObject>

@optional
- (void)WGHeaderView:(WGHeaderView *)headerView clickTag:(NSInteger )index;

@end

@interface WGHeaderView : UIView

@property(nonatomic,weak)id<WGHeaderViewDelegate> delegate_;

@end
