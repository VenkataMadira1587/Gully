////
//  ViewController.m
//  Gully
//
//  Created by Venkat on 13/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "ViewController.h"
#import "DetailsViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray *recipies;
}
@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   // recipies =[NSArray arrayWithObjects:@"Pani Puri",@"Voda Pav" ,@"Punugulu ",@"Egg Bajji",@"Samosa Cutlet",@"Dhai Puri",@"Bhel Puri",@"Dum Veg Biryani",@"Dum Chicken Birtani",@"Dum Lamb Biryani",@"Plain Dosa",@"Masala Dosa",@"Panner Dosa",@"Mirchi Bajji",nil];
    
    NSString *path=[[NSBundle mainBundle]pathForResource:@"RecipeList" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    tableData=[dict objectForKey:@"RecipeName"];
    thumbnail=[dict objectForKey:@"Thumbnail"];
    price=[dict objectForKey:@"Price"];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_bg.jpg"]];
    [tempImageView setFrame:self.tableView.frame];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundView = tempImageView;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier=@"RecipeCell";
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        
    }
    if (indexPath.row %2 ==1){
		cell.backgroundColor = [UIColor colorWithRed:.9 green:.9 blue:.9 alpha:1];}
	else{
		cell.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:1];}
    //cell.textLabel.text=[tableData objectAtIndex:indexPath.row];
    UILabel *recipeName = (UILabel *)[cell viewWithTag:101];
    recipeName.text=[tableData objectAtIndex:indexPath.row];
    
    UILabel *pricelbl=(UILabel *)[cell viewWithTag:102];
    pricelbl.text= [price objectAtIndex:indexPath.row];
    
    UIImageView *recipeImage=(UIImageView *)[cell viewWithTag:100];
    recipeImage.image=[UIImage imageNamed:[thumbnail objectAtIndex:indexPath.row]];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     
     if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
         NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
         DetailsViewController *details=segue.destinationViewController;
         details.recipeName=[tableData objectAtIndex:indexPath.row];
         details.recipePrice=[price objectAtIndex:indexPath.row];
         details.imageName=[thumbnail objectAtIndex:indexPath.row];
         
     }
  }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
