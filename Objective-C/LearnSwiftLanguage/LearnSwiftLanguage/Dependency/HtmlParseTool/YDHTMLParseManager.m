//
//  YDHTMLParseManager.m
//  LearnSwiftLanguage
//
//  Created by bob on 16/12/28.
//  Copyright © 2016年 __company__. All rights reserved.
//

#import "YDHTMLParseManager.h"
//#import "Ono.h"

@implementation YDHTMLParseManager

+ (instancetype)sharedManager {
    static YDHTMLParseManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [YDHTMLParseManager new];
    });
    return _sharedManager;
}

@end
