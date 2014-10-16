//
//  ViewController.h
//  Gully
//
//  Created by Venkat on 13/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
NSArray *tableData;
NSArray *thumbnail;
NSArray *price;
}
@property (nonatomic, strong) IBOutlet UITableView *tableView;

@end
