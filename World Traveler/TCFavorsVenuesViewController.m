//
//  TCFavorsVenuesViewController.m
//  World Traveler
//
//  Created by yousheng chang on 9/20/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "TCFavorsVenuesViewController.h"
#import "TCAppDelegate.h"
#import "Venue.h"


@interface TCFavorsVenuesViewController ()

@property (strong, nonatomic)NSMutableArray *favorites;


@end

@implementation TCFavorsVenuesViewController

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    if(!self.favorites){
        self.favorites = [[NSMutableArray alloc]init];
        
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    NSPredicate *predicateForFavorite = [NSPredicate predicateWithFormat:@"favorite == %@", [NSNumber numberWithBool:YES]];
    self.favorites = [[Venue MR_findAllWithPredicate:predicateForFavorite]mutableCopy];
    [self.tableView reloadData];
    
    
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

#pragma mark - IBActions
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender {
    [[self drawerControllerFromAppDelegate]toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    
}

#pragma mark - UITableView DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.favorites count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Venue *venue = self.favorites[indexPath.row];
    cell.textLabel.text = venue.name;
    return cell;
}

#pragma mark - DrawController Helper

-(MMDrawerController *)drawerControllerFromAppDelegate
{
    TCAppDelegate *appDelegate = (TCAppDelegate *)[[UIApplication sharedApplication]delegate];
    return  appDelegate.drawerController;
    
}
@end
