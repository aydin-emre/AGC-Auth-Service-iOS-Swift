//
//  Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved
//

#import <Foundation/Foundation.h>
#import <HMFoundation/HMFoundation.h>
#import "AGCToken.h"
#import "AGCTokenSnapshot.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^AGCTokenChangedListenerBlock)(AGCTokenSnapshot *tokenSnapshot);

@protocol AGCAuthProvider <NSObject>

- (HMFTask<AGCToken *> *)getToken;
- (HMFTask<AGCToken *> *)getToken:(BOOL)isForceRefresh;
- (nullable NSString *)getUid;
- (void)addTokenListener:(AGCTokenChangedListenerBlock)listenner;
- (void)removeTokenListener:(AGCTokenChangedListenerBlock)listenner;

@end

NS_ASSUME_NONNULL_END
