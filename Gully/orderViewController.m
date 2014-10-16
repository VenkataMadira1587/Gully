//
//  orderViewController.m
//  Gully
//
//  Created by Venkat on 20/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "orderViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "indochineseViewController.h"


@interface orderViewController (){
    
}

@end

@implementation orderViewController
@synthesize itemName,itemPrice,orderDict,totallbl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.itemPrice=itemPrice;
        self.itemName=itemName;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    total=0.0;
    newtotal=0.0;
    //self.orderscroll.contentSize=CGSizeMake(320, 650);
}

- (void)updateView {
    total=0.0;

    AppDelegate *appD=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[appD managedObjectContext];
    NSFetchRequest *fetchReq=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:context];
    [fetchReq setEntity:entity];
    
    NSError *error;
    
    orders=[context executeFetchRequest:fetchReq error:&error];
    
    //looping through orders
    for (int i=0; i<[orders count]; i++) {
        UILabel *namelbl=[[UILabel alloc]initWithFrame:CGRectMake(50, (i*30)+132, 120, 21)];
        UILabel *pricelbl=[[UILabel alloc]initWithFrame:CGRectMake(230, (i*30)+132, 94, 21)];
        namelbl.tag=i+1;
        namelbl.textColor=[UIColor colorWithRed:0.0 green:153.0 blue:76.0 alpha:1];
        pricelbl.textColor=[UIColor colorWithRed:0.0 green:153.0 blue:76.0 alpha:1];
        pricelbl.tag=i+100;
        namelbl.backgroundColor=[UIColor clearColor];
        namelbl.tintColor=[UIColor redColor];
        namelbl.text=[[orders objectAtIndex:i]valueForKey:@"itemname"];
        pricelbl.text=[[orders objectAtIndex:i]valueForKey:@"itemprice"];
        [self.view addSubview:namelbl];
        [self.view addSubview:pricelbl];
        
        //Convert String to number (int float)...Takeout int/float part from the string...
        NSString *originalString = [[orders objectAtIndex:i]valueForKey:@"itemprice"];
        //NSString *numberString;
        NSScanner *scanner=[NSScanner scannerWithString:originalString];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        float number;
        [scanner scanFloat:&number];
    
        
        //Calculating the sum
        total=total+number;
        
    }
 
    //Updating  sum to view
    totallbl.text=[NSString stringWithFormat:@"Total Amount = £ %.2f",total];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self updateView];
}
- (IBAction)updateBtn:(id)sender {
        //update the view first
    for (int i=0; i<[orders count]; i++) {
        UIButton *delete=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        delete.frame = CGRectMake(8, (i*30)+132,  40, 20);
        delete.backgroundColor=[UIColor blackColor];
        delete.tintColor=[UIColor orangeColor];
        //[delete setContentEdgeInsets:UIEdgeInsetsMake(0, 4, 0, 4)];
        [delete setTitle:@"Del" forState:UIControlStateNormal];
        //[delete setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
         delete.tag=i+1;
        [delete addTarget:self action:@selector(btnpresses:) forControlEvents:UIControlEventTouchUpInside];
    
       // [delete setBackgroundImage:[[UIImage imageNamed:@"deletebtn.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20)] forState:UIControlStateNormal];
        
        [self.view addSubview:delete];
        
    
    }
    
    //update the backend
    
}
-(void)btnpresses:(UIButton *)sender{
    NSLog(@"btn pressed tag %ld",(long)sender.tag);
    
     UILabel *itemname = (UILabel *)[self.view viewWithTag:sender.tag];
     UILabel *itemprice = (UILabel *)[self.view viewWithTag:sender.tag+100-1];
     NSLog(@"lable name %@ %ld --%@ %ld",itemname.text,(long)itemname.tag,itemprice.text,(long)itemprice.tag);
    
    
    AppDelegate *appD=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[appD managedObjectContext];
    NSFetchRequest *fetchReq=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:context];
    [fetchReq setEntity:entity];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"itemname like %@ AND itemprice like %@",itemname.text,itemprice.text];
    [fetchReq setPredicate:predicate];
    NSError *error;
    orders=[context executeFetchRequest:fetchReq error:&error];
    if ([orders count]<=0) {
        NSLog(@"no item found");
    }
    else{
        for (NSManagedObject *obj in orders) {
            
            [context deleteObject:obj];
            [itemprice removeFromSuperview];
            [itemname removeFromSuperview];
            [sender removeFromSuperview];

        }
        
        [context save:&error];
    }
    
    [self updateAfterdelete];
   [super viewWillAppear:YES];
}

-(void)updateAfterdelete{
    
    total=0.0;

    AppDelegate *appD=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[appD managedObjectContext];
    NSFetchRequest *fetchReq=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Orders" inManagedObjectContext:context];
    [fetchReq setEntity:entity];
    
    NSError *error;
    
    NSArray *ordersUpdate=[[NSArray alloc]initWithArray:[context executeFetchRequest:fetchReq error:&error]];
    
   
    //looping through orders
    for (int i=0; i<[ordersUpdate count]; i++) {
        UILabel *namelbl=[[UILabel alloc]initWithFrame:CGRectMake(50, (i*30)+132, 94, 21)];
        UILabel *pricelbl=[[UILabel alloc]initWithFrame:CGRectMake(230, (i*30)+132, 94, 21)];
        namelbl.tag=i+1;
        namelbl.textColor=[UIColor colorWithRed:0.0 green:153.0 blue:76.0 alpha:1];
        pricelbl.textColor=[UIColor colorWithRed:0.0 green:153.0 blue:76.0 alpha:1];
        pricelbl.tag=i+100;
        namelbl.backgroundColor=[UIColor clearColor];
        namelbl.tintColor=[UIColor redColor];
        namelbl.text=[[ordersUpdate objectAtIndex:i]valueForKey:@"itemname"];
        pricelbl.text=[[ordersUpdate objectAtIndex:i]valueForKey:@"itemprice"];
        [self.view addSubview:namelbl];
        [self.view addSubview:pricelbl];
       
        //Convert String to number (int float)...Takeout int/float part from the string...
        NSString *originalString = [[ordersUpdate objectAtIndex:i]valueForKey:@"itemprice"];
        //NSString *numberString;
        NSScanner *scanner=[NSScanner scannerWithString:originalString];
        NSCharacterSet *numbers = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        [scanner scanUpToCharactersFromSet:numbers intoString:NULL];
        float number;
        [scanner scanFloat:&number];
        
        
        //Calculating the sum
        total=total+number;
        NSLog(@"%f",total);

    }
         totallbl.text=[NSString stringWithFormat:@"Total Amount = £ %.2f",total];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)refreshbtn:(id)sender {
    
    
}
@end
