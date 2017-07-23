//
//  KeyView.m
//  LYSFootsteps
//
//  Created by 刘永生 on 2017/7/23.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "KeyView.h"

#import <Masonry/Masonry.h>
#import <LYSRepo/UIView+LYSAliquots.h>

@implementation KeyView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)initUI {

    
    NSMutableArray * keyBtnArray = [NSMutableArray array];
    
    for (int index = 0; index < 7; index++) {
        UIButton * btn = [[UIButton alloc]init];
        
        [btn setTitle:@"qwe" forState:UIControlStateNormal];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make){
            make.height.mas_equalTo(50);
        }];
        
        [keyBtnArray addObject:btn];
        
    }
    
    [self lys_AddInsideCenterViews:keyBtnArray
                       viewPadding:10
                      centerOffset:0
                         direction:LYSAliquotDirection_V];
    
    
    
    [self makeConstraints];
    
}

- (void)makeConstraints {
    
}

- (void)initData {
    
}

@end
