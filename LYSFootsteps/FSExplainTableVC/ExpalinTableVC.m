//
//  ExpalinTableVC.m
//  LYSFootsteps
//
//  Created by 刘永生 on 2017/9/10.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "ExpalinTableVC.h"


#import "UITableViewCell+LYSBase.h"


#import "FootstepsExplainCell.h"


@interface ExpalinTableVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;/**< <#String#> */

@property (nonatomic, strong) NSMutableArray *mainTableArray;/**< <#String#> */

@end

@implementation ExpalinTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma tableView--delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FootstepsExplainCell * cell = [FootstepsExplainCell lys_cellToTable:tableView];
    
    
    
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




@end
