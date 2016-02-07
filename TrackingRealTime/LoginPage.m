//
//  LoginPage.m
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import "LoginPage.h"
#import "CreateProfile.h"
#import "LeaveOrPickUp.h"

@interface LoginPage ()

@end

@implementation LoginPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signInButtonAction:(id)sender {
    
    NSString *eField = _emailField.text;
    NSUserDefaults *defaultsEmail = [NSUserDefaults standardUserDefaults];
    [defaultsEmail setObject:eField forKey:@"eField"];
    [defaultsEmail synchronize];
    
    NSString *pField = _passwordField.text;
    NSUserDefaults *defaultsPassword = [NSUserDefaults standardUserDefaults];
    [defaultsPassword setObject:pField forKey:@"pField"];
    [defaultsPassword synchronize];
    
    
    LeaveOrPickUp *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leaveorPickupStoryboardID"];
    [self presentModalViewController:viewController animated:YES];
    
}

- (IBAction)signUpAction:(id)sender {
    
    CreateProfile *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"createProfileStoryboardID"];
    [self presentModalViewController:viewController animated:YES];
}
@end
