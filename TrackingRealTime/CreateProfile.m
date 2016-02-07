//
//  CreateProfile.m
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import "CreateProfile.h"
#import "LeaveOrPickUp.h"
#import "LoginPage.h"
#import "AppDelegate.h"

@interface CreateProfile ()


@end

@implementation CreateProfile

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage* image3 = [UIImage imageNamed:@"Bakc-arrow.png"];
    CGRect frameimg = CGRectMake(0, 0, 27, 20);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(backButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    _navigationBar.topItem.leftBarButtonItem=mailbutton;}

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

- (IBAction)signUpButtonAction:(id)sender {
    
    NSLog(@"hi");
    
    NSString *uField = _usernameField.text;
    NSUserDefaults *defaultsUsername = [NSUserDefaults standardUserDefaults];
    [defaultsUsername setObject:uField forKey:@"uField"];
    [defaultsUsername synchronize];
    
    NSString *eField = _emailField.text;
    NSUserDefaults *defaultsEmail = [NSUserDefaults standardUserDefaults];
    [defaultsEmail setObject:eField forKey:@"eField"];
    [defaultsEmail synchronize];
    
    NSString *pField = _passwordField.text;
    NSUserDefaults *defaultsPassword = [NSUserDefaults standardUserDefaults];
    [defaultsPassword setObject:pField forKey:@"pField"];
    [defaultsPassword synchronize];
    
    NSString *cpField = _confirmPasswordField.text;
    NSUserDefaults *defaultsConfirmPassword = [NSUserDefaults standardUserDefaults];
    [defaultsConfirmPassword setObject:cpField forKey:@"cpField"];
    [defaultsConfirmPassword synchronize];
    
    LeaveOrPickUp *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leaveorPickupStoryboardID"];
    [self presentModalViewController:viewController animated:YES];
    
    self.client =[MSClient clientWithApplicationURLString:@"https://azur.azure-mobile.net/"
                                           applicationKey:@"dwLrlQrAOkJNXqThtYinhIsmcaCeOT15"];
    
    NSDictionary *item = @{ @"email" : eField, @"password" : pField, @"username" : uField};
    MSTable *itemTable = [self.client tableWithName:@"Users"];
    [itemTable insert:item completion:^(NSDictionary *insertedItem, NSError *error) {
        
        if (error) { NSLog(@"Error: %@", error);
            
        } else { NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
            
        }
    }];
}

-(void)backButtonMethod {
    
    LoginPage *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"loginPageStoryboardID"];
    [self presentModalViewController:viewController animated:YES];
    
}

@end
