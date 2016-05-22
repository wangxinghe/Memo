//
//  ItemDetailViewController.h
//  ToDo
//
//  Created by wangxinghe on 22/5/2016.
//  Copyright © 2016 mouxuejie.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddItemViewController.h"

@interface ItemDetailViewController : AddItemViewController
@property (nonatomic, strong) NSMutableDictionary *itemDic;
@end