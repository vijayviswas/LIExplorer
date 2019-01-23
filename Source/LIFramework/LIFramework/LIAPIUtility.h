//
//  LIAPIUtility.h
//  TestLK
//
//  Created by Vijay Viswas on 6/20/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LISettings.h"

#define LI_VISIBILITY_CONNECTIONS_ONLY @"connections-only"
#define LI_VISIBILITY_ANYONE @"anyone"
#define LILOG(fmt, ...) ([LISettings sharedInstance].staging ? NSLog(fmt, ##__VA_ARGS__):0 )
@interface LIAPIUtility : NSObject
+(BOOL)isBlank:(NSString *) theString;

@end
