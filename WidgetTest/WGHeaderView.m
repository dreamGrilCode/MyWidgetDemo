//
//  WGHeaderView.m
//  ICAHomePhoneInternational
//
//  Created by yan on 16/10/18.
//  Copyright © 2016年 ICA. All rights reserved.
//

#import "WGHeaderView.h"
#import "WGButton.h"

#define ios10_later [[UIDevice currentDevice].systemVersion doubleValue] >= 10.0
@implementation WGHeaderView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        CGFloat magin = 10;
        CGFloat btnW = (frame.size.width - 6 * magin)/4;
        CGFloat btnH = frame.size.height - 2 * magin;
        NSArray *infoArr = [NSArray array];
        if (ios10_later) {
            
            infoArr = @[
                                 @{@"imageName":@"diagnosis_wg",
                                   @"title":@"诊疗中心"
                                   },
                                 @{@"imageName":@"season_wg",
                                   @"title":@"时令养生"
                                   },
                                 @{@"imageName":@"test_wg",
                                   @"title":@"体质测试"
                                   },
                                 @{@"imageName":@"game_wg",
                                   @"title":@"游戏"
                                   },
                                 ];
        }else{
        
            infoArr = @[
                        @{@"imageName":@"diagnosis_wg9",
                          @"title":@"诊疗中心"
                          },
                        @{@"imageName":@"season_wg9",
                          @"title":@"时令养生"
                          },
                        @{@"imageName":@"test_wg9",
                          @"title":@"体质测试"
                          },
                        @{@"imageName":@"game_wg9",
                          @"title":@"游戏"
                          }
                        ];
        }
        for (int i = 0; i < 4; i ++) {
            
            WGButton *btn = [[WGButton alloc] initWithFrame:CGRectMake(magin * (i + 1) + btnW * i, magin , btnW , btnH)];
            [btn setImage:[UIImage imageNamed:infoArr[i][@"imageName"]] forState:UIControlStateNormal];
            [btn setTitle:infoArr[i][@"title"] forState:UIControlStateNormal];
            if (ios10_later) {
                
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }else{
            
                [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = i;
            [self addSubview:btn];
            
            
        }
    }
    return self;
}
- (void)onClick:(UIButton *)btn{

    if ([self.delegate_ respondsToSelector:@selector(WGHeaderView:clickTag:)]) {
        
        [self.delegate_ WGHeaderView:self clickTag:btn.tag];
    }
}
@end
