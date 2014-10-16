//
//  DetailsViewController.m
//  Gully
//
//  Created by Venkat on 13/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "DetailsViewController.h"
#import "orderViewController.h"
#import "AppDelegate.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController
@synthesize recipeLabel,priceLbl,recipeImge;
@synthesize recipeName,recipePrice,imageName;
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
    recipeLabel.text = recipeName;
    priceLbl.text=[NSString stringWithFormat:@"Price : %@",recipePrice];
    self.recipeImge.image=[UIImage imageNamed:imageName];
    //[self.view setBackgroundColor:[UIColor greenColor]];
    self.scrollView.contentSize=CGSizeMake(320, 650);
   
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"order"]) {
        //NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        orderViewController *order=segue.destinationViewController;
        order.itemName=self.recipeName;
        order.itemPrice=self.recipePrice;
        
    }
}



- (IBAction)orderSave:(id)sender {
    AppDelegate *appD=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[appD managedObjectContext];
    NSManagedObject *newOrder=[NSEntityDescription insertNewObjectForEntityForName:@"Orders" inManagedObjectContext:context];
    [newOrder setValue:recipeName forKey:@"itemname"];
    [newOrder setValue:recipePrice forKey:@"itemprice"];
    NSError *error;
    
    if (![context save:&error]) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"save failed" message:[NSString stringWithFormat:@"save core data failed %@",[error localizedDescription]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else{
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Order Placed"message:@"Thanking You.." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }

    
}
@end
