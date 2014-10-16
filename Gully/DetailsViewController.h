//
//  DetailsViewController.h
//  Gully
//
//  Created by Venkat on 13/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface DetailsViewController : UIViewController
@property (nonatomic, strong) IBOutlet UILabel *recipeLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UIImageView *recipeImge;
@property (nonatomic, strong) NSString *recipeName;
@property(nonatomic,strong)NSString *recipePrice;
@property(nonatomic,strong)NSString *imageName;
- (IBAction)orderSave:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end
