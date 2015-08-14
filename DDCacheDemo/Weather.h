//
//  Weather.h
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//


#import "BaseModel.h"

/*
 city: "北京", //城市
 pinyin: "beijing", //城市拼音
 citycode: "101010100",  //城市编码
 date: "15-02-11", //日期
 time: "11:00", //发布时间
 postCode: "100000", //邮编
 longitude: 116.391, //经度
 latitude: 39.904, //维度
 altitude: "33", //海拔
 weather: "晴",  //天气情况
 temp: "10", //气温
 l_tmp: "-4", //最低气温
 h_tmp: "10", //最高气温
 WD: "无持续风向",	 //风向
 WS: "微风(<10m/h)", //风力
 sunrise: "07:12", //日出时间
 sunset: "17:44" //日落时间
 */

@interface Weather : BaseModel
@property(nonatomic,strong)NSString* city;
@property(nonatomic,strong)NSString* pinyin;
@property(nonatomic,strong)NSString* citycode;
@property(nonatomic,strong)NSString* date;
@property(nonatomic,strong)NSString* time;
@property(nonatomic,strong)NSString* postCode;
@property(nonatomic,strong)NSString* longitude;
@property(nonatomic,strong)NSString* latitude;
@property(nonatomic,strong)NSString* altitude;
@property(nonatomic,strong)NSString* weather;
@property(nonatomic,strong)NSString* temp;
@property(nonatomic,strong)NSString* l_tmp;
@property(nonatomic,strong)NSString* h_tmp;
@property(nonatomic,strong)NSString* WD;
@property(nonatomic,strong)NSString* WS;
@property(nonatomic,strong)NSString* sunrise;
@property(nonatomic,strong)NSString* sunset;



/**
 *  sunrisesunset*
 *  @param name        需要查询天气的地区名称
 *  @param returnBlock 返回的一个block 里面返回两个参数，生成的对象和错误信息，如果对象存在在错误信息为nil，反之亦然
 *  @param bol         是否立即更新
 */
+(void)getWeatherWithDistrictName:(NSString*)name
                        ReturnObj:(void(^)(Weather *obj,NSString* errorMsg))returnBlock
                UpdataImmediately:(BOOL)bol;
@end
