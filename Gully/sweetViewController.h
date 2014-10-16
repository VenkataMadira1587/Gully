//
//  sweetViewController.h
//  Gully
//
//  Created by Venkat on 18/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sweetViewController : UIViewController{
    NSArray *tableData;
    NSArray *thumbnail;
    NSArray *price;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
