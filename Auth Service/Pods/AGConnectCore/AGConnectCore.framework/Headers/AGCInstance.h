//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// AGConnect SDK 实例
@interface AGCInstance : NSObject

/// SDK初始化接口，需要在应用的AppDelegate的Launch中调用
+ (void)startUp;

/// 返回单例
+ (instancetype)sharedInstance;

/// 获取指定服务
/// @param protocol 服务接口
- (id _Nullable)getService:(Protocol *)protocol;

@end

NS_ASSUME_NONNULL_END
