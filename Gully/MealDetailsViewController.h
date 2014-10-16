//
//  MealDetailsViewController.h
//  Gully
//
//  Created by Venkat on 26/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealDetailsViewController : UIViewController{
    NSInteger count;

}
@property (weak, nonatomic) IBOutlet UILabel *mealLbl;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectType;
- (IBAction)selectType:(id)sender;
- (IBAction)addMeals:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *totalMeals;
@property(nonatomic,strong)NSString * itemType;
@property(nonatomic,strong)NSArray *meals;


@property(strong)NSString *mealDetail;
@property (weak, nonatomic) IBOutlet UIScrollView *mealDetailScroll;

@end
