//
//  ViewController.m
//  LYSFootsteps
//
//  Created by 刘永生 on 2017/7/20.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "ViewController.h"
//#import "Masonry.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <LYSRepo/UIView+LYSAliquots.h>

#import "InfoView.h"
#import "KeyView.h"

@interface ViewController ()

@property (nonatomic, strong) InfoView *bodyView;/**< <#String#> */
@property (nonatomic, strong) KeyView *keyView;/**< <#String#> */


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    [self initUI];
    
    
}




- (void)initUI {

    [self.view lys_AddAliquotsViews:@[self.bodyView,self.keyView]
                          LRpadding:5
                        viewPadding:5
                          direction:LYSAliquotDirection_H];
    
    
//    [self.view addSubview:self.bodyView];
//    [self.view addSubview:self.keyView];
    
    [self makeConstraints];
    
}

- (void)makeConstraints {
    
    
    
}

- (void)initData {
    
}





- (InfoView *)bodyView {
    
    if(!_bodyView){
        _bodyView = [[InfoView alloc]init];
        _bodyView.backgroundColor = [UIColor greenColor];
    }
    return _bodyView;
    
}

- (KeyView *)keyView {
    
    if(!_keyView){
        _keyView = [[KeyView alloc]init];
        _keyView.backgroundColor = [UIColor greenColor];
    }
    return _keyView;
    
}





@end
