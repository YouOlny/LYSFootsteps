//
//  ViewController.m
//  LYSFootsteps
//
//  Created by 刘永生 on 2017/7/20.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"




@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;/**< <#String#> */
@property (nonatomic, strong) NSMutableArray *mainTableArray;/**< <#String#> */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.mainTableView];
    
//    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.<#left#>.mas_equalTo(<#offset#>);
//    }];
    
    
}



#pragma tableView--delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"cellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma tableView
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]init];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
    }
    return _mainTableView;
}

- (NSMutableArray *)mainTableArray {
    if (!_mainTableArray) {
        _mainTableArray = [[NSMutableArray alloc]init];
    }
    return _mainTableArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
