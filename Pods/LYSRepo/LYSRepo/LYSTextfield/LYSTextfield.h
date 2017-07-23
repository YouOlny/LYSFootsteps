//
//  LYSTextfield.h
//  LYSTextfield
//
//  Created by 刘永生 on 2017/3/6.
//  Copyright © 2017年 3050700400@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSTextfield : UITextField

/**
 开启间隔功能
 */
- (LYSTextfield *(^)(BOOL isSpacer)) isSpacer;

/**
 间隔符,只能有一个字符
 */
- (LYSTextfield *(^)(NSString *spacer)) spacer;

/**
 间隔符的位置.
 */
- (LYSTextfield *(^)(NSNumber * spacerNum)) spacerNum;

/**
 删除所有的间隔区间
 */
- (LYSTextfield *(^)()) removeSpacerNums;

/**
 能够输入的最大位数
 */
- (LYSTextfield *(^)(NSInteger maxLimit)) maxLimit;



@end
