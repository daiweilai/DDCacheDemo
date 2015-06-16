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
        self.updateTime = [coder decodeObjectForKey:@"updateTime"];
        NSNumber* cacheDurationTimeObj = [coder decodeObjectForKey:@"cacheDurationTime"];
        if (cacheDurationTimeObj) {
            self.cacheDurationTime = [cacheDurationTimeObj doubleValue];
        }
        NSNumber* needToCacheObj = [coder decodeObjectForKey:@"needToCache"];
        if (needToCacheObj) {
            self.needToCache = [needToCacheObj boolValue];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.updateTime forKey:@"updateTime"];
    [coder encodeObject:[[NSNumber alloc] initWithDouble:self.cacheDurationTime] forKey:@"cacheDurationTime"];
    [coder encodeObject:[[NSNumber alloc] initWithBool:self.needToCache] forKey:@"needToCache"];
}

- (BOOL)needToUpdate{
    if (_needToCache) {
        NSTimeInterval interval = [[NSDate new] timeIntervalSinceDate:self.updateTime];
        if (interval > self.cacheDurationTime) {
            return  YES;
        }
    }
    return NO;
}
@end
