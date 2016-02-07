//
//  LeaveOrPickUp.m
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import "LeaveOrPickUp.h"
#import "PickUpMessages.h"
#import "LeaveMessages.h"

@interface LeaveOrPickUp ()

@end

@implementation LeaveOrPickUp

- (void)viewDidLoad {
    
    
    
    [super viewDidLoad];


    
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

- (IBAction)pickUpButtonAction:(id)sender {
    
    
    PickUpMessages *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"pickUpStoryboardID"];
    [self presentModalViewController:viewController animated:YES];
    
}

- (IBAction)leaveMessageButtonAction:(id)sender {
    
    LeaveMessages *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leaveMessageStoryboardID"];
    [self presentModalViewController:viewController animated:YES];
    
}



@end
