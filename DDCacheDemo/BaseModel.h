//
//  BaseModel.h
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property(nonatomic,strong)NSDate *updateTime;//更新的时间
@property(nonatomic,assign)NSTimeInterval cacheDurationTime;//缓存的时长
@property(nonatomic,assign)BOOL needToCache;//是否需要缓存

- (BOOL)needToUpdate;//判断当前是否需要更新(缓存是否过期)
- (instancetype)initWithCoder:(NSCoder *)coder;
- (void)encodeWithCoder:(NSCoder *)coder;
@end
