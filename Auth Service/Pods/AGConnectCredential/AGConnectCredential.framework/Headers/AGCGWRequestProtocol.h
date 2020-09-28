//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#import <HMFoundation/HMFoundation.h>
#import "AGCModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

/// AGC网关请求协议
@protocol AGCGWRequestProtocol <NSObject>

/// 请求方法
- (NSString *)GWMethod;

/// 请求url路径,无需host
- (NSString *)GWURLString;

@optional

/// 请求体
- (NSDictionary *_Nullable)GWBody;

/// 请求参数
- (NSDictionary<NSString *, NSString *> *_Nullable)GWQuerys;

/// 请求头
- (NSDictionary<NSString *, NSString *> *_Nullable)GWHeaders;

/// 请求超时时间
- (NSTimeInterval)GWTimeout;

/// 返回数据的解析类
- (Class<AGCModelProtocol> _Nullable)responseClass;

@end

NS_ASSUME_NONNULL_END
