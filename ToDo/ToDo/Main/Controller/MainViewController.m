//
//  MainViewController.m
//  ToDo
//
//  Created by wangxinghe on 21/5/2016.
//  Copyright © 2016 mouxuejie.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "AddItemViewController.h"
#import "ItemDetailViewController.h"


NSString * const TDCellIdentifier = @"TDCellIdentifier";

@interface MainViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *todoTableView;
    NSMutableArray *todoList;
}

@end

@implementation MainViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    //读取沙盒plist
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    NSString *filename=[plistPath1 stringByAppendingPathComponent:@"todo.plist"];
    todoList = [NSMutableArray arrayWithContentsOfFile:filename];

    [todoTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //init window
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    CGRect winFrame = [[UIScreen mainScreen] bounds];

    //init title bar
    self.title = @"备忘录";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(gotoAddItemPage)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //init table view
    CGRect tableViewRect = CGRectMake(0, 0, winFrame.size.width, winFrame.size.height);
    todoTableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    todoTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [todoTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:TDCellIdentifier];
    todoTableView.delegate = self;
    todoTableView.dataSource = self;
    
    [self.view addSubview:todoTableView];
}

- (void)gotoAddItemPage {
    AddItemViewController *addItemViewController = [[AddItemViewController alloc] init];
    [self.navigationController pushViewController:addItemViewController animated:YES];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ItemDetailViewController *itemDetailViewController = [[ItemDetailViewController alloc] init];
    itemDetailViewController.itemDic = [todoList objectAtIndex:[indexPath row]];
    [self.navigationController pushViewController:itemDetailViewController animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return Nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [todoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    NSDictionary *cellDictionary = [todoList objectAtIndex:[indexPath row]];
    cell.textLabel.text = [cellDictionary objectForKey:@"contentDesc"];
    cell.detailTextLabel.text = [cellDictionary objectForKey:@"timeDesc"];
    cell.textLabel.font = [UIFont systemFontOfSize:22];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.layer.shouldRasterize = YES;
    cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    return cell;
}

@end
