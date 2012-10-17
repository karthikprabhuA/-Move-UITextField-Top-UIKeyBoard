//
//  AKPViewController.m
//  UITextFieldScrollingView-sample
//
//  Created by Bala on 10/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AKPViewController.h"

@interface AKPViewController ()

@end

@implementation AKPViewController
@synthesize scrollView;
@synthesize txtUsername;
@synthesize txtPassword;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.txtPassword.secureTextEntry = YES; 
	[self registerForKeyboardNotifications];
    scrollView.bounces = NO;   
}

- (void)viewDidUnload
{
    [self setTxtPassword:nil];
    [self setTxtUsername:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    if(activeField != nil)
    {
        [activeField resignFirstResponder];
       
    }
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //    if(activeField != nil)
    //        [activeField resignFirstResponder];
}
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    //kbSize.height and kbSize.width vary in Orientation
    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
    {
        
        //handle orientation
               
    /*
        CGRect aRect = self.view.frame;
       
        aRect.size.height -= kbSize.height ;//+ 50.f; // add 50.0f if the UITextField slightly outside from keyboard view
            
        if (!CGRectContainsPoint(aRect, activeField.frame.origin) )
        {
            CGPoint scrollPoint = CGPointMake(0.0,activeField.frame.origin.y-kbSize.width+ (activeField.frame.size.height*2));
            [scrollView setContentOffset:scrollPoint animated:YES];
        }
        CGSize content ;
        content.width = self.view.frame.size.height;
        content.height = self.view.frame.size.width+kbSize.width;
        scrollView.contentSize = content;//self.view.frame.size;
     */   
    }
    else
    {
        
        
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your application might not need or want this behavior.
        CGRect aRect = self.view.frame;
  
        aRect.size.height -= kbSize.height+(activeField.frame.size.height*2); // add 50.0f if the UITextField slightly outside from keyboard view
 
        if (!CGRectContainsPoint(aRect, activeField.frame.origin) )
        {
            CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y- kbSize.height);
            [scrollView setContentOffset:scrollPoint animated:YES];
        }
        scrollView.contentSize = self.view.frame.size;
       
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    scrollView.contentOffset = CGPointZero;
/*    if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) 
    {
        if(activeField != nil)
        {
            NSDictionary* info = [aNotification userInfo];
            CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
            CGSize content ;
            content.width = scrollView.contentSize.width;
            content.height =scrollView.contentSize.height - kbSize.width;
            scrollView.contentSize = content;//self.view.frame.size;
        }
    
}
else if(activeField != nil)
    {
        NSDictionary* info = [aNotification userInfo];
        CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
        CGSize content ;
        NSLog(@"hiddeen kbSize h= %f",kbSize.height);
        NSLog(@"hiddeen kbSize w= %f",kbSize.width);
        NSLog(@"hiddeen self.view.frame height = %f",self.view.frame.size.height);
        NSLog(@"hiddeen self.view.frame w = %f",self.view.frame.size.width);
        content.width = self.view.frame.size.width-kbSize.height;
        content.height = self.view.frame.size.height-kbSize.width;
        scrollView.contentSize = content;//self.view.frame.size;
    }
*/
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

//handle default return key
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
