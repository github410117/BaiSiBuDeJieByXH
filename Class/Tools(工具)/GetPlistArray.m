//
//  GetPlistArray.m
//  TeamDemo
//
//  Created by xh on 16/6/5.
//  Copyright © 2016年 etcxm. All rights reserved.
//

#import "GetPlistArray.h"

@implementation GetPlistArray

+ (NSArray *)arrayWithString:(NSString *)string{
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    return array;
}

@end
