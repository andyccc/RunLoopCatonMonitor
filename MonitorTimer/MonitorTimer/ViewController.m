//
//  ViewController.m
//  MonitorTimer
//
//  Created by wd on 2019/6/28.
//  Copyright © 2019 wd. All rights reserved.
//

#import "ViewController.h"
#import "Monitor.h"

@interface ViewController ()<UITableViewDataSource> {
    UITableView *_tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     [self drawTableView];
    
    // 开始卡顿监听
    [[Monitor shareInstance] startMonitor];
}

/// 绘制TableView视图
- (void)drawTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma mark --------------------------------------------
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSString *text = nil;
    
    if (indexPath.row % 10 == 0) {  // 每10行休眠0.2S
        usleep(500 * 1000); // 1 * 1000 * 1000 == 1秒
        text = @"我在做复杂的事情，需要一些时间";
    } else {
        text = [NSString stringWithFormat:@"cell - %ld",indexPath.row];
    }
    
    cell.textLabel.text = text;
    
    return cell;
}

@end
