//
//  LIFramework.m
//  LIFramework
//
//  Created by Vijay Viswas on 6/21/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "LIExplorer.h"
#import "LISettings.h"
#import "LIConstants.h"
#import "LIAPIUtility.h"
@implementation LIExplorer
+(BOOL)registerKey:(NSString*)Key withApplication:(LIApplication*)application staging:(BOOL)staging
{
    [LISettings sharedInstance].staging=staging;
    
    if(![[LISettings sharedInstance] validateLIApplication:application])
    {
        return false;
    }
    [LISettings sharedInstance].application=application;
    
    [[NSUserDefaults standardUserDefaults] setBool:[LISettings sharedInstance].application.storeTokenInKeyChain forKey:LI_CACHING_FLAG];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return [[LISettings sharedInstance]registerApplicationKey:Key];
}
+(NSString*)currentSDKVersion
{
    return @"6.0.0";
}
@end
