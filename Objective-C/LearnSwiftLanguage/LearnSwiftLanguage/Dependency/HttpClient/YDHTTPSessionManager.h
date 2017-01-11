//
//  YDHTTPSessionManager.h
//  YDNetwork
//
//  Created by bob on 16/2/17.
//  Copyright © 2016年 YDKit. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "YDNetWorkConst.h"

@interface YDHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)requestDataWithPath:(NSString *)aPath
                       andBlock:(void (^)(id data, NSError *error))block;

- (void)requestJsonDataWithPath:(NSString *)aPath
                 withMethodType:(YDNetworkRequestMethod)method
                     withParams:(NSDictionary *)params
                withHttpheaders:(NSDictionary *)headers
                       andBlock:(void (^)(id data, NSError *error))block;

@end
