//
//  LISettings.m
//  TestLK
//
//  Created by Vijay Viswas on 6/20/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "LISettings.h"
#import "LIAPIUtility.h"
@interface LISettings()

@property (nonatomic,strong) NSString *frameworkKey;
@property (nonatomic,strong) NSDictionary *appInfo;
@end


@implementation LISettings
+ (instancetype)sharedInstance {
    static LISettings *sharedHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHelper =[[self alloc] init];
    });
    
    return sharedHelper;
}
-(instancetype)init
{
    self=[super init];
    if(self)
    {
        self.appInfo=[[NSDictionary alloc]init];
    }
    return self;
}
-(BOOL)registerApplicationKey:(NSString*)applicationKey
{
    if([LIAPIUtility isBlank:applicationKey])
    {
        LILOG(@"Empty framework key");
        return false;
    }
    [LISettings sharedInstance].frameworkKey=applicationKey;
    
    
    return true;
}
-(BOOL)validateLIApplication:(LIApplication*)application
{
    if(application==nil)
    {
        LILOG(@"Invalid LIApplication object.");
        return false;
    }
    if(application.storeTokenInKeyChain && [LIAPIUtility isBlank:application.keychainIdentifier])
    {
        LILOG(@"storeTokenInKeyChain property value is true but key chain identifier is nil.");
    }
    if(![LIAPIUtility isBlank:application.clientId] && ![LIAPIUtility isBlank:application.clientSecret] && ![LIAPIUtility isBlank:application.state] && ![LIAPIUtility isBlank:application.redirectURL])
    {
        return true;
    }
    LILOG(@"Invalid LIApplication object. Check the required properties like cliecntId, clientSecret, state & redirectURL.");
    return false;
}
-(BOOL)isValidKey
{
    if(![[LISettings sharedInstance] validateLIApplication:[LISettings sharedInstance].application])
    {
        return false;
    }
    if([LIAPIUtility isBlank:[LISettings sharedInstance].frameworkKey])
    {
        LILOG(@"Invalid LIFramework key");
        return false;
    }
  /*
#if TARGET_IPHONE_SIMULATOR
    
    if([[LISettings sharedInstance].frameworkKey isEqualToString:@"LIE"]){
        return true;
    }
    
#else
    
   NSString *appIdentifier=[[NSBundle mainBundle] bundleIdentifier];
    NSString *key=[[LISettings sharedInstance].appInfo objectForKey:@"TTDR_Key"];
    NSString *Identifier=[[LISettings sharedInstance].appInfo objectForKey:@"TTDR_Iden"];
    
    if(![LIAPIUtility isBlank:key] && ![LIAPIUtility isBlank:Identifier] && [appIdentifier  rangeOfString:Identifier].location != NSNotFound &&[[LISettings sharedInstance].frameworkKey isEqualToString:key] ){
        return true;
    }
   
    
#endif
    */
    if([[LISettings sharedInstance].frameworkKey isEqualToString:@"LIExplorer_Public"]){
        return true;
    }
    
    LILOG(@"Invalid LIFramework key");
    return false;
}
@end
