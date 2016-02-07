//
//  CreateProfile.h
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface CreateProfile : UIViewController



@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
- (IBAction)signUpButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) MSClient *client;


@end
