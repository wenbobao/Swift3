//
//  YDHTTPSessionManager.m
//  YDNetwork
//
//  Created by bob on 16/2/17.
//  Copyright © 2016年 YDKit. All rights reserved.
//

#import "YDHTTPSessionManager.h"

@implementation YDHTTPSessionManager

+ (instancetype)sharedManager {
    static YDHTTPSessionManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [YDHTTPSessionManager manager];
    });
    return _sharedManager;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    [self.requestSerializer setValue:[self randomUserAgent] forHTTPHeaderField:@"User-Agent"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Host"];
    
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/javascript", @"application/json", @"text/html", @"application/xhtml+xml", @"*/*", @"application/xhtml+xml", @"image/webp", @"text/plain", @"text/application", nil];

    return self;
}

- (NSString *)randomUserAgent {
    
    NSArray * userAgents = @[@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/47.0.2526.106 Safari/537.36",
                             @"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.114 Safari/537.36",
                             @"Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:36.0) Gecko/20100101 Firefox/36.0",
                             @"Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.94 Safari/537.36",
                             @"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_6; en-US) AppleWebKit/533.20.25 (KHTML, like Gecko) Version/5.0.4 Safari/533.20.27"];
    return userAgents[arc4random() % userAgents.count];
}

- (void)requestDataWithPath:(NSString *)aPath
                       andBlock:(void (^)(id data, NSError *error))block
{
    [self requestJsonDataWithPath:aPath withMethodType:YDNetworkRequestMethodGET withParams:nil withHttpheaders:nil andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                 withMethodType:(YDNetworkRequestMethod)method
                     withParams:(NSDictionary *)params
                withHttpheaders:(NSDictionary *)headers
                       andBlock:(void (^)(id data, NSError *error))block {

    if (!aPath || aPath.length <= 0) {
        NSLog(@"Error, no destination aPath");
        return;
    }
    
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    if (headers != nil) {
        for (id httpHeaderField in headers.allKeys) {
            id value = headers[httpHeaderField];
            if ([httpHeaderField isKindOfClass:[NSString class]] && [value isKindOfClass:[NSString class]]) {
                [self.requestSerializer setValue:(NSString *)value forHTTPHeaderField:(NSString *)httpHeaderField];
            } else {
                NSLog(@"Error, class of key/value in headerFieldValueDictionary should be NSString.");
            }
        }
    }

    //发起请求
    switch (method) {
        case YDNetworkRequestMethodGET: {
            [self GET:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                block(nil, error);
            }];
            break;
        }
        case YDNetworkRequestMethodPOST: {
            [self POST:aPath parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                block(nil, error);
            }];
            break;
        }
        case YDNetworkRequestMethodPUT: {
            [self PUT:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                block(responseObject, nil);
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                block(nil, error);
            }];
            break;
        }
        case YDNetworkRequestMethodDELETE: {
            [self DELETE:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                block(nil, error);
            }];
            break;
        }
        case YDNetworkRequestMethodHEAD: {
            [self HEAD:aPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, task.response);
                block(task.response, nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                block(nil, error);
            }];
            break;
        }
        case YDNetworkRequestMethodPATCH: {
            [self PATCH:aPath parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
                block(responseObject, nil);
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"\n===========response===========\n%@:\n%@", aPath, error);
                block(nil, error);
            }];
            break;
        }
        default:
            break;
    }
}

@end
