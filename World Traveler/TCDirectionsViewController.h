//
//  TCDirectionsViewController.h
//  World Traveler
//
//  Created by yousheng chang on 9/19/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"
#import "Location.h"


@interface TCDirectionsViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet MKMapView *directionsMap;

@property (strong, nonatomic) Venue *venue;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) NSArray *steps;

- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
