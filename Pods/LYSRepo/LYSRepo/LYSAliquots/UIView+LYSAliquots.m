//
//  UIView+LYSAliquots.m
//  LYSRepo
//
//  Created by 刘永生 on 2017/3/9.
//  Copyright © 2017年 3050700400@qq.com. All rights reserved.
//

#import "UIView+LYSAliquots.h"

@implementation UIView (LYSAliquots)


- (void)lys_AddAliquotsViews:(NSArray<UIView *> *)views
                   LRpadding:(CGFloat)LRpadding
                 viewPadding:(CGFloat)viewPadding
                   direction:(LYSAliquotDirection)direction{
    
    UIView *lastView;
    for (UIView *view in views) {
        [self addSubview:view];
        if (lastView) {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                if (direction == LYSAliquotDirection_H) {
                    make.top.bottom.equalTo(self);
                    make.left.equalTo(lastView.mas_right).offset(viewPadding);
                    make.width.equalTo(lastView);
                }else {
                    make.left.right.equalTo(self);
                    make.top.equalTo(lastView.mas_bottom).offset(viewPadding);
                    make.height.equalTo(lastView);
                }
            }];
        }else
        {
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                if (direction == LYSAliquotDirection_H) {
                    make.left.equalTo(self).offset(LRpadding);
                    make.top.bottom.equalTo(self);
                }else {
                    make.top.equalTo(self).offset(LRpadding);
                    make.left.right.equalTo(self);
                }
            }];
        }
        lastView=view;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (direction == LYSAliquotDirection_H) {
            make.right.equalTo(self).offset(-LRpadding);
        }else {
            make.bottom.equalTo(self).offset(-LRpadding);
        }
    }];
    
    
}


- (UIView *)lys_AddInsideCenterViews:(NSArray *)views
                         viewPadding:(CGFloat)viewPadding
                        centerOffset:(CGFloat)centerOffset
                           direction:(LYSAliquotDirection)direction
{
    UIView * contentView = [[UIView alloc]init];
    [self addSubview:contentView];
    
    UIView *lastView;
    for (UIView *view in views) {
        [contentView addSubview:view];
        if (lastView) {
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                
                if (direction == LYSAliquotDirection_H) {
                    make.centerY.mas_equalTo(contentView.mas_centerY);
                    make.left.mas_equalTo(lastView.mas_right).offset(viewPadding);
                }else {
                    make.centerX.mas_equalTo(contentView.mas_centerX);
                    make.top.mas_equalTo(lastView.mas_bottom).offset(viewPadding);
                }
            }];
        }else
        {
            [view mas_updateConstraints:^(MASConstraintMaker *make) {
                
                if (direction == LYSAliquotDirection_H) {
                    
                    make.left.equalTo(contentView);
                    make.centerY.mas_equalTo(contentView.mas_centerY);
                    
                }else {
                    
                    make.top.equalTo(contentView);
                    make.centerX.mas_equalTo(contentView.mas_centerX);
                    
                }
            }];
        }
        lastView=view;
    }
    
    [contentView mas_updateConstraints:^(MASConstraintMaker *make){
        
        if (direction == LYSAliquotDirection_H) {
            make.right.mas_equalTo(lastView.mas_right);
            make.centerX.mas_equalTo(self.mas_centerX).offset(centerOffset);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.height.mas_equalTo(self.mas_height);
        }else {
            make.bottom.mas_equalTo(lastView.mas_bottom);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY).offset(centerOffset);
            make.width.mas_equalTo(self.mas_width);
        }
    }];
    
    return contentView;
}




@end
