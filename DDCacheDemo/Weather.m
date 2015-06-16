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
        _prov = [coder decodeObjectForKey:@"_prov"];
        _windDirection = [coder decodeObjectForKey:@"_windDirection"];
        _temp = [coder decodeObjectForKey:@"_temp"];
        _humidity = [coder decodeObjectForKey:@"_humidity"];
        _img_2 = [coder decodeObjectForKey:@"_img_2"];
        _refreshTime = [coder decodeObjectForKey:@"_refreshTime"];
        _weather = [coder decodeObjectForKey:@"_weather"];
        _city = [coder decodeObjectForKey:@"_city"];
        _maxTemp = [coder decodeObjectForKey:@"_maxTemp"];
        _district = [coder decodeObjectForKey:@"_district"];
        _dateTime = [coder decodeObjectForKey:@"_dateTime"];
        _areaid = [coder decodeObjectForKey:@"_areaid"];
        _minTemp = [coder decodeObjectForKey:@"_minTemp"];
        _img_1 = [coder decodeObjectForKey:@"_img_1"];
        _windForce = [coder decodeObjectForKey:@"_windForce"];
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [super encodeWithCoder:coder];
    [coder encodeObject:_prov forKey:@"_prov"];
    [coder encodeObject:_windDirection forKey:@"_windDirection"];
    [coder encodeObject:_temp forKey:@"_temp"];
    [coder encodeObject:_humidity forKey:@"_humidity"];
    [coder encodeObject:_img_2 forKey:@"_img_2"];
    [coder encodeObject:_refreshTime forKey:@"_refreshTime"];
    [coder encodeObject:_weather forKey:@"_weather"];
    [coder encodeObject:_city forKey:@"_city"];
    [coder encodeObject:_maxTemp forKey:@"_maxTemp"];
    [coder encodeObject:_district forKey:@"_district"];
    [coder encodeObject:_dateTime forKey:@"_dateTime"];
    [coder encodeObject:_areaid forKey:@"_areaid"];
    [coder encodeObject:_minTemp forKey:@"_minTemp"];
    [coder encodeObject:_img_1 forKey:@"_img_1"];
    [coder encodeObject:_windForce forKey:@"_windForce"];
}

+(void)getWeatherWithDistrictName:(NSString*)name
                        ReturnObj:(void(^)(Weather *obj,NSString* errorMsg))returnBlock
                UpdataImmediately:(BOOL)bol{
    
    NSString* URL = @"http://api.36wu.com/Weather/GetWeather";//请求地址
    //使用请求地址当做缓存文件名
    NSString* cacheName = [NSString stringWithFormat:@"%@%@",[URL stringByReplacingOccurrencesOfString:@"/" withString:@"_"],name];
    cacheName = [cacheName stringByReplacingOccurrencesOfString:@":" withString:@""];
    
    if (bol) {//不从缓存恢复 立即更新！
        __block Weather* wea = [Weather new];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"http://api.36wu.com/Weather/GetWeather" parameters:@{@"district":name,@"format":@"json"} success:^(AFHTTPRequestOperation *operation, id responseObject){
            if ([[responseObject valueForKeyPath:@"status"]  isEqual: @200]) {
                wea = [Weather objectWithKeyValues:[responseObject valueForKeyPath:@"data"]];
                wea.updateTime = [NSDate new];
                wea.cacheDurationTime = 3600;
                wea.needToCache = YES;
                [Tools archiverToTempWithFileName:cacheName Obj:wea];
                returnBlock(wea,nil);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            returnBlock(nil,operation.responseString);
        }];
        return;
    }
    
    //缓存文件存在
    if ([Tools isFileExistWithFileName:cacheName]) {
        __block Weather* wea = [Tools unarchiverFromTempWithFileName:cacheName];
        if ([wea needToUpdate]) {//判断缓存是否过期
            //过期了 需要更新
            AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
            [manager POST:@"http://api.36wu.com/Weather/GetWeather" parameters:@{@"district":name,@"format":@"json"} success:^(AFHTTPRequestOperation *operation, id responseObject){
                if ([[responseObject valueForKeyPath:@"status"]  isEqual: @200]) {
                    wea = [Weather objectWithKeyValues:[responseObject valueForKeyPath:@"data"]];
                    wea.updateTime = [NSDate new];
                    wea.cacheDurationTime = 3600;
                    wea.needToCache = YES;
                    [Tools archiverToTempWithFileName:cacheName Obj:wea];
                    returnBlock(wea,nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                returnBlock(nil,operation.responseString);
            }];
        }else{
            //缓存没过期
            returnBlock(wea,nil);
        }
    }else{//缓存文件不存在
        __block Weather* wea = [Weather new];
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager POST:@"http://api.36wu.com/Weather/GetWeather" parameters:@{@"district":name,@"format":@"json"} success:^(AFHTTPRequestOperation *operation, id responseObject){
            if ([[responseObject valueForKeyPath:@"status"]  isEqual: @200]) {
                wea = [Weather objectWithKeyValues:[responseObject valueForKeyPath:@"data"]];
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
}
@end
