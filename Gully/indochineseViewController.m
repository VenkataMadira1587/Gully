//
//  indochineseViewController.m
//  Gully
//
//  Created by Venkat on 18/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "indochineseViewController.h"
#import "DetailsViewController.h"
@interface indochineseViewController ()

@end

@implementation indochineseViewController
@synthesize tableview;
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
    NSString *path=[[NSBundle mainBundle]pathForResource:@"indoChainese" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    tableData=[dict objectForKey:@"RecipeName"];
    thumbnail=[dict objectForKey:@"Thumbnail"];
    price=[dict objectForKey:@"Price"];
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_bg.jpg"]];
    [tempImageView setFrame:self.tableview.frame];
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.backgroundView = tempImageView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"RecipeCell";
    UITableViewCell *cell=[self.tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    if (indexPath.row %2 ==1){
		cell.backgroundColor = [UIColor colorWithRed:.7 green:.6 blue:.5 alpha:1];}
	else{
		cell.backgroundColor = [UIColor colorWithRed:.5 green:.4 blue:.3 alpha:1];}
    //cell.textLabel.text=[tableData objectAtIndex:indexPath.row];
    UILabel *recipeName = (UILabel *)[cell viewWithTag:101];
    recipeName.text=[tableData objectAtIndex:indexPath.row];
    
    UILabel *pricelbl=(UILabel *)[cell viewWithTag:102];
    pricelbl.text= [price objectAtIndex:indexPath.row];
    
    UIImageView *recipeImage=(UIImageView *)[cell viewWithTag:100];
    recipeImage.image=[UIImage imageNamed:[thumbnail objectAtIndex:indexPath.row]];
    return cell;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
 
 if ([segue.identifier isEqualToString:@"indochinese"]) {
 NSIndexPath *indexPath=[self.tableview indexPathForSelectedRow];
 DetailsViewController *details=segue.destinationViewController;
 details.recipeName=[tableData objectAtIndex:indexPath.row];
 details.recipePrice=[price objectAtIndex:indexPath.row];
 details.imageName=[thumbnail objectAtIndex:indexPath.row];
 
 }

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
