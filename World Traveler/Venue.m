//
//  Venue.m
//  World Traveler
//
//  Created by yousheng chang on 9/21/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "Venue.h"
#import "Contact.h"
#import "FSCategory.h"
#import "Location.h"
#import "Menu.h"


@implementation Venue

@dynamic id;
@dynamic name;
@dynamic favorite;
@dynamic category;
@dynamic contact;
@dynamic location;
@dynamic menu;

+(NSString *)keyPathForResponseObject
{
    return @"response.venues";
    
}
@end
