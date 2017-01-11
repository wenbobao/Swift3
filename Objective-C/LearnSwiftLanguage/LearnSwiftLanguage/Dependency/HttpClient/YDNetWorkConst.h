//
//  YDNetWorkConst.h
//  YDNetwork
//
//  Created by bob on 15/7/18.
//  Copyright (c) 2015年 YDKit. All rights reserved.
//

/**
 *  任务类型
 */
typedef NS_ENUM(NSUInteger, YDNetworkTaskType) {
    /**
     *  请求http接口
     */
    YDNetworkTaskTypeHttpRequest,
    /**
     *  下载文件
     */
    YDNetworkTaskTypeDownloadFile,
    /**
     *  上传文件
     */
    YDNetworkTaskTypeUploadFile,
};

/**
 *  请求类型
 */
typedef NS_ENUM(NSUInteger, YDNetworkRequestMethod) {

    YDNetworkRequestMethodGET,

    YDNetworkRequestMethodPOST,

    YDNetworkRequestMethodHEAD,

    YDNetworkRequestMethodPUT,

    YDNetworkRequestMethodDELETE,

    YDNetworkRequestMethodPATCH,
};

/**
 *  Request Serializer类型
 */
typedef NS_ENUM(NSUInteger, YDNetworkRequestSerializerType) {
    YDNetworkRequestSerializerTypeHTTP,
    YDNetworkRequestSerializerTypeJSON,
};

/**
 *  Response Serializer类型
 */
typedef NS_ENUM(NSUInteger, YDNetworkResponseSerializerType) {
    YDNetworkResponseSerializerTypeJSON,
    YDNetworkResponseSerializerTypeHTTP,
};

/**
 *  任务状态
 */
typedef NS_ENUM(NSUInteger, YDNetworkTaskState) {
    /**
     *  请求等待中
     */
    YDNetworkTaskStateWait,
    /**
     *  请求开始
     */
    YDNetworkTaskStateBegin,
    /**
     *  请求中
     */
    YDNetworkTaskStateLoading,
    /**
     *  请求成功
     */
    YDNetworkTaskStateSuccess,
    /**
     *  请求失败
     */
    YDNetworkTaskStateFaild,
    /**
     *  请求取消
     */
    YDNetworkTaskStateCancel,
};

/**
 *  网络底层错误类型
 */
typedef NS_ENUM(NSUInteger, YDNetworkInnerError) {
    /**
     *  无网络连接
     */
    YDNetworkInnerErrorNotConnectInternet,
    /**
     *  服务器逻辑错误
     */
    YDNetworkInnerErrorServiceError,
};



