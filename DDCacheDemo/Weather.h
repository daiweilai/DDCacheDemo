//
//  Weather.h
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//


#import "BaseModel.h"

@interface Weather : BaseModel
@property(nonatomic,strong)NSString* prov;
@property(nonatomic,strong)NSString* windDirection;
@property(nonatomic,strong)NSString* temp;
@property(nonatomic,strong)NSString* humidity;
@property(nonatomic,strong)NSString* img_2;
@property(nonatomic,strong)NSString* refreshTime;
@property(nonatomic,strong)NSString* weather;
@property(nonatomic,strong)NSString* city;
@property(nonatomic,strong)NSString* maxTemp;
@property(nonatomic,strong)NSString* district;
@property(nonatomic,strong)NSString* dateTime;
@property(nonatomic,strong)NSString* areaid;
@property(nonatomic,strong)NSString* minTemp;
@property(nonatomic,strong)NSString* img_1;
@property(nonatomic,strong)NSString* windForce;

/**
 *  如果希望从直接从网络请求回来的数据映射成对象或者希望从缓存中恢复对象就应该使用下面这个方法
 *
 *  @param name        需要查询天气的地区名称
 *  @param returnBlock 返回的一个block 里面返回两个参数，生成的对象和错误信息，如果对象存在在错误信息为nil，反之亦然
 *  @param bol         是否立即更新
 */
+(void)getWeatherWithDistrictName:(NSString*)name
                        ReturnObj:(void(^)(Weather *obj,NSString* errorMsg))returnBlock
                UpdataImmediately:(BOOL)bol;
@end
