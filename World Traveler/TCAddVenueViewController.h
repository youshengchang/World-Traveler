//
//  TCAddVenueViewController.h
//  World Traveler
//
//  Created by yousheng chang on 9/20/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCAddVenueViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *venueNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (strong, nonatomic) IBOutlet UITextField *typeOfFoodTextField;

- (IBAction)saveButtonPressed:(UIButton *)sender;

- (IBAction)menuBarButtonItemPressed:(UIBarButtonItem *)sender;


@end
