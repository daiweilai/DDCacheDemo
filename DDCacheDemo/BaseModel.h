//
//  BaseModel.h
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//
/**
 *  这个应该是所有需要进行缓存操作的对象应该继承的类
 *  这个类定义了一些缓存机制需要使用的属性和方法
 */

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property(nonatomic,strong)NSDate *updateTime;//更新的时间
@property(nonatomic,assign)NSTimeInterval cacheDurationTime;//缓存的时长
@property(nonatomic,assign)BOOL needToCache;//是否需要缓存

/**
 *  判断当前是否需要更新(缓存是否过期)
 *
 *  @return YES:需要更新 NO:不需要更新
 */
- (BOOL)needToUpdate;
/**
 *  为了让子类可以把父类中的属性也进行Archiver所以这里把这个下面的两个方法暴露出来
 */
- (instancetype)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;
@end
