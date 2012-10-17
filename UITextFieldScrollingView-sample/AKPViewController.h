//
//  AKPViewController.h
//  UITextFieldScrollingView-sample
//
//  Created by Bala on 10/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKPViewController : UIViewController<UITextFieldDelegate>
{
    UITextField* activeField;
}
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@end
