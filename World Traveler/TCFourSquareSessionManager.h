//
//  TCFourSquareSessionManager.h
//  World Traveler
//
//  Created by yousheng chang on 9/13/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface TCFourSquareSessionManager : AFHTTPSessionManager

+(instancetype)sharedClient;

@end
