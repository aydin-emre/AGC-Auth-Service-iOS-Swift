//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#import <HMFoundation/HMFoundation.h>
#import "AGCBackend.h"
#import "AGCGWRequestProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/// AGC 网关请求
@interface AGCGWBackend : AGCBackend

/// 单例对象
+ (instancetype)sharedInstance;

/// 发送网络请求
/// @param request 实现AGCGWRequestProtocol协议的请求类
- (HMFTask *)send:(id<AGCGWRequestProtocol>)request;

/// 发送网络请求
/// @param method 请求方法
/// @param URLString 请求URL
/// @param body 请求体
/// @param querys query参数
/// @param headers 请求头
/// @param timeout 请求超时时间
/// @param responseClass 返回数据的解析类
- (HMFTask *)send:(NSString *)method
        URLString:(NSString *)URLString
             body:(id _Nullable)body
           querys:(NSDictionary<NSString *, NSString *> *_Nullable)querys
          headers:(NSDictionary<NSString *, NSString *> *_Nullable)headers
          timeout:(NSTimeInterval)timeout
         response:(Class<AGCModelProtocol> _Nullable)responseClass;

/// 发送网络请求，会在请求中添加认证字段
/// @param request 实现AGCGWRequestProtocol协议的请求类
- (HMFTask *)sendWithToken:(id<AGCGWRequestProtocol>)request;

/// 发送网络请求，会在请求中添加认证字段
/// @param method 请求方法
/// @param URLString 请求URL
/// @param body 请求体, 支持NSString，NSArray，NSDictionary类型
/// @param querys query参数
/// @param headers 请求头
/// @param timeout 请求超时时间
/// @param responseClass 返回数据的解析类，传nil表示返回原始结果
- (HMFTask *)sendWithToken:(NSString *)method
                 URLString:(NSString *)URLString
                      body:(id _Nullable)body
                    querys:(NSDictionary<NSString *, NSString *> *_Nullable)querys
                   headers:(NSDictionary<NSString *, NSString *> *_Nullable)headers
                   timeout:(NSTimeInterval)timeout
                  response:(Class<AGCModelProtocol> _Nullable)responseClass;
@end

NS_ASSUME_NONNULL_END
