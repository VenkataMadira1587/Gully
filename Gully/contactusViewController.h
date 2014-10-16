//
//  contactusViewController.h
//  Gully
//
//  Created by Venkat on 20/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
@interface contactusViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIScrollViewDelegate,MFMailComposeViewControllerDelegate>{
    MFMailComposeViewController *mailer;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTXT;
@property (weak, nonatomic) IBOutlet UITextField *emailTXT;
@property (weak, nonatomic) IBOutlet UITextField *phoneTXT;
@property (weak, nonatomic) IBOutlet UITextView *commentsTXT;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;

-(IBAction)sendBtn:(id)sender;
@end
