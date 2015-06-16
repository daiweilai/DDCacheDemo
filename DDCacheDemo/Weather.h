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
@end
