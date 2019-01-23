//
//  LITokenHandler.m
//  TestLK
//
//  Created by Vijay Viswas on 6/19/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "LITokenHandler.h"
#import "LIAPIUtility.h"
#import "LIConstants.h"
#import "LISettings.h"
#import "UICKeyChainStore.h"
@interface LITokenHandler()
+(void)setLIAccessToken:(NSDictionary*)dic;
@property (nonatomic,strong) UICKeyChainStore *keyChain;
@end
@implementation LITokenHandler
+ (instancetype)sharedInstance {
    static LITokenHandler *sharedHelper = nil;
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
        if([LISettings sharedInstance].application.storeTokenInKeyChain && ![LIAPIUtility isBlank:[LISettings sharedInstance].application.keychainIdentifier])
        {
            self.keyChain=[UICKeyChainStore keyChainStoreWithService:[LISettings sharedInstance].application.keychainIdentifier];
        }
        else
        {
            [LISettings sharedInstance].application.storeTokenInKeyChain=false;
        }
    }
    return self;
}
+(void)setLIAccessToken:(NSDictionary*)dic
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:LI_CACHING_FLAG])
    {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:LI_DATE_FORMAT];
        NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
        //dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            if(![LITokenHandler sharedInstance].keyChain)
            {
                LILOG(@"Keychain is nil. Ensure to set keychain identifier");
                return;
            }
        
            NSError *error;
            [[LITokenHandler sharedInstance].keyChain setData:[[dic objectForKey:LI_ACCESS_TK] dataUsingEncoding:NSUTF8StringEncoding] forKey:LI_ACCESS_TK error:&error];
            if (error) {
                LILOG(@"%@", error.localizedDescription);
            }
            NSString * expire = [[dic objectForKey:LI_TK_EXPIRES_IN] stringValue];
            [[LITokenHandler sharedInstance].keyChain setData:[expire dataUsingEncoding:NSUTF8StringEncoding] forKey:LI_TK_EXPIRES_IN error:&error];
            if (error) {
                LILOG(@"%@", error.localizedDescription);
            }
            [[LITokenHandler sharedInstance].keyChain setData:[dateString dataUsingEncoding:NSUTF8StringEncoding] forKey:LI_TK_GENERATED_TIME error:&error];
            if (error) {
                LILOG(@"%@", error.localizedDescription);
            }
       // });
        
        
    }
    else{
        NSMutableDictionary *dd=[[NSMutableDictionary alloc] initWithDictionary:dic];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:LI_DATE_FORMAT];
        NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
        [dd setObject:dateString forKey:LI_TK_GENERATED_TIME];
        [[NSUserDefaults standardUserDefaults] setObject:dd forKey:LI_TK_KEY];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}
+(NSDictionary*)getLIAccessTokenDictionary
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:LI_CACHING_FLAG])
    {
        if(![LITokenHandler sharedInstance].keyChain)
        {
            LILOG(@"Keychain is nil. Ensure to set keychain identifier");
            return nil;
        }
        NSData *val1 =[[LITokenHandler sharedInstance].keyChain dataForKey:LI_ACCESS_TK];
        NSData *val2 =[[LITokenHandler sharedInstance].keyChain dataForKey:LI_TK_EXPIRES_IN];
        NSData *val3 =[[LITokenHandler sharedInstance].keyChain dataForKey:LI_TK_GENERATED_TIME];
        
        NSString * accessvalue=nil;
        NSString * expiresvalue=nil;
        NSString * genvalue=nil;
        if (val1){
            accessvalue = [NSString stringWithUTF8String:[val1 bytes]];
        }
        if (val2){
            expiresvalue = [NSString stringWithUTF8String:[val2 bytes]];
        }
        if (val3){
            genvalue = [NSString stringWithUTF8String:[val3 bytes]];
        }
        if(accessvalue && expiresvalue && genvalue)
        {
           
            return [[NSDictionary alloc]initWithObjectsAndKeys:accessvalue,LI_ACCESS_TK,expiresvalue,LI_TK_EXPIRES_IN,genvalue,LI_TK_GENERATED_TIME, nil];
        }
        else{
            LILOG(@"Values are not present in keychain.");
            return nil;
        }
    }
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:LI_TK_KEY];
}
+(NSString*)getLIAccessToken
{
    NSDictionary *token_dic=[LITokenHandler getLIAccessTokenDictionary];
    if(token_dic)
    {
        return [token_dic objectForKey:LI_ACCESS_TK];
    }
    return nil;
}

+(BOOL)isValidToken
{
    if(![[LISettings sharedInstance] isValidKey])
    {
        return false;
    }
    NSDictionary *dic=[LITokenHandler getLIAccessTokenDictionary];
    if(dic)
    {
        NSString *tk=[dic objectForKey:LI_ACCESS_TK];
        if(![LIAPIUtility isBlank:tk])
        {
            NSNumber *num =[dic objectForKey:LI_TK_EXPIRES_IN];
            if(num)
            {
                NSString *convertedDate = [dic objectForKey:LI_TK_GENERATED_TIME];
                if(convertedDate)
                {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:LI_DATE_FORMAT];
                    
                    NSDate *dateFromString = [dateFormatter dateFromString:convertedDate];
                    NSDate *todayDate = [NSDate date];
                    NSTimeInterval ti = [todayDate timeIntervalSinceDate:dateFromString];
                    
                    if (ti <= [num intValue]-300)
                    {
                        return true;
                    }
                }
            }
            
        }
        
    }
    
    return false;
}
/*!
 * Method clears app level tokens
 * @return Returns void.
 */
+(void)clearToken{
    if ([[NSUserDefaults standardUserDefaults] objectForKey:LI_TK_KEY])
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:LI_TK_KEY];
    }
        [[LITokenHandler sharedInstance].keyChain removeItemForKey:LI_ACCESS_TK];
        [[LITokenHandler sharedInstance].keyChain removeItemForKey:LI_TK_EXPIRES_IN];
        [[LITokenHandler sharedInstance].keyChain removeItemForKey:LI_TK_GENERATED_TIME];

    
    
}
@end
