//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * 配置读取工具类
 *
 * 使用说明：
 * 一、按如下步骤使用此工具类，读取Xcode工程根目录下"agconnect-services.plist"配置文件：
 * 1、初始化：AGCServicesConfig *config = [AGCServicesConfig sharedInstance];
 * 2、读取配置项：NSString value = [config getString:path];
 *
 * 二、按如下步骤使用此工具类，读取-overlayWith:指定的配置内容：
 * 1、初始化：AGCServicesConfig *config = [AGCServicesConfig sharedInstance];
 * 2、指定配置内容：[config overlayWith:input];
 * 3、读取配置项：NSString value = [config getString:path];
 *
 */
@interface AGCServicesConfig : NSObject

/**
 * 获取AGCServicesConfig单例。
 *
 * @return 返回AGCServicesConfig单例。
 */
+ (instancetype)sharedInstance;

/**
 * 指定配置内容。
 *
 * @param inputDict 指定的配置内容。
 */
- (void)overlayWith:(NSDictionary *)inputDict;

/**
 * 获取指定配置项的值。
 *
 * @param path 指定配置项。
 * @return 返回指定配置项的值，不存在返回def。
 */
- (BOOL)getBoolean:(NSString *)path;

/**
 * 获取指定配置项的值。
 *
 * @param path 指定配置项。
 * @param def 指定默认值。
 * @return 返回指定配置项的值，不存在返回def。
 */
- (BOOL)getBoolean:(NSString *)path withDefault:(BOOL)def;

/**
 * 获取指定配置项的值。
 *
 * @param path 指定配置项。
 * @return 返回指定配置项的值，不存在返回def。
 */
- (NSInteger)getInt:(NSString *)path;

/**
 * 获取指定配置项的值。
 *
 * @param path 指定配置项。
 * @param def 指定默认值。
 * @return 返回指定配置项的值，不存在返回def。
 */
- (NSInteger)getInt:(NSString *)path withDefault:(NSInteger)def;

/**
 * 获取指定配置项的值。
 *
 * @param path 指定配置项。
 * @return 返回指定配置项的值，不存在返回def。
 */
- (NSString *)getString:(NSString *)path;

/**
 * 获取指定配置项的值。
 *
 * @param path 指定配置项。
 * @param def 指定默认值。
 * @return 返回指定配置项的值，不存在返回def。
 */
- (NSString *)getString:(NSString *)path withDefault:(nullable NSString *)def;

@end

NS_ASSUME_NONNULL_END
