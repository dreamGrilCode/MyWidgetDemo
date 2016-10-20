//
//  WGTopic.h
//  ICAHomePhoneInternational
//
//  Created by yan on 16/10/18.
//  Copyright © 2016年 ICA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WGTopic : NSObject
@property(nonatomic,assign)NSInteger id;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *date;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *subtitle;
@property(nonatomic,strong)NSString *summary;
@property(nonatomic,strong)NSString *cover;
@property(nonatomic,strong)NSString *url;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
