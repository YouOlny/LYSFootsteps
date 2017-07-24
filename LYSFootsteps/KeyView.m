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
#import "InfoModel.h"

@interface KeyView ()

@property (nonatomic, strong) NSMutableArray *keyboardBtnArray;/**< <#String#> */


@end

@implementation KeyView


- (void)changeData:(NSMutableArray *)keyboardArray  {
    
    if (self.keyboardBtnArray.count != keyboardArray.count) {
        
        for (UIButton * btn in self.keyboardBtnArray) {
            [btn removeFromSuperview];
        }
        [self.keyboardBtnArray removeAllObjects];
        
        
        for (int index = 0; index < keyboardArray.count; index++) {
            UIButton * btn = [[UIButton alloc]init];
            btn.tag = index;
            [btn mas_makeConstraints:^(MASConstraintMaker *make){
                make.height.mas_equalTo(50);
            }];
            [self.keyboardBtnArray insertObject:btn atIndex:0];
            
        }
        
        [self lys_AddInsideCenterViews:self.keyboardBtnArray
                           viewPadding:10
                          centerOffset:0
                             direction:LYSAliquotDirection_V];
        
        
    }
    
    
    for (int index = 0; index < keyboardArray.count; index++) {
        
        UIButton * btn = self.keyboardBtnArray[index];
        
        InfoModel * model = keyboardArray[index];
        
        [btn setTitle:model.cm forState:UIControlStateNormal];
        
        
    }
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}


- (void)initUI {

    
//    NSMutableArray * keyBtnArray = [NSMutableArray array];
    
    
    

    
    
    
    [self makeConstraints];
    
}

- (void)makeConstraints {
    
}

- (void)initData {
    
}



- (NSMutableArray *)keyboardBtnArray {
    
    if(!_keyboardBtnArray){
        _keyboardBtnArray = [[NSMutableArray alloc]init];
    }
    return _keyboardBtnArray;
    
}




@end
