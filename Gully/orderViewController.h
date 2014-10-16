//
//  orderViewController.h
//  Gully
//
//  Created by Venkat on 20/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderViewController : UIViewController{
    float total;
    float newtotal;
     NSArray *orders;
}
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property(nonatomic,strong)NSString *itemName;
@property(nonatomic,strong)NSString *itemPrice;
@property(nonatomic,strong)NSMutableDictionary *orderDict;
- (IBAction)refreshbtn:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *totallbl;
- (IBAction)updateBtn:(id)sender;

//@property(strong) NSManagedObject  *OrdersDB;

//@property (weak, nonatomic) IBOutlet UIScrollView *orderscroll;

@end
