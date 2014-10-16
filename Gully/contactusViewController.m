//
//  contactusViewController.m
//  Gully
//
//  Created by Venkat on 20/06/2014.
//  Copyright (c) 2014 Venkat. All rights reserved.
//

#import "contactusViewController.h"

@interface contactusViewController ()

@end

@implementation contactusViewController
@synthesize nameTXT,emailTXT,phoneTXT,commentsTXT,scrollView,lblMessage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        self.tabBarItem.image=[UIImage imageNamed:@"tabbar1.png"];
//        self.tabBarItem.selectedImage=[UIImage imageNamed:@"tabbar1.png"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.nameTXT.delegate=self;
    self.phoneTXT.delegate= self;
    self.emailTXT.delegate=self;
    self.commentsTXT.delegate=self;
    self.lblMessage.text=@"";
    self.nameTXT.text=@"";
    self.phoneTXT.text= @"";
    self.emailTXT.text=@"";
    self.commentsTXT.text =@"";
    self.scrollView.contentSize=CGSizeMake(320, 500);
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   
    [self.nameTXT resignFirstResponder];
    [self.phoneTXT resignFirstResponder];
    [self.emailTXT resignFirstResponder];
    [self.commentsTXT resignFirstResponder];
    
    
}
-(IBAction)sendBtn:(id)sender{
    
    if ([self.nameTXT.text isEqual:@""] && [self.emailTXT.text  isEqual: @""] ) {
        self.lblMessage.text=@"PLEASE ENETER NAME EMAIL AND PHONE NUMABER..";
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"INVALID DETAILS" message:@"Please Enter Correct details" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
    if ([MFMailComposeViewController canSendMail]) {
        mailer = [[MFMailComposeViewController alloc] init];
        
        mailer.mailComposeDelegate = self;
        
        [mailer setSubject:[NSString stringWithFormat:@"Enquiry for %@",nameTXT.text]];
        
        NSArray *toRecipients = [NSArray arrayWithObjects:@"venkat.06453@gmail.com", nil];
        [mailer setToRecipients:toRecipients];
        
       // UIImage *myImage = [UIImage imageNamed:@"kus.png"];
       // NSData *imageData = UIImagePNGRepresentation(myImage);
        //[mailer addAttachmentData:imageData mimeType:@"image/png" fileName:@"mobiletutsImage"];
        
        NSString *emailBody = [NSString stringWithFormat:@"Name : %@ \n Email :%@ \n Telephone :%@ \n Deatails :%@ ",self.nameTXT.text,self.emailTXT.text,self.phoneTXT.text,self.commentsTXT.text];
        [mailer setMessageBody:emailBody isHTML:NO];
        
        [self presentViewController:mailer animated:YES completion:NULL];
    }
}
    
}
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
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
    self.nameTXT.text=@"";
    self.emailTXT.text=@"";
    self.phoneTXT.text=@"";
    self.commentsTXT.text =@"";
    self.lblMessage.text=@"Don't Worry We keep your information SAFE!";
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//keyboard move up................
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    self.commentsTXT.text=@"";
    if (textView==self.commentsTXT) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-75, self.view.frame.size.width, self.view.frame.size.height);
        
    }
    return YES;
    
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    if (textView==self.commentsTXT) {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        //[UIView setAnimationDuration:0.1];
        [UIView setAnimationBeginsFromCurrentState:YES];
        self.view.frame=CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 75, self.view.frame.size.width, self.view.frame.size.height);
        
    }
    return YES;
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)registerForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)deregisterFromKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardDidHideNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self registerForKeyboardNotifications];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [self deregisterFromKeyboardNotifications];
    
    [super viewWillDisappear:animated];
    
}
- (void)keyboardWasShown:(NSNotification *)notification {
    
    NSDictionary* info = [notification userInfo];
    
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGPoint buttonOrigin = self.sendBtn.frame.origin;
    
    CGFloat buttonHeight = self.sendBtn.frame.size.height;
    
    CGRect visibleRect = self.view.frame;
    
    visibleRect.size.height -= keyboardSize.height;
    
    if (!CGRectContainsPoint(visibleRect, buttonOrigin)){
        
        CGPoint scrollPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight);
        
        [self.scrollView setContentOffset:scrollPoint animated:YES];
        
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    
    [self.scrollView setContentOffset:CGPointZero animated:YES];
    
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
