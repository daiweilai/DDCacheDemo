//
//  Tools.h
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject
+ (BOOL)isFileExistWithFileName:(NSString*)filename;
+(void)archiverToTempWithFileName:(NSString*)filename Obj:(id)obj;
+(id)unarchiverFromTempWithFileName:(NSString*)filename;
/**
 *  字典转Json
 *
 *  @param dic 字典
 *
 *  @return json string
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
@end
