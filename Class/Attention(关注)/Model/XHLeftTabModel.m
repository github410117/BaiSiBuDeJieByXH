//
//  XHLeftTabModel.m
//  BaiSiBuDeJieByXH
//
//  Created by xh on 16/7/11.
//  Copyright © 2016年 xh. All rights reserved.
//

#import "XHLeftTabModel.h"

@implementation XHLeftTabModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}

- (NSMutableArray *)users
{
    if (_users == nil) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
