//
//  PickUpMessages.m
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import "PickUpMessages.h"
#import "LeaveOrPickUp.h"
#import "DraggableView.h"   
#import "DraggableViewBackground.h"
#import "AppDelegate.h"


@interface PickUpMessages ()

@property CLLocationCoordinate2D currentLocation;


@end

@implementation PickUpMessages

@synthesize placeArray, contentArray, senderArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.client =[MSClient clientWithApplicationURLString:@"https://azur.azure-mobile.net/"
                                           applicationKey:@"dwLrlQrAOkJNXqThtYinhIsmcaCeOT15"];
    //
    //    NSDictionary *item = @{ @"place" : whereAreYouField, @"content" : messageField, @"latitude": @(self.currentLocation.latitude), @"longitude": @(self.currentLocation.longitude)};
    MSTable *itemTable = [self.client tableWithName:@"Messages"];
    NSLog(@"ITEMTABLE: %@", itemTable);
    NSLog(@"self.client: %@", self.client);

    //    [itemTable insert:item completion:^(NSDictionary *insertedItem, NSError *error) {
    //
    //        if (error) { NSLog(@"Error: %@", error);
    //
    //        } else { NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
    //
    //        }
    //    }];
    
    NSDictionary *placeDictionary;
    placeArray =  [NSMutableArray array];
    contentArray =  [NSMutableArray array];
    senderArray =  [NSMutableArray array];



    
    [itemTable readWithCompletion:^(MSQueryResult *result, NSError *error) {
        NSLog(@"result: %@", result);
        NSLog(@"error: %@", error);
        
//        if(error) { // error is nil if no error occured
//            NSLog(@"ERROR %@", error);
//        } else {
            for (NSDictionary *item in result.items) { // items is NSArray of records that match query
//                    NSLog(@"item: %@", item);
                    NSLog(@"result.items: %@", result.items);
                    
//                    for(int i = 0; i < [result.items count]; i++) {
    
//                    placeDictionary = result.items objectAtIndex:i];
                    [placeArray addObject:[item objectForKey:@"place"]];
                [contentArray addObject:[item objectForKey:@"content"]];
                [senderArray addObject:[item objectForKey:@"sender"]];

                NSUserDefaults *placeArrayDefaults = [NSUserDefaults standardUserDefaults];
                [placeArrayDefaults setObject:placeArray forKey:@"placeArray"];
                [placeArrayDefaults synchronize];
                
                        
//                    }
NSLog(@"placeArray: %@", placeArray);
                NSLog(@"contentArray: %@", contentArray);
                NSLog(@"senderArray: %@", senderArray);

                NSNumber* latitude = [item objectForKey:@"latitude"];
                NSNumber* longitude = [item objectForKey:@"longitude"];
                CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
                if ([self calculateDistance:self.currentLocation to:location] < 100)
                {
                    NSLog(@"Todo Item: %@", [item objectForKey:@"content"]);
                    NSLog(@"latitude: %@ longitude: %@", latitude, longitude);
                }
//            }
        }
    }];
    

    DraggableViewBackground *draggableBackground = [[DraggableViewBackground alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:draggableBackground];
    
//    DraggableView *draggableBackground = [[DraggableView alloc]initWithFrame:self.draggableBackgroundView.bounds];
//    [self.draggableBackgroundView addSubview:draggableBackground];
    


    
    UIImage* image3 = [UIImage imageNamed:@"Bakc-arrow.png"];
    CGRect frameimg = CGRectMake(0, 0, 27, 20);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(backButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    _navigationBar.topItem.leftBarButtonItem=mailbutton;
    
    

   
    

    
    
    
    
}



-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    UIAlertView *errorAlert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"There was an error retrieving your location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorAlert show];
    NSLog(@"Error: %@",error.description);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *crnLoc = [locations lastObject];
    CLLocationCoordinate2D coord = crnLoc.coordinate;
    self.currentLocation = coord;
    
    
    [self.locationManager stopUpdatingLocation];
}

- (NSString *)deviceLocation
{
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    return theLocation;
}

- (double)calculateDistance:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to {
    double lat1 = from.latitude * M_PI / 180;
    double lat2 = to.latitude * M_PI/180;
    double lng1 = from.longitude * M_PI / 180;
    double lng2 = to.longitude * M_PI/180;
    
    double lat_distance = lat1 - lat2;
    double lng_distance = lng1 - lng2;
    double a = sin(lat_distance/2) * sin(lat_distance/2) + cos(lat1)*cos(lat2)* sin(lng_distance/2)*sin(lng_distance/2);
    double c = 2 * atan2(sqrt(a), sqrt(1-a));
    double dist = c * 3959*5280;      // in feet
    return dist;
}

//- (CGRect)frontCardViewFrame {
//    CGFloat horizontalPadding = 20.f;
//    CGFloat topPadding = 60.f;
//    CGFloat bottomPadding = 200.f;
//    return CGRectMake(horizontalPadding,
//                      topPadding,
//                      CGRectGetWidth(self.view.frame) - (horizontalPadding * 2),
//                      CGRectGetHeight(self.view.frame) - bottomPadding);
//}
//
//// This is called when a user didn't fully swipe left or right.
//- (void)viewDidCancelSwipe:(UIView *)view {
//    NSLog(@"Couldn't decide, huh?");
//}
//
//// Sent before a choice is made. Cancel the choice by returning `NO`. Otherwise return `YES`.
//- (BOOL)view:(UIView *)view shouldBeChosenWithDirection:(MDCSwipeDirection)direction {
//    if (direction == MDCSwipeDirectionLeft) {
//        return YES;
//    } else {
//        // Snap the view back and cancel the choice.
//        [UIView animateWithDuration:0.16 animations:^{
//            _viewUI.transform = CGAffineTransformIdentity;
//            _viewUI.center = [_viewUI superview].center;
//        }];
//        return NO;
//    }
//}
//
//// This is called then a user swipes the view fully left or right.
//- (void)view:(UIView *)view wasChosenWithDirection:(MDCSwipeDirection)direction {
//    if (direction == MDCSwipeDirectionLeft) {
//        NSLog(@"Photo deleted!");
//    } else {
//        NSLog(@"Photo saved!");
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonMethod {
    
    LeaveOrPickUp *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leaveorPickupStoryboardID"];
    [self presentModalViewController:viewController animated:YES];
    
}


@end
