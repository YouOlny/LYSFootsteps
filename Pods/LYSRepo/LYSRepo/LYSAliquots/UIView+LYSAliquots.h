//
//  UIView+LYSAliquots.h
//  LYSRepo
//
//  Created by 刘永生 on 2017/3/9.
//  Copyright © 2017年 3050700400@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>


#import <Masonry/Masonry.h>

typedef NS_ENUM(NSUInteger, LYSAliquotDirection) {
    
    /**
     水平方向
     */
    LYSAliquotDirection_H,
    
    /**
     竖直方向
     */
    LYSAliquotDirection_V,
};


@interface UIView (LYSAliquots)


/**
 平均等分插入view
 
 @param views 子视图数组
 @param LRpadding 左右间距
 @param viewPadding 子视图间间距
 @param direction 放置方向
 */
- (void)lys_AddAliquotsViews:(NSArray<UIView *> *)views
                   LRpadding:(CGFloat)LRpadding
                 viewPadding:(CGFloat)viewPadding
                   direction:(LYSAliquotDirection)direction;




- (UIView *)lys_AddInsideCenterViews:(NSArray *)views
                         viewPadding:(CGFloat)viewPadding
                        centerOffset:(CGFloat)centerOffset
                           direction:(LYSAliquotDirection)direction;


@end
