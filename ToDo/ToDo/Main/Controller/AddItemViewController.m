//
//  AddItemViewController.m
//  ToDo
//
//  Created by wangxinghe on 21/5/2016.
//  Copyright © 2016 mouxuejie.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AddItemViewController.h"

@interface AddItemViewController ()
{
    UITextView *contentTextView;
}

@end

@implementation AddItemViewController

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)viewDidLoad
{
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    //init title bar
    self.title = @"添加备忘";
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(actionDone)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    CGRect windowFrame = [[UIScreen mainScreen] bounds];
    self.contentTextView = [[UITextView alloc] initWithFrame:windowFrame];
    self.contentTextView.font = [UIFont systemFontOfSize:22];
    [self.contentTextView becomeFirstResponder];
    self.contentTextView.keyboardType = UIKeyboardTypeDefault;
    
    [self.view addSubview:self.contentTextView];
}

- (void)actionDone
{
    NSString *content = [self.contentTextView text];
    //不能修改mainBundle的plist，只能读取
//    NSDictionary *dictionary = [NSDictionary dictionaryWithObject:content forKey:@"description"];
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"todo" ofType:@"plist"];
//    NSArray *array = [[NSArray alloc] initWithContentsOfFile:path];
//    NSMutableArray *todoList = [NSMutableArray arrayWithArray:array];
//    [todoList addObject:dictionary];
//    [todoList writeToFile:path atomically:YES];
    
    if (![content isEqualToString:@""]) {
        //修改沙盒plist
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"todo.plist"];
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:filename];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSDate *curDate = [NSDate date];
        NSString *time = [formatter stringFromDate:curDate];
        long millSec = [curDate timeIntervalSince1970] * 1000;
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjects:@[content,time] forKeys:@[@"contentDesc", @"timeDesc"]];
        [dictionary setObject:[NSNumber numberWithLong:millSec] forKey:@"id"];
        [dictionary setObject:[NSNumber numberWithLong:millSec] forKey:@"modifyTime"];
        if (array == nil) {
            array = [NSMutableArray array];
        }
        
        [array insertObject:dictionary atIndex:0];
        [array  writeToFile:filename atomically:YES];
        [self.contentTextView setText:@""];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end

