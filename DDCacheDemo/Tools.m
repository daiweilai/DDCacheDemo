//
//  Tools.m
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+ (BOOL)isFileExistWithFileName:(NSString*)filename{
    return [[NSFileManager defaultManager] fileExistsAtPath:[NSTemporaryDirectory() stringByAppendingPathComponent:filename]];
}

+(void)archiverToTempWithFileName:(NSString*)filename Obj:(id)obj{
    [NSKeyedArchiver archiveRootObject:obj toFile:[NSTemporaryDirectory() stringByAppendingPathComponent:filename]];
}

+(id)unarchiverFromTempWithFileName:(NSString*)filename{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[NSTemporaryDirectory() stringByAppendingPathComponent:filename]];
}
@end
