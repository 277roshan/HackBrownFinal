//
//  LeaveMessages.h
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import <CoreLocation/CoreLocation.h>

@interface LeaveMessages : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *MessageField;
@property (weak, nonatomic) IBOutlet UIButton *uploadMediaButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UITextField *whereAreYouField;

- (IBAction)uploadMediaButtonAction:(id)sender;
- (IBAction)submitButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (strong, nonatomic) MSClient *client;
@property (nonatomic,retain) CLLocationManager *locationManager;

@end
