//
//  LeaveMessages.m
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import "LeaveMessages.h"
#import "LeaveOrPickUp.h"
#import "PickUpMessages.h"
#import "AppDelegate.h"

@interface LeaveMessages ()

@property CLLocationCoordinate2D currentLocation;

@end

@implementation LeaveMessages

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];

    UIImage* image3 = [UIImage imageNamed:@"Bakc-arrow.png"];
    CGRect frameimg = CGRectMake(0, 0, 27, 20);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(backButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    _navigationBar.topItem.leftBarButtonItem=mailbutton;
    
    NSUserDefaults *defaultsMessageField = [NSUserDefaults standardUserDefaults];
    [defaultsMessageField removeObjectForKey:@"messageField"];
    
    NSUserDefaults *defaultsWhereAreYou = [NSUserDefaults standardUserDefaults];
    [defaultsWhereAreYou removeObjectForKey:@"whereAreYouField"];
    
    NSLog(@"messageField: %@", _MessageField);
    NSLog(@"whereAreYouField: %@", _whereAreYouField);
    

    


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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)deviceLocation
{
    NSString *theLocation = [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
    return theLocation;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)backButtonMethod {
    
    LeaveOrPickUp *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"leaveorPickupStoryboardID"];
    [self presentModalViewController:viewController animated:YES];
    
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

- (IBAction)uploadMediaButtonAction:(id)sender {
}

- (IBAction)submitButtonAction:(id)sender {
    
    NSString *whereAreYouField = _whereAreYouField.text;
    NSUserDefaults *defaultsWhereAreYou = [NSUserDefaults standardUserDefaults];
    [defaultsWhereAreYou setObject:whereAreYouField forKey:@"whereAreYouField"];
    [defaultsWhereAreYou synchronize];
    
    NSString *messageField = _MessageField.text;
    NSUserDefaults *defaultsMessageField = [NSUserDefaults standardUserDefaults];
    [defaultsMessageField setObject:messageField forKey:@"messageField"];
    [defaultsMessageField synchronize];
    
    self.client =[MSClient clientWithApplicationURLString:@"https://azur.azure-mobile.net/"
                                           applicationKey:@"dwLrlQrAOkJNXqThtYinhIsmcaCeOT15"];
    
    NSDictionary *item = @{ @"place" : whereAreYouField, @"content" : messageField, @"latitude": @(self.currentLocation.latitude), @"longitude": @(self.currentLocation.longitude)};
    MSTable *itemTable = [self.client tableWithName:@"Messages"];
    [itemTable insert:item completion:^(NSDictionary *insertedItem, NSError *error) {
        
        if (error) { NSLog(@"Error: %@", error);
            
        } else { NSLog(@"Item inserted, id: %@", [insertedItem objectForKey:@"id"]);
            
        }
    }];
    
    NSLog(@"ITEMTABLE: %@", itemTable);
    NSLog(@"self.client: %@", self.client);
    
    
    [itemTable readWithCompletion:^(MSQueryResult *result, NSError *error) {
        if(error) { // error is nil if no error occured
            NSLog(@"ERROR %@", error);
        } else {
            for(NSDictionary *item in result.items) { // items is NSArray of records that match query
                NSNumber* latitude = [item objectForKey:@"latitude"];
                NSNumber* longitude = [item objectForKey:@"longitude"];
                CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
                if ([self calculateDistance:self.currentLocation to:location] < 100)
                {
                    NSLog(@"Todo Item: %@", [item objectForKey:@"content"]);
                    NSLog(@"latitude: %@ longitude: %@", latitude, longitude);
                }
            }
        }
    }];
    
//
//
//    PickUpMessages *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PickupStoryboardID"];
//    
//    [self presentModalViewController:viewController animated:YES];
    
    
    
    
}
@end
