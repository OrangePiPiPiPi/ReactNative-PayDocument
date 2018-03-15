//
//  ReactNativePay.m
//  ReactNativePay
//
//  Created by moker on 2017/4/10.
//  Copyright © 2017年 cxz. All rights reserved.
//

#import "ReactNativePay.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "WXPay.h"
#import "AliPayManager.h"

@implementation ReactNativePay

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(onAliPay:(NSString *)orderString  resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    // NOTE:未安装支付宝客户端走下面方法，安装了不会走
    if (orderString != nil){
        NSString *appScheme = @"ffffffff";//app跳转的Scheme
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            //支付回调
            NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
            if ([resultStatus isEqualToString:@"9000"]){ //订单支付成功
                resolve(@"支付成功");
            }else if([resultStatus isEqualToString:@"6002"]){//网络错误
                reject(resultStatus,@"网络错误",nil);
            }else if([resultStatus isEqualToString:@"6001"]){//中途取消
                reject(resultStatus,@"取消支付",nil);
            }else{//处理失败
                reject(resultStatus,@"支付失败",nil);
            }
        }];
    }
  //NOTE:已安装支付宝客户端走appdelegate回调
  [[AliPayManager sharedManager] setPaySuccess:^(NSDictionary *resultDic, NSString *message) {
    resolve(@"支付成功");
  }];
  [[AliPayManager sharedManager] setPayFailure:^(NSDictionary *resultDic, NSString *message) {
    reject(@"", message,nil);
  }];
}

//微信支付
RCT_EXPORT_METHOD(onWxPay:(NSDictionary *)info resolver:(RCTPromiseResolveBlock)resolve rejecter:(RCTPromiseRejectBlock)reject) {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]] || [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"wechat://"]]) {
        NSLog(@"OK weixin://");
    } else {
        reject(@"-2", @"请先安装微信客户端", nil);
        return;
    }
    [WXApi registerApp:WX_APPKEY];
    [WXPay pay:info success:^(NSDictionary *resultDic, NSString *message) {
        resolve(@"支付成功");
    } failure:^(NSDictionary *resultDic, NSString *message) {
        reject(@"", message,nil);
    }];
}

@end

