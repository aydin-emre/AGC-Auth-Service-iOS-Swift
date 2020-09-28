//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 网关返回的错误，只针对NSURLErrorBadServerResponse场景进行处理
@interface AGCGWError : NSError

/// 错误码
@property(nonatomic, readonly) NSInteger agcCode;

/// 错误信息
@property(nonatomic, readonly) NSString *agcMessage;

/// 初始化
/// @param error 原始错误
/// @param code agc网关错误码
/// @param message agc的错误信息
- (instancetype)initWithOriginalError:(NSError *)error
                                 code:(NSInteger)code
                              message:(NSString *)message;

/// 初始化
/// @param error 原始错误
/// @param code agc网关错误码
/// @param message agc的错误信息
+ (instancetype)errorWithOriginalError:(NSError *)error
                                  code:(NSInteger)code
                               message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
