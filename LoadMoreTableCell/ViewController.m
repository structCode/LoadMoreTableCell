//
//  ViewController.m
//  LoadMoreTableCell
//
//  Created by Kenvin on 16/8/21.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import "ViewController.h"
#import "LoadMoreCell.h"
#import "UITableView+FDTemplateLayoutCell.h"

static CGFloat constedHeight = 125.5f;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) NSIndexPath *expandIndexPath;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadDefaultDataSource{
    [super loadDefaultDataSource];
}

- (void)loadDataSource{
    [super loadDataSource];
}

- (void)initViews{
    [super initViews];
    [self initTableView];
}

- (void)initTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width,  [UIScreen mainScreen].bounds.size.height-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"LoadMoreCell" bundle:nil] forCellReuseIdentifier:LoadMoreCellIdentifier];
    [self.view addSubview:self.tableView];
    self.tableView.estimatedRowHeight = 70.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (NSMutableArray *)dataSource{
    if (_dataSource==nil) {
        _dataSource = [NSMutableArray arrayWithObjects:
                           @"ReactiveCocoa是GitHub开源的一个函数响应式编程框架，目前在美团App中大量使用。用过它的人都知道很好用，也确实为我们的生活带来了很多便利，特别是跟MVVM模式结合使用，更是如鱼得水。不过刚开始使用的时候，可能容易疏忽掉一些隐藏的细节，从而导致内存泄漏等问题。本文就带大家深入了解下ReactiveCocoa中隐藏的一些细节，帮助大家以更加正确的姿势使用ReactiveCocoa.",
                           @"创建一个signal，该signal被订阅后会发送一个MTModel的实例；对第一步创建的signal进行flattenMap操作，并将返回的信号保留（之所以要保留，是因为可能希望在其它地方订阅，不过这里为了简单，就直接在第三步进行订阅）；对第二步产生的信号（self.flattenMapSignal）进行订阅。",
                           @"RACSubject会持有订阅者（因为RACSubject是热信号，为了保证未来有事件发送的时候，订阅者可以收到信息，所以需要对订阅者保持状态，做法就是持有订阅者），而RACSignal不会持有订阅者。关于这一点，更详细的说明请看《细说ReactiveCocoa的冷信号与热信号（三）：怎么处理冷信号与热信号》。那么持不持有订阅者，跟内存无法释放又有啥关系呢？不急，先记着有这样一个特性，咱们看看实现",
                           @"订阅者会持有nextBlock、errorBlock、completedBlock三个block，为了简单，我们只讨论nextBlock。",
                           nil];
    }
    return _dataSource;
}

#pragma mark - TableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadMoreCellIdentifier];
    cell.label.text =  [self.dataSource objectAtIndex:indexPath.row];
    _expandIndexPath = indexPath;
    __weak ViewController *Weakself = self;
    CGFloat height = [tableView fd_heightForCellWithIdentifier:LoadMoreCellIdentifier  configuration:^(LoadMoreCell * cell) {
        cell.label.numberOfLines = 0;
        cell.label.text = [self.dataSource objectAtIndex:indexPath.row];
    }];

    if (height<constedHeight) {
        cell.button.hidden = YES;
    }else{
        [self loadMore:cell.button];
        cell.button.hidden = NO;
    }
    
    typeof(cell) __weak strongCell = cell;
    
    cell.expandCellBlock = ^(void){
        typeof(self) __strong strongSelf = self;
        if (!strongCell.button.selected) {
            [strongSelf loadMore:strongCell.button];
        }else{
            [strongSelf hideMore:strongCell.button];
        }
        [Weakself.tableView reloadRowsAtIndexPaths:@[_expandIndexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    return cell;
}
- (void)loadMore:(UIButton *)button{
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [button setTitle:@",点击查看更多" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}

- (void)hideMore:(UIButton *)button{
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -40)];
    [button setTitle:@"收起" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
}
@end
