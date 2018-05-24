//
//  ViewController.m
//  RefreshTable
//
//  Created by PieDi on 2018/5/24.
//  Copyright © 2018年 PieDi. All rights reserved.
//

#import "ViewController.h"
#import <MJRefresh/MJRefresh.h>


@interface ViewController ()<UITabBarDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) UIView *aHeaderView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.mTableView.tableFooterView = [UIView new];
    
    if (@available(iOS 11.0, *)) {
        self.mTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIView *aView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 375, 75)];
    aView.backgroundColor = [UIColor greenColor];
    aView.frame = CGRectMake(0, -75, 375, 75);
    [self.mTableView addSubview:aView];
    __weak typeof(self) weakSelf = self;
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.mTableView.mj_header endRefreshing];
        
    }];
    
    self.mTableView.mj_header.ignoredScrollViewContentInsetTop = 75;
    self.aHeaderView = [[UIView alloc] init];
    self.aHeaderView.backgroundColor = [UIColor redColor];
    self.mTableView.tableHeaderView = self.aHeaderView;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.aHeaderView.frame = self.view.bounds;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    NSLog(@"basbuua :%f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= -75) {
        [self.mTableView setContentInset:UIEdgeInsetsMake(75, 0, 0, 0)];
    }else if (scrollView.contentOffset.y >= 75){
        [self.mTableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 603;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
