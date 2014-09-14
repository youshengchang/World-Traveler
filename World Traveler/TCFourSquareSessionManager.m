//
//  TCFourSquareSessionManager.m
//  World Traveler
//
//  Created by yousheng chang on 9/13/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "TCFourSquareSessionManager.h"

static NSString *const TCFoursquareBaseURLString = @"https://api.foursquare.com/v2/";

@implementation TCFourSquareSessionManager

+(instancetype)sharedClient
{
    static TCFourSquareSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[TCFourSquareSessionManager alloc]initWithBaseURL:[NSURL URLWithString:TCFoursquareBaseURLString]];
        
    });
    return _sharedClient;
}

@end
