//
//  LYSBuoyM.h
//  LYSRepo
//
//  Created by 刘永生 on 2017/3/13.
//  Copyright © 2017年 3050700400@qq.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYSBuoyM : NSObject

+ (LYSBuoyM *)sharedManager;

+ (UIWindow *)windowForKey:(NSString *)key;

+ (void)saveWindow:(UIWindow *)window forKey:(NSString *)key;

+ (void)removeWindowForKey:(NSString *)key;

@end
