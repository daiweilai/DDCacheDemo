//
//  ViewController.m
//  DDCacheDemo
//
//  Created by David on 15/6/16.
//  Copyright (c) 2015年 DavidDay. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [Weather getWeatherWithDistrictName:@"成都" ReturnObj:^(Weather *obj, NSString *errorMsg) {
        NSLog(@"%@",obj.prov);
        /**
         这里拿到了对象.
         对于controller来说,Model的更新应该对自己是透明的，controller根本不在乎对象是从网络请求回来的数据重新映射的还是从缓存恢复回来的
         反正controller拿到对象就传递给View就对了 至于展现就是View的工作了
        **/
    } UpdataImmediately:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
