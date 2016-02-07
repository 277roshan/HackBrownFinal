//
//  PickUpMessages.h
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MDCSwipeToChoose.h"
#import "DraggableView.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
#import <CoreLocation/CoreLocation.h>

@interface PickUpMessages : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *draggableView;
@property (weak, nonatomic) IBOutlet UIView *draggableBackgroundView;
@property (strong, nonatomic) MSClient *client;
@property (nonatomic,retain) CLLocationManager *locationManager;

@property (nonatomic, strong) NSMutableArray *placeArray;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSMutableArray *senderArray;



@end
