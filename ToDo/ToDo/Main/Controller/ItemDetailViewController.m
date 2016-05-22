//
//  ItemDetailViewController.m
//  ToDo
//
//  Created by wangxinghe on 22/5/2016.
//  Copyright © 2016 mouxuejie.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemDetailViewController.h"

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"编辑备忘";
    NSMutableDictionary *dic = self.itemDic;
    NSString *description = [dic objectForKey:@"contentDesc"];
    [self.contentTextView setText:description];
}

- (void)actionDone {
    if (![self.contentTextView.text isEqualToString:@""]) {
        //修改沙盒plist
        NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *plistPath1 = [paths objectAtIndex:0];
        NSString *filename=[plistPath1 stringByAppendingPathComponent:@"todo.plist"];
        NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:filename];
        
        NSUInteger count = [array count];
        for (int i = 0; i < count; i++) {
            NSMutableDictionary *dic = [array objectAtIndex:i];
            NSNumber *id = [dic objectForKey:@"id"];
            if ([id longValue] == [[self.itemDic objectForKey:@"id"] longValue]) {
                [array removeObject:dic];
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                NSDate *curDate = [NSDate date];
                NSString *time = [formatter stringFromDate:curDate];
                long modifyTime = [curDate timeIntervalSince1970]*1000;
                NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
                [dictionary setObject:[NSNumber numberWithLong:[id longValue]] forKey:@"id"];
                [dictionary setObject:self.contentTextView.text forKey:@"contentDesc"];
                [dictionary setObject:time forKey:@"timeDesc"];
                [dictionary setObject:[NSNumber numberWithLong:modifyTime] forKey:@"modifyTime"];
                if (array == nil) {
                    array = [NSMutableArray array];
                }
                [array insertObject:dictionary atIndex:0];
                break;
            }
        }

        [array  writeToFile:filename atomically:YES];
        [self.contentTextView setText:@""];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
