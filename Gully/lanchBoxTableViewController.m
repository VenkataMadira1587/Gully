//
//  lanchBoxTableViewController.m
//  Gully
//
//  Created by Venkat on 25/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "lanchBoxTableViewController.h"
#import "MealDetailsViewController.h"

@interface lanchBoxTableViewController (){
    NSDictionary *dict;
    NSArray *myvalues;
}
@property(nonatomic,strong)NSDate *week1Start;
@property(nonatomic,strong)NSDate *week1End;
@property(nonatomic,strong)NSDate *week2Start;
@property(nonatomic,strong)NSDate *week2End;
@property(nonatomic,strong)NSDate *week3Start;
@property(nonatomic,strong)NSDate *week3End;


@end

@implementation lanchBoxTableViewController
@synthesize weekTableView;
@synthesize week1Start,week1End,week2Start,week2End,week3Start,week3End;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)findweekdays
{
    NSDate *today=[NSDate date];
    // NSLog(@"Today %@",today);
    NSDateFormatter *dateformat=[[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"DD-MM-YYYY"];
    
    NSCalendar *gregorian=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components=[gregorian components:NSWeekdayCalendarUnit |NSYearCalendarUnit |NSMonthCalendarUnit |NSDayCalendarUnit fromDate:today];
    NSInteger dayofWeek=[[[NSCalendar currentCalendar]components:NSWeekdayCalendarUnit |NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit fromDate:today]weekday];
    NSInteger monthOfYear=[[[NSCalendar currentCalendar]components:NSWeekdayCalendarUnit |NSMonthCalendarUnit|NSYearCalendarUnit|NSDayCalendarUnit fromDate:today]month];
    [components setDay:([components day]-((dayofWeek)-2))];
    [components setMonth:monthOfYear];
    [components setYear:[components year]];
    NSDate *beginingingofWeek=[gregorian dateFromComponents:components];
    NSLog(@"%@",beginingingofWeek);
    self.week1Start=[beginingingofWeek dateByAddingTimeInterval:24*3600];
    NSDateFormatter *dateFormat1=[[NSDateFormatter alloc]init];
    [dateFormat1 setDateFormat:@"MM-DD"];
    [dateFormat1 stringFromDate:self.week1Start];
    NSLog(@"Week 1 Start %@ ",self.week1Start);
    
    self.week1End=[self.week1Start dateByAddingTimeInterval:4*24*3600];
    [dateFormat1 stringFromDate:self.week1End];
    NSLog(@"Week 1 End%@",self.week1End);
    self.week2Start=[self.week1End dateByAddingTimeInterval:3*24*3600];
    [dateFormat1 stringFromDate:self.week2Start];
    NSLog(@"Week 2 Start %@",self.week2Start);
    self.week2End  =[self.week2Start dateByAddingTimeInterval:4*24*3600];
    [dateFormat1 stringFromDate:self.week2End];
    NSLog(@" Week 2 End %@",self.week2End);
    self.week3Start=[self.week2End dateByAddingTimeInterval:3*24*3600];
    [dateFormat1 stringFromDate:self.week3Start];
    NSLog(@"Week 3 Starts %@",self.week3Start);
    self.week3End=[self.week3Start dateByAddingTimeInterval:4*24*3600];
    [dateFormat1 stringFromDate:self.week3End];
    NSLog(@"Week 3 Ends %@",self.week3End);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path=[[NSBundle mainBundle]pathForResource:@"launchBox" ofType:@"plist"];
    dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    myvalues=[[NSArray alloc]initWithArray:[dict allValues]];
    dispatch_queue_t background=dispatch_queue_create("uk.co.gullykitchen.www", NULL);
    dispatch_async(background, ^{
        [self findweekdays];
    });
     self.weekTableView.backgroundColor = [UIColor colorWithRed:.9 green:.8 blue:.7 alpha:1];
    
}
- (NSString *)applicationDocumentsDirectory {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

-(NSDictionary*)filterdictionary:(NSDictionary*)mydict{
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"key" ascending:YES comparator:^(id obj1, id obj2) {
        
        if (obj1 > obj2) {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if (obj1 < obj2) {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    NSArray *sortedKeys = [[mydict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSMutableDictionary *orderedDictionary = [NSMutableDictionary dictionary];
    
    for (NSString *index in sortedKeys) {
        [orderedDictionary setObject:[mydict objectForKey:index] forKey:index];
    }
    
    mydict = orderedDictionary;
    return mydict;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return (unsigned long)[dict allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [[dict objectForKey:[[dict allKeys]objectAtIndex:section]] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Cell";
    
    UITableViewCell *cell=[self.weekTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    if (indexPath.row %2 ==1){
        //cell.backgroundColor=[UIColor clearColor];
		cell.backgroundColor = [UIColor colorWithRed:.7 green:.9 blue:.9 alpha:1];}
	else{
       		cell.backgroundColor = [UIColor colorWithRed:.6 green:.8 blue:.8 alpha:1];}
    
   // NSLog(@"%@",[[[myvalues objectAtIndex:indexPath.section]allKeys]objectAtIndex:indexPath.row]);
    cell.textLabel.text=[[[myvalues objectAtIndex:indexPath.section]allKeys]objectAtIndex:indexPath.row];

    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   // UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 150, 20)];
    
    if (section==0) {
        //NSLog(@"%@",[[dict allKeys]objectAtIndex:section]);
        
        return [NSString stringWithFormat:@"Week %@ (%@ )",[[dict allKeys]objectAtIndex:section],self.week1Start];
        
    }
    else if (section==1) {
          //NSLog(@"%@",[[dict allKeys]objectAtIndex:section]);
        return [NSString stringWithFormat:@"Week %@ (%@ )",[[dict allKeys]objectAtIndex:section],self.week2Start];
    }
    else {
          //NSLog(@"%@",[[dict allKeys]objectAtIndex:section]);
       
        
        return [NSString stringWithFormat:@"Week %@ (%@ )",[[dict allKeys]objectAtIndex:section],self.week3Start];
    }
    //return [[dict allKeys]objectAtIndex:section];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.textLabel.textColor=[UIColor redColor];
    header.textLabel.font=[UIFont systemFontOfSize:16];
}
/*-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,300,60)];
    
    if (section==0) {
        
        [headerView setBackgroundColor:[UIColor colorWithRed:.9 green:.8 blue:.7 alpha:1]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont boldSystemFontOfSize:15];
        label.frame=CGRectMake(0, 20, 200, 20);
        //label.text=@"titles";
        label.textColor=[UIColor redColor];
        label.text =@"Week 1"; //[NSString stringWithFormat:@"%@ ----%@ -- %@",[[dict allKeys]objectAtIndex:section],self.week1Start,self.week1End];
        [headerView addSubview:label];

    }
    else if (section==1){
        //UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,300,60)];
        [headerView setBackgroundColor:[UIColor colorWithRed:.9 green:.8 blue:.7 alpha:1]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont boldSystemFontOfSize:15];
        label.frame=CGRectMake(0, 20, 200, 20);
        //label.text=@"titles";
        label.textColor=[UIColor redColor];
        label.text = @"WEEk 2";//[NSString stringWithFormat:@"%@ ----%@ -- %@",[[dict allKeys]objectAtIndex:section],self.week2Start,self.week2End];
        [headerView addSubview:label];

    }
    else{
       // UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,300,60)];
        [headerView setBackgroundColor:[UIColor colorWithRed:.9 green:.8 blue:.7 alpha:1]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont boldSystemFontOfSize:15];
        label.frame=CGRectMake(0, 20, 200, 20);
        //label.text=@"titles";
        label.textColor=[UIColor redColor];
        label.text = @"WEEK 3";//[NSString stringWithFormat:@"%@ ----%@ -- %@",[[dict allKeys]objectAtIndex:section],self.week3Start,self.week3End];
        [headerView addSubview:label];

    }
    
   // label.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.75];
    //label.backgroundColor = [UIColor clearColor];
    //[headerView addSubview:label];
        return headerView;
}*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"mealDetail"]) {
        NSIndexPath *indexPath=[self.weekTableView indexPathForSelectedRow];
        
        NSString *value11=[[[myvalues objectAtIndex:indexPath.section]allValues]objectAtIndex:indexPath.row];
       
        MealDetailsViewController *day=segue.destinationViewController ;
        day.mealDetail=value11;
       
}
}

@end
