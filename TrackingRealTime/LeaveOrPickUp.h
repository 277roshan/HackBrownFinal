//
//  LeaveOrPickUp.h
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveOrPickUp : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *pickUpButton;
@property (weak, nonatomic) IBOutlet UIButton *leaveMessageButton;

- (IBAction)pickUpButtonAction:(id)sender;
- (IBAction)leaveMessageButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;


@end
