//
//  TCViewController.m
//  World Traveler
//
//  Created by yousheng chang on 9/12/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "TCListViewController.h"
#import "TCFourSquareSessionManager.h"
#import "AFMMRecordResponseSerializationMapper.h"
#import "AFMMRecordResponseSerializer.h"
#import "Venue.h"
#import "Location.h"
#import "TCMapViewController.h"

static NSString *const kCLIENTID = @"DFJ5UOHLCB0BBOEZDC244F3TXZLOEGLZY5O11A2DSLVFUFY4";
static NSString *const kCLIENTSECRET = @"XGSHJLLF4YNK14CXIUF1PQRMZVXX2BAMAK3LQCTDISMRAYJE";

#define latitudeOffset 0.01
#define longitudeOffset 0.01


@interface TCListViewController ()<CLLocationManagerDelegate>

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) CLLocationManager *locationManager;


@end

@implementation TCListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    self.locationManager.distanceFilter = 10.0;
    
    
    TCFourSquareSessionManager *sessionManager = [TCFourSquareSessionManager sharedClient];
    NSManagedObjectContext *context = [NSManagedObjectContext MR_defaultContext];
    
    AFHTTPResponseSerializer *HTTPResponseSerializer = [AFJSONResponseSerializer serializer];
    AFMMRecordResponseSerializationMapper *mapper = [[AFMMRecordResponseSerializationMapper alloc]init];
    [mapper registerEntityName:@"Venue" forEndpointPathComponent:@"venues/search?"];
    AFMMRecordResponseSerializer *serializer = [AFMMRecordResponseSerializer serializerWithManagedObjectContext:context responseObjectSerializer:HTTPResponseSerializer entityMapper:mapper];
    sessionManager.responseSerializer = serializer;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = sender;
    Venue *venue = self.venues[indexPath.row];
    TCMapViewController *mapVC = segue.destinationViewController;
    mapVC.venue = venue;
    
}

#pragma mark IBAction

- (IBAction)refreshBarButtonPressed:(UIBarButtonItem *)sender {
   
    [self.locationManager startUpdatingLocation];
    
}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    [self.locationManager stopUpdatingLocation];
    
    [[TCFourSquareSessionManager sharedClient]GET:[NSString stringWithFormat:@"venues/search?ll=%f,%f", location.coordinate.latitude + latitudeOffset, location.coordinate.longitude + longitudeOffset] parameters:@{@"client_id":kCLIENTID, @"client_secret": kCLIENTSECRET, @"v": @"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *venues = responseObject;
        self.venues = venues;
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"task: %@", task.originalRequest);
        NSLog(@"Error: %@", error);
        
    }];
    
    
    [self.tableView reloadData];

    
}
#pragma mark - UITableView data Source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionInTableView called.");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection: %d", [self.venues count]);
    return [self.venues count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRowAtIndexpath called.");
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
 
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        
    }
    
    Venue *venue = self.venues[indexPath.row];
    
    NSLog(@"row = %d", indexPath.row);
    NSLog(@"venue %@", venue);
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    
    
    
    return cell;
    
}

#pragma mark - UITableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"listToMapSegue" sender:indexPath];
    
}
@end
