//
//  ViewController.m
//  LYSFootsteps
//
//  Created by 刘永生 on 2017/7/20.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import <SDWebImage/UIImageView+WebCache.h>



@interface ViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *mainTableView;/**< <#String#> */
@property (nonatomic, strong) NSMutableArray *mainTableArray;/**< <#String#> */

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self.view addSubview:self.mainTableView];
//    
//    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make){
//        make.left.top.right.bottom.mas_equalTo(0);
//    }];
    
    
}



#pragma tableView--delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identify = @"cellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        
    }
    
//    http://5.supfree.net/images/d3.gif
//    
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://5.supfree.net/images/u%d.gif",(int)indexPath.row]]];
    
    
    NSString * picName = @"high";// [NSString stringWithFormat:@"m%d",(int)indexPath.row];
    
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://5.supfree.net/images/%@.gif",picName]]
                             completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                                
                                 
                                 NSString *path_document = NSHomeDirectory();
                                 
                                 //设置一个图片的存储路径
                                 
                                 NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@.png",picName]];
                                 
                                 NSLog(@"%@",imagePath);
                                 //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
                                 
                                 [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
                                 
                                 
                                 
                             }];
    
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    
    
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
