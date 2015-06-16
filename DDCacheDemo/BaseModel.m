//
//  BaseModel.m
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super init];
    if (self) {
        _updateTime = [coder decodeObjectForKey:@"updateTime"];
        NSNumber* cacheDurationTimeObj = [coder decodeObjectForKey:@"cacheDurationTime"];
        if (cacheDurationTimeObj) {
            _cacheDurationTime = [cacheDurationTimeObj doubleValue];
        }
        NSNumber* needToCacheObj = [coder decodeObjectForKey:@"needToCache"];
        if (needToCacheObj) {
            _needToCache = [needToCacheObj boolValue];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:_updateTime forKey:@"updateTime"];
    [coder encodeObject:[[NSNumber alloc] initWithDouble:_cacheDurationTime] forKey:@"cacheDurationTime"];
    [coder encodeObject:[[NSNumber alloc] initWithBool:_needToCache] forKey:@"needToCache"];
}

- (BOOL)needToUpdate{
    if (_needToCache) {
        NSTimeInterval interval = [[NSDate new] timeIntervalSinceDate:_updateTime];
        if (interval > _cacheDurationTime) {
            return  YES;
        }
    }
    return NO;
}
@end
