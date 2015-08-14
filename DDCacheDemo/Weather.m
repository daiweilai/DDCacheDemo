//
//  Weather.m
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//

#import "Weather.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Tools.h"

@implementation Weather
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        _city = [coder decodeObjectForKey:@"_city"];
        _pinyin = [coder decodeObjectForKey:@"_pinyin"];
        _citycode = [coder decodeObjectForKey:@"_citycode"];
        _date = [coder decodeObjectForKey:@"_date"];
        _time = [coder decodeObjectForKey:@"_time"];
        _postCode = [coder decodeObjectForKey:@"_postCode"];
        _longitude = [coder decodeObjectForKey:@"_longitude"];
        _latitude = [coder decodeObjectForKey:@"_latitude"];
        _altitude = [coder decodeObjectForKey:@"_altitude"];
        _weather = [coder decodeObjectForKey:@"_weather"];
        _temp = [coder decodeObjectForKey:@"_temp"];
        _l_tmp = [coder decodeObjectForKey:@"_l_tmp"];
        _h_tmp = [coder decodeObjectForKey:@"_h_tmp"];
        _WD = [coder decodeObjectForKey:@"_WD"];
        _WS = [coder decodeObjectForKey:@"_WS"];
        _sunrise = [coder decodeObjectForKey:@"_sunrise"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [super encodeWithCoder:coder];
    [coder encodeObject:_city forKey:@"_city"];
    [coder encodeObject:_pinyin forKey:@"_pinyin"];
    [coder encodeObject:_citycode forKey:@"_citycode"];
    [coder encodeObject:_date forKey:@"_date"];
    [coder encodeObject:_time forKey:@"_time"];
    [coder encodeObject:_postCode forKey:@"_postCode"];
    [coder encodeObject:_longitude forKey:@"_longitude"];
    [coder encodeObject:_latitude forKey:@"_latitude"];
    [coder encodeObject:_altitude forKey:@"_altitude"];
    [coder encodeObject:_weather forKey:@"_weather"];
    [coder encodeObject:_temp forKey:@"_temp"];
    [coder encodeObject:_l_tmp forKey:@"_l_tmp"];
    [coder encodeObject:_h_tmp forKey:@"_h_tmp"];
    [coder encodeObject:_WD forKey:@"_WD"];
    [coder encodeObject:_WS forKey:@"_WS"];
    [coder encodeObject:_sunrise forKey:@"_sunrise"];
}

+(void)getWeatherWithDistrictName:(NSString*)name
                        ReturnObj:(void(^)(Weather *obj,NSString* errorMsg))returnBlock
                UpdataImmediately:(BOOL)bol{
    
    NSString* URL = @"http://apis.baidu.com/apistore/weatherservice/weather";//请求地址
    NSString* cacheName = [NSString stringWithFormat:@"%@%@",[URL stringByReplacingOccurrencesOfString:@"/" withString:@"_"],name];
    cacheName = [cacheName stringByReplacingOccurrencesOfString:@":" withString:@""];//使用请求地址当做缓存文件名
    NSDictionary* dic = @{@"citypinyin":name};//请求的参数
    
    if (bol) {//不从缓存恢复 立即更新！
        [self requestDatasWithUrl:URL parameters:dic cacheName:cacheName ReturnObj:^(Weather *obj, NSString *errorMsg) {
            returnBlock(obj,errorMsg);
        }];
        return;
    }
    if ([Tools isFileExistWithFileName:cacheName]) {//缓存文件存在
        Weather* wea = [Tools unarchiverFromTempWithFileName:cacheName];
        if ([wea needToUpdate]) {//判断缓存是否过期
            //过期了 需要更新
            [self requestDatasWithUrl:URL parameters:dic cacheName:cacheName ReturnObj:^(Weather *obj, NSString *errorMsg) {
                returnBlock(obj,errorMsg);
            }];
        }else{
            //缓存没过期
            returnBlock(wea,nil);
        }
    }else{//缓存文件不存在
        [self requestDatasWithUrl:URL parameters:dic cacheName:cacheName ReturnObj:^(Weather *obj, NSString *errorMsg) {
            returnBlock(obj,errorMsg);
        }];
    }
}

/**
 *  请求网络并且进行数据映射(这里应该封装到业务层进行处理)
 *
 *  @param url         地址
 *  @param paras       参数
 *  @param cacheName   缓存名称
 *  @param returnBlock 操作
 */
+ (void)requestDatasWithUrl:(NSString*)url parameters:(NSDictionary*)paras cacheName:(NSString*)cacheName ReturnObj:(void(^)(Weather *obj,NSString* errorMsg))returnBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    __block Weather* wea = [Weather new];
    [manager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
    [manager.requestSerializer setValue:@"6c5ca8bf9db677d0cb12cac76f3ee35e" forHTTPHeaderField:@"apikey"];
    [manager GET:url parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKeyPath:@"errNum"]  isEqual: @0]) {
            wea = [Weather objectWithKeyValues:[responseObject valueForKeyPath:@"retData"]];
            wea.updateTime = [NSDate new];
            wea.cacheDurationTime = 3600;
            wea.needToCache = YES;
            [Tools archiverToTempWithFileName:cacheName Obj:wea];
            returnBlock(wea,nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            returnBlock(nil,operation.responseString);
    }];
}

@end
