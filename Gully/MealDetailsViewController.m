//
//  MealDetailsViewController.m
//  Gully
//
//  Created by Venkat on 26/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "MealDetailsViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "LanchBoxOrdersViewController.h"


@interface MealDetailsViewController (){
    }

@end

@implementation MealDetailsViewController
@synthesize mealDetail,mealLbl,selectType,itemType;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mealLbl.text=self.mealDetail;
    count=0;
    self.mealDetailScroll.contentSize=CGSizeMake(320, 500);
   
    
}
-(void)viewDidAppear:(BOOL)animated{
    count=0;
    self.mealLbl.text=self.mealDetail;
    AppDelegate *appD=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[appD managedObjectContext];
    NSFetchRequest *fetchRQ=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Lorders" inManagedObjectContext:context];
    [fetchRQ setEntity:entity];
    NSError *error;
    
    self.meals=[[NSArray alloc]initWithArray: [context executeFetchRequest:fetchRQ error:&error]];
    count=[self.meals count];

    self.totalMeals.text= [NSString stringWithFormat:@"Total Meals %ld",(long)count];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

}


- (IBAction)selectType:(id)sender {
   
      self.itemType =[self.selectType titleForSegmentAtIndex:[self.selectType selectedSegmentIndex]];
    
   }

- (IBAction)addMeals:(id)sender {
  
    AppDelegate *appD=[[UIApplication sharedApplication]delegate];
        NSManagedObjectContext *context=[appD managedObjectContext];
        NSManagedObject *newOrder=[NSEntityDescription insertNewObjectForEntityForName:@"Lorders" inManagedObjectContext:context];
        NSFetchRequest *fetchRQ=[[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Lorders" inManagedObjectContext:context];
    [fetchRQ setEntity:entity];
    NSError *error;
    
    //NSArray *myarray=[[NSArray alloc]initWithArray:[context executeFetchRequest:fetchRQ error:&error]];
    
    
            [newOrder setValue:self.mealDetail forKey:@"mealName"];
        [newOrder setValue:[self.selectType titleForSegmentAtIndex:[self.selectType selectedSegmentIndex]] forKey:@"type"];
       // NSError *error;
        
        
            if (![context save:&error]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"save failed" message:[NSString stringWithFormat:@"save core data failed %@",[error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
        }
            else{
            
            NSEntityDescription *entity=[NSEntityDescription entityForName:@"Lorders" inManagedObjectContext:context];
            [fetchRQ setEntity:entity];
            NSError *error;
            
            self.meals=[context executeFetchRequest:fetchRQ error:&error];
            count=[self.meals count];
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Order Placed"message:@"Thanking You.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            
            [alert show];
        }

    self.totalMeals.text= [NSString stringWithFormat:@"Total Meals %ld",(long)count];
    if (count>=5) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"You Have orderd 5 meals"message:@"Do you want to more?" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
        
        [alert show];
    
    }
}

@end
