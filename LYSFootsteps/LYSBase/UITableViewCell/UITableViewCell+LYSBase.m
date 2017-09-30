//
//  UITableViewCell+LYSBase.m
//  LYSFootsteps
//
//  Created by 刘永生 on 2017/9/10.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "UITableViewCell+LYSBase.h"

@implementation UITableViewCell (LYSBase)


+ (instancetype)lys_cellToTable:(UITableView *)tableView {
    
    return [self lys_cellToTable:tableView identifier:NSStringFromClass([self class])];
    
}


+ (instancetype)lys_cellToTable:(UITableView *)tableView identifier:(NSString *)identifier
{
    
    id cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        [cell lys_cellDidLoad];
    }
    return cell;
}

- (void)lys_cellDidLoad {
    
    
    
    
}

@end
