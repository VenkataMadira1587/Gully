//
//  MainViewController.m
//  Gully
//
//  Created by Venkat on 13/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize imageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.tabBarItem.image=[UIImage imageNamed:@"tabbar3.png"];
//        self.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar3.png"];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor greenColor]];
}
-(void)viewDidAppear:(BOOL)animated{
    self.imageView.animationImages=[NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"menu1.jpg"],
                                    [UIImage imageNamed:@"slide1.jpg"],
                                    [UIImage imageNamed:@"menu3.jpg"],
                                    [UIImage imageNamed:@"slide2.jpg"],
                                    [UIImage imageNamed:@"slide.jpeg"],
                                    [UIImage imageNamed:@"slide4.jpg"],nil];
    self.imageView.animationDuration=10.0;
    
    [self.imageView startAnimating];
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.imageView stopAnimating];
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

@end
