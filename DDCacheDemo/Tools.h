//
//  Tools.h
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
/**
 *  判断文件是否存在
 *
 *  @param filename 文件名称
 *
 *  @return
 */
+ (BOOL)isFileExistWithFileName:(NSString*)filename;
/**
 *  缓存对象
 *
 *  @param filename 缓存文件的名称
 *  @param obj      需要进行缓存的对象
 */
+(void)archiverToTempWithFileName:(NSString*)filename Obj:(id)obj;
/**
 *  从缓存中恢复对象
 *
 *  @param filename 缓存文件的名称
 *
 *  @return 从缓存恢复的对象
 */
+(id)unarchiverFromTempWithFileName:(NSString*)filename;
@end
