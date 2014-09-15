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

static NSString *const kCLIENTID = @"DFJ5UOHLCB0BBOEZDC244F3TXZLOEGLZY5O11A2DSLVFUFY4";
static NSString *const kCLIENTSECRET = @"XGSHJLLF4YNK14CXIUF1PQRMZVXX2BAMAK3LQCTDISMRAYJE";


@interface TCListViewController ()

@property (strong, nonatomic) NSArray *venues;

@end

@implementation TCListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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

#pragma mark IBAction

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    NSLog(@"refreshBarButtonItemPressed!");
    
    [[TCFourSquareSessionManager sharedClient]GET:@"venues/search?ll=30.25,-97.75" parameters:@{@"client_id":kCLIENTID, @"client_secret": kCLIENTSECRET, @"v": @"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *venues = responseObject;
        self.venues = venues;
        NSLog(@" Success: self.venues: %@", self.venues);
        for(Venue *venue in self.venues){
            NSLog(@"Venue's name: %@", venue.name);
            NSLog(@"Location is: %@", venue.location.address);
        }
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"task: %@", task.originalRequest);
        NSLog(@"Error: %@", error);
        
    }];
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
 
    Venue *venue = self.venues[indexPath.row];
    NSLog(@"row = %d", indexPath.row);
    NSLog(@"venue %@", venue);
    cell.textLabel.text = venue.name;
    cell.detailTextLabel.text = venue.location.address;
    return cell;
    
}
@end
