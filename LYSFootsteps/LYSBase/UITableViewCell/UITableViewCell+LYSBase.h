//
//  UITableViewCell+LYSBase.h
//  LYSFootsteps
//
//  Created by 刘永生 on 2017/9/10.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (LYSBase)

+ (instancetype)lys_cellToTable:(UITableView *)tableView;
+ (instancetype)lys_cellToTable:(UITableView *)tableView identifier:(NSString *)identifier;


- (void)lys_cellDidLoad;

@end
