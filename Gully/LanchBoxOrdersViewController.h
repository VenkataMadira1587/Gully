//
//  LanchBoxOrdersViewController.h
//  Gully
//
//  Created by Venkat on 27/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface LanchBoxOrdersViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate>{
    MFMailComposeViewController *email;
}
@property (weak, nonatomic) IBOutlet UITableView *mealsTableView;
@property(nonatomic,strong)NSMutableArray *mealorders;
//@property(nonatomic,strong)NSArray *selectedMeals;

- (IBAction)FinalOrder:(id)sender;

@end
