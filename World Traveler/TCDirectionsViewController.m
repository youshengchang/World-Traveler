//
//  TCDirectionsViewController.m
//  World Traveler
//
//  Created by yousheng chang on 9/19/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "TCDirectionsViewController.h"

@interface TCDirectionsViewController ()

@end

@implementation TCDirectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)listDirectionsBarButtonItemPressed:(UIBarButtonItem *)sender {
}


#pragma mark - CLLocationmanager Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [manager stopUpdatingLocation];
    
    self.directionsMap.showsUserLocation = YES;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 3000, 3000);
    [self.directionsMap setRegion:[self.directionsMap regionThatFits:region] animated:YES];
    
    float latitude = [self.venue.location.lat floatValue];
    float langitude = [self.venue.location.lng floatValue];
    MKPlacemark *placemark = [[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(latitude, langitude) addressDictionary:nil];
    MKMapItem *destinationMapItem = [[MKMapItem alloc]initWithPlacemark:placemark];
    
    [self getDirections:destinationMapItem];
    
    
}

#pragma helper
-(void)getDirections:(MKMapItem *)destination
{
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
    request.source = [MKMapItem mapItemForCurrentLocation];
    request.destination = destination;
    request.requestsAlternateRoutes = YES;
    
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        if(error){
            //Do something to handle error
            NSLog(@"%@", error);
        }else{
            //Do something with the directions here
            [self showRoute:response];
        }
    }];
    
}

#pragma mark - Route Helper

-(void)showRoute:(MKDirectionsResponse *)response
{
    self.steps = response.routes;
    
    for(MKRoute *route in self.steps){
        for(MKRouteStep *step in route.steps){
            NSLog(@"step instructions %@", step.instructions);
        }
    }
}
    
@end
