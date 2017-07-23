//
//  LYSBuoy.h
//  LYSRepo
//
//  Created by 刘永生 on 2017/3/13.
//  Copyright © 2017年 3050700400@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>


#define GLYSBuoy [LYSBuoy sharedManager]

typedef void (^LYSBuoyClickBlock)();

@interface LYSBuoy : UIView

+ (LYSBuoy *)sharedManager;

- (instancetype)initWithImage:(UIImage *)image;

- (instancetype)initWithFrame:(CGRect)frame;

/**
 设置X轴
 */
- (LYSBuoy *(^)(CGFloat left)) left;

/**
 设置Y轴
 */
- (LYSBuoy *(^)(CGFloat top)) top;

/**
 设置宽度
 */
- (LYSBuoy *(^)(CGFloat width)) width;

/**
 设置高度
 */
- (LYSBuoy *(^)(CGFloat height)) height;


/**
 嵌入屏幕讲个
 */
- (LYSBuoy *(^)(CGFloat embed)) embed;

/**
 设置图片
 */
- (LYSBuoy *(^)(UIImage * image)) image;

/**
 显示
 */
- (LYSBuoy *(^)()) show;

/**
 移除
 */
- (LYSBuoy *(^)()) remove;

/**
 隐藏
 */
- (LYSBuoy *(^)(BOOL isHidden)) hiddenView;

/**
 点击
 */
- (void)clickBuoy:(LYSBuoyClickBlock)click;


@end
