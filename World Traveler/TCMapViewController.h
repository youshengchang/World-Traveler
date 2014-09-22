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
//IBOutlet
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@property (strong, nonatomic) Venue *venue;
- (IBAction)showDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender;
- (IBAction)favoriteButtonPressed:(UIButton *)sender;

@end
