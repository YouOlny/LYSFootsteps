//
//  LYSBuoyM.m
//  LYSRepo
//
//  Created by 刘永生 on 2017/3/13.
//  Copyright © 2017年 3050700400@qq.com. All rights reserved.
//

#import "LYSBuoyM.h"


@interface LYSBuoyM ()

@property (nonatomic, strong) NSMutableDictionary *windowDic;

@end


@implementation LYSBuoyM

+ (LYSBuoyM *)sharedManager
{
    static LYSBuoyM *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!sharedInstance) {
            sharedInstance = [[LYSBuoyM alloc] init];
        }
    });
    return sharedInstance;
}

+ (UIWindow *)windowForKey:(NSString *)key
{
    return [[LYSBuoyM sharedManager].windowDic objectForKey:key];
}

+ (void)saveWindow:(UIWindow *)window forKey:(NSString *)key
{
    [[LYSBuoyM sharedManager].windowDic setObject:window forKey:key];
}

+ (void)removeWindowForKey:(NSString *)key
{
    UIWindow *window = [[LYSBuoyM sharedManager].windowDic objectForKey:key];
    window.hidden = YES;
    if (window.rootViewController.presentedViewController) {
        [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    window.rootViewController = nil;
    [[LYSBuoyM sharedManager].windowDic removeObjectForKey:key];
}

- (NSMutableDictionary *)windowDic
{
    if (!_windowDic) {
        _windowDic = [NSMutableDictionary dictionary];
    }
    return _windowDic;
}



@end
