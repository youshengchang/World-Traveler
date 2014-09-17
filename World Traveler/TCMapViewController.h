//
//  TCMapViewController.h
//  World Traveler
//
//  Created by yousheng chang on 9/12/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Venue.h"

@interface TCMapViewController : UIViewController
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) Venue *venue;

@end
