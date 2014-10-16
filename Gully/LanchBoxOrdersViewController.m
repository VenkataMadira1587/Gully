//
//  LanchBoxOrdersViewController.m
//  Gully
//
//  Created by Venkat on 27/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "LanchBoxOrdersViewController.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>


@interface LanchBoxOrdersViewController ()

@end

@implementation LanchBoxOrdersViewController

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
    AppDelegate *appD=[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context=[appD managedObjectContext];
    NSFetchRequest *fetchRQ=[[NSFetchRequest alloc]init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Lorders" inManagedObjectContext:context];
    [fetchRQ setEntity:entity];
    NSError *error;
    NSArray *contextArr=[context executeFetchRequest:fetchRQ error:&error];
    self.mealorders=[[NSMutableArray alloc]initWithArray:contextArr];
    //[self.mealorders addObjectsFromArray:[context executeFetchRequest:fetchRQ error:&error]];
    [self.mealsTableView reloadData];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView

{
    return 1;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Meals Selected";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier=@"MealsOrder";
    UITableViewCell *cell=[self.mealsTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if (indexPath.row %2 ==1){
		cell.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];}
	else{
		cell.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1];}
    
    cell.textLabel.font=[UIFont boldSystemFontOfSize:14];
    //cell.textLabel.text=
    
    cell.textLabel.text=[[self.mealorders objectAtIndex:indexPath.row]valueForKey:@"mealName"];
    cell.detailTextLabel.text=[[self.mealorders objectAtIndex:indexPath.row]valueForKey:@"type"];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mealorders count];
}

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
            if (editingStyle == UITableViewCellEditingStyleDelete) {
            // Delete the row from the data source
                                
                //[self.mealsTableView dele
                AppDelegate *appD=[[UIApplication sharedApplication]delegate];
                NSManagedObjectContext *context=[appD managedObjectContext];
                NSFetchRequest *fetchReq=[[NSFetchRequest alloc]init];
                NSEntityDescription *entity=[NSEntityDescription entityForName:@"Lorders" inManagedObjectContext:context];
                [fetchReq setEntity:entity];
                
                NSPredicate *predicate=[NSPredicate predicateWithFormat:@"mealName == %@ AND type == %@ ",[[self.mealorders objectAtIndex:indexPath.row]valueForKey:@"mealName"],[[self.mealorders objectAtIndex:indexPath.row]valueForKey:@"type"]];
                [fetchReq setPredicate:predicate];
                NSError *error;
                //self.mealorders =[[NSMutableArray alloc]initWithArray:[context executeFetchRequest:fetchReq error:&error]];
                NSArray *delete=[[NSArray alloc]init ];
                delete=[delete arrayByAddingObjectsFromArray:[context executeFetchRequest:fetchReq error:&error]];
               
                if ([delete count]<= 0) {
                        NSLog(@"no item found");
                }
                else{
                    for (NSManagedObject *obj in delete) {
 
                       [context deleteObject:obj];
                        
                    }
                    if (![context save:&error]) {
                        NSLog(@"Error");
                    }else{
                    
                    [self.mealorders removeObjectAtIndex:indexPath.row];
                    [self.mealsTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                        NSLog(@"Sucess");
                    }
         }

 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
     [self.mealsTableView reloadData];
 }
 
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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

- (IBAction)FinalOrder:(id)sender {
    
    if (self.mealorders==nil) {
        NSLog(@"no meals selected");
    }
    else{
        
        if ([MFMailComposeViewController canSendMail]) {
            email=[[MFMailComposeViewController alloc]init];
            email.mailComposeDelegate=self;
            [email setSubject:@"Customer Selected Meals List"];
            NSArray *toRecepients=[NSArray arrayWithObjects:@"venkat.06453@gmail.com", nil];
            [email setToRecipients:toRecepients];
            NSString *mealName=[[NSString alloc]init];
             //NSString *mealType=[[NSString alloc]init];
            mealName=[mealName stringByAppendingString:@"-------------Meals Selected------------"];
            for (int i=0; i<[self.mealorders count];i++ ) {
                
                mealName=[mealName stringByAppendingString:@"Meal Name: "];
                mealName=[mealName stringByAppendingString:@"\n"];
                
                mealName=[mealName stringByAppendingString:[[self.mealorders objectAtIndex:i]valueForKey:@"mealName"]];
                mealName=[mealName stringByAppendingString:@"\n"];
                mealName=[mealName stringByAppendingString:@"Type: "];
                
                mealName=[mealName stringByAppendingString:[[self.mealorders objectAtIndex:i]valueForKey:@"type"]];
                mealName=[mealName stringByAppendingString:@"\n"];
                mealName=[mealName stringByAppendingString:@"------------------------------------------"];
                
                //mealType=[mealType stringByAppendingString:[[self.mealorders objectAtIndex:i]valueForKey:@"type"]];
            }
          //  NSString *emailBody=[[[ self.mealorders valueForKey:@"mealName"]valueForKey:@"type" ]  componentsJoinedByString:@"," ];
           
            [email setMessageBody:[NSString stringWithFormat:@"%@",mealName] isHTML:NO];
            [self presentViewController:email animated:YES completion:NULL];
        }
    }
}
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled: you cancelled the operation and no email message was queued.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved: you saved the email message in the drafts folder.");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail send: the email message is queued in the outbox. It is ready to send.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed: the email message was not saved or queued, possibly due to an error.");
            break;
        default:
            NSLog(@"Mail not sent.");
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
@end
