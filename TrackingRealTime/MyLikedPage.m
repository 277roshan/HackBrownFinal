//
//  MyLikedPage.m
//  TrackingRealTime
//
//  Created by AlexsMac on 2/6/16.
//  Copyright © 2016 HackAtBrown. All rights reserved.
//

#import "MyLikedPage.h"
#import "PickUpMessages.h"

@interface MyLikedPage ()

@end

@implementation MyLikedPage

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage* image3 = [UIImage imageNamed:@"Bakc-arrow.png"];
    CGRect frameimg = CGRectMake(0, 0, 27, 20);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameimg];
    [someButton setBackgroundImage:image3 forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(backButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *mailbutton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    _navigationBar.topItem.leftBarButtonItem=mailbutton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backButtonMethod {
    
    PickUpMessages *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PickUpStoryboardID"];
    [self presentModalViewController:viewController animated:YES];
    
}


@end
