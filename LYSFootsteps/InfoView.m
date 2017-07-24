//
//  infoView.m
//  LYSFootsteps
//
//  Created by 刘永生 on 2017/7/23.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "InfoView.h"



#import <LYSRepo/UIView+LYSAliquots.h>


@interface InfoView ()


@property (nonatomic, strong) InfoModel *infoModel;/**< <#String#> */

@property (nonatomic, strong) UIView *noteView;/**< 音符 */

@property (nonatomic, strong) UIImageView *leftImageView;/**< <#String#> */
@property (nonatomic, strong) UIImageView *rightImageView;/**< <#String#> */

@property (nonatomic, strong) UILabel *rightRateLabel;/**< 正确率 */

@property (nonatomic, strong) UILabel *rightNumLabel;/**< z正确数 */

@property (nonatomic, strong) UILabel *errorLabel;/**< 错误数 */


@end


@implementation InfoView



- (void)infoViewModel:(InfoModel *)model {
    
    self.infoModel = model;
    
    self.leftImageView.image = [UIImage imageNamed:self.infoModel.parent];
    self.rightImageView.image = [UIImage imageNamed:self.infoModel.icon];
    
    //todo:<MrLYS> 正确率
    
    
    
}




- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initUI];
        
        
        [self initData];
    }
    return self;
}


- (void)initUI {
    
    
    [self lys_AddInsideCenterViews:@[self.noteView,self.rightRateLabel,self.rightNumLabel,self.errorLabel]
                       viewPadding:10
                      centerOffset:0
                         direction:LYSAliquotDirection_V];
    
    
    [self.noteView mas_updateConstraints:^(MASConstraintMaker *make){
        make.height.mas_equalTo(200);
    }];
    
    
    [self.noteView addSubview:self.leftImageView];
    [self.noteView addSubview:self.rightImageView];
    
    
    
    [self makeConstraints];
    
}

- (void)makeConstraints {
    
    
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.rightImageView.mas_left);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.top.bottom.mas_equalTo(0);
        make.left.mas_equalTo(self.leftImageView.mas_right);
    }];
    
}

- (void)initData {
    
    self.leftImageView.image = [UIImage imageNamed:@"high"];
    self.rightImageView.image = [UIImage imageNamed:@"m4"];
    
    
}



- (UIView *)noteView {
    
    if(!_noteView){
        _noteView = [[UIView alloc]init];
        _noteView.backgroundColor = [UIColor redColor];
    }
    return _noteView;
    
}


- (UIImageView *)leftImageView {
    
    if(!_leftImageView){
        _leftImageView = [[UIImageView alloc]init];
    }
    return _leftImageView;
    
}

- (UIImageView *)rightImageView {
    
    if(!_rightImageView){
        _rightImageView = [[UIImageView alloc]init];
    }
    return _rightImageView;
    
}



- (UILabel *)rightNumLabel {
    
    if(!_rightNumLabel){
        _rightNumLabel = [[UILabel alloc]init];
        _rightNumLabel.numberOfLines = 0;
        _rightNumLabel.text = @"123123\n10";
    }
    return _rightNumLabel;
    
}

- (UILabel *)rightRateLabel {
    
    if(!_rightRateLabel){
        _rightRateLabel = [[UILabel alloc]init];
        _rightRateLabel.numberOfLines = 0;
        _rightRateLabel.text = @"1231\n100%";
    }
    return _rightRateLabel;
    
}


- (UILabel *)errorLabel {
    
    if(!_errorLabel){
        _errorLabel = [[UILabel alloc]init];
        _errorLabel.numberOfLines = 0;
        _errorLabel.text = @"12312\n5";
    }
    return _errorLabel;
    
}



@end
