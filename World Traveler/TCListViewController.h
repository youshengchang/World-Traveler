//
//  TCViewController.h
//  World Traveler
//
//  Created by yousheng chang on 9/12/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)refreshBarButtonPressed:(UIBarButtonItem *)sender;

- (IBAction)manuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
