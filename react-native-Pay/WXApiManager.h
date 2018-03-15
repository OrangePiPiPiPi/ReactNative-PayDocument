//
//  WXApiManager.h
//  Created by Fan on 17/12/30.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
//支付成功Block的定义
typedef void(^PaySuccess)(NSDictionary *resultDic, NSString* message);
typedef void(^PayFailure)(NSDictionary *resultDic, NSString* message);
@interface WXApiManager : NSObject<WXApiDelegate>
@property (nonatomic,copy)PayFailure payFailure;
@property (nonatomic,copy)PaySuccess paySuccess;
+ (instancetype)sharedManager;

@end
