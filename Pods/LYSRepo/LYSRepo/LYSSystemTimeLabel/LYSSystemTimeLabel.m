//
//  LYSSystemTimeLabel.m
//  LYSRepo
//
//  Created by 刘永生 on 2017/3/28.
//  Copyright © 2017年 3050700400@qq.com. All rights reserved.
//

#import "LYSSystemTimeLabel.h"

@interface LYSSystemTimeLabel () {
    
    dispatch_source_t _disTimer; /**< 计时器 */
    
    NSDateFormatter *_formatter;
}

@end

@implementation LYSSystemTimeLabel

- (void)cancel{
    if (_disTimer) {
        dispatch_source_cancel(_disTimer);
        _disTimer = nil;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initData];
    }
    return self;
}

- (void)initData {
    
    _formatter = [[NSDateFormatter alloc]init];
    
     [_formatter setDateFormat:@"MM/dd/YY HH:mm:ss"];
    
    [self cancel];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _disTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_disTimer,dispatch_walltime(NULL, 0),1*NSEC_PER_SEC, 0); //每秒执行
    ;
    dispatch_source_set_event_handler(_disTimer, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self timerFunc];
        });
        
    });
    
    dispatch_resume(_disTimer);
    
}
- (void)timerFunc
{
    if (!self.superview) {
        [self cancel];
    }
    
    NSString *timestamp = [_formatter stringFromDate:[NSDate date]];
    
    [self setText:timestamp];
}

- (LYSSystemTimeLabel *(^)(NSString * formatter)) formatter {
    
    return ^id(NSString * formatter){
        
        [_formatter setDateFormat:formatter];
        
        return self;
    };
}


@end
