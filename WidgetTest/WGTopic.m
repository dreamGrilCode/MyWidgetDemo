//
//  WGTopic.m
//  ICAHomePhoneInternational
//
//  Created by yan on 16/10/18.
//  Copyright © 2016年 ICA. All rights reserved.
//

#import "WGTopic.h"

@implementation WGTopic

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
        
    }
    return self;
}

@end
