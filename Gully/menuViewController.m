//
//  menuViewController.m
//  Gully
//
//  Created by Venkat on 18/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "menuViewController.h"

@interface menuViewController ()

@end

@implementation menuViewController
@synthesize chatBtn,indoBtn,biryaniBtn,sweetBtn;
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
    self.chatBtn.layer.borderColor = [UIColor blackColor].CGColor;
    //self.chatBtn.layer.borderWidth = 1.0;
    //self.chatBtn.layer.cornerRadius = 10;

    self.indoBtn.layer.borderColor = [UIColor blackColor].CGColor;
    //self.indoBtn.layer.borderWidth = 1.0;
    //self.indoBtn.layer.cornerRadius = 15;
    
    self.biryaniBtn.layer.borderColor = [UIColor blackColor].CGColor;
    //self.biryaniBtn.layer.borderWidth = 1.0;
    //self.biryaniBtn.layer.cornerRadius = 10;
    
    self.sweetBtn.layer.borderColor = [UIColor blackColor].CGColor;
    //self.sweetBtn.layer.borderWidth = 1.0;
    //self.sweetBtn.layer.cornerRadius = 10;
    
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
