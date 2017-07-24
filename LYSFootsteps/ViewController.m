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
#import <MJExtension/MJExtension.h>

#import "InfoView.h"
#import "KeyView.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *mainArray;/**< <#String#> */

@property (nonatomic, strong) NSMutableArray *keyboardArray;/**< <#String#> */

@property (nonatomic, strong) InfoView *bodyView;/**< <#String#> */
@property (nonatomic, strong) KeyView *keyView;/**< <#String#> */


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    [self.mainArray addObjectsFromArray:[self tempData]];
    
    
    
    
    
    [self initUI];
    

    [self.keyView changeData:self.keyboardArray];
}

- (void)refreshInfoView {
    
//    InfoModel * model = [[InfoModel alloc]init];
    
//    int leftIndex = arc4random() % 2 ;
    
//    if (leftIndex % 2) {
//        model.leftImageStr = @"high";
//    }else {
//        model.leftImageStr = @"low";
//    }
    
//    NSArray * array = [ViewController tempData];
    
    
    int index = arc4random()% self.mainArray.count;
    
    [self.bodyView infoViewModel:self.mainArray[index]];
    
    
    
    
}

- (NSArray *)tempData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"File" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        //DLog(@"JSON解码失败");
        return nil;
    } else {
        
        NSArray * dataArr = jsonObj[@"high"];
        
        NSMutableArray * array = [NSMutableArray array];
        
        for (NSDictionary * dic in dataArr) {
            
            InfoModel * model = [InfoModel mj_objectWithKeyValues:dic];
            model.parent = @"high";
            [array addObject:model];
        }
        
        
        
        {
            NSArray * dataArr = jsonObj[@"key"];
            
            NSMutableArray * array = [NSMutableArray array];
            
            for (NSDictionary * dic in dataArr) {
                
                InfoModel * model = [InfoModel mj_objectWithKeyValues:dic];
                model.parent = @"high";
                [array addObject:model];
            }
            
            [self.keyboardArray addObjectsFromArray:array];
            
        }
        
        return array;
    }
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self refreshInfoView];
    
}



- (void)initUI {

    [self.view lys_AddAliquotsViews:@[self.keyView,self.bodyView]
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



- (NSMutableArray *)mainArray {
    
    if(!_mainArray){
        _mainArray = [[NSMutableArray alloc]init];
    }
    return _mainArray;
    
}


- (NSMutableArray *)keyboardArray {
    
    if(!_keyboardArray){
        _keyboardArray = [[NSMutableArray alloc]init];
    }
    return _keyboardArray;
    
}


@end
