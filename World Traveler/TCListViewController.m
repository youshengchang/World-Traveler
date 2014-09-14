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

static NSString *const kCLIENTID = @"DFJ5UOHLCB0BBOEZDC244F3TXZLOEGLZY5O11A2DSLVFUFY4";
static NSString *const kCLIENTSECRET = @"XGSHJLLF4YNK14CXIUF1PQRMZVXX2BAMAK3LQCTDISMRAYJE";


@interface TCListViewController ()

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
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshBarButtonItemPressed:(UIBarButtonItem *)sender {
    
    NSLog(@"refreshBarButtonItemPressed!");
    
    [[TCFourSquareSessionManager sharedClient]GET:@"venues/search?ll=30.25,-97.75" parameters:@{@"client_id":kCLIENTID, @"client_secret": kCLIENTSECRET, @"v": @"20140416"} success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@" Success: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"task: %@", task.originalRequest);
        NSLog(@"Error: %@", error);
        
    }];
}

@end
