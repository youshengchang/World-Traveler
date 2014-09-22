//
//  TCFavorsVenuesViewController.h
//  World Traveler
//
//  Created by yousheng chang on 9/20/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCFavorsVenuesViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;

@end
