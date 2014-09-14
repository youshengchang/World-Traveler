//
//  FSCategory.h
//  World Traveler
//
//  Created by yousheng chang on 9/13/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TCRecord.h"

@class Venue;

@interface FSCategory : TCRecord

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Venue *venue;

@end
