//
//  Venue.m
//  World Traveler
//
//  Created by yousheng chang on 9/13/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "Venue.h"
#import "Menu.h"


@implementation Venue

@dynamic name;
@dynamic id;
@dynamic category;
@dynamic contact;
@dynamic location;
@dynamic menu;

+(NSString *)keyPathForResponseObject
{
    return @"response.venues";
}

@end
