//
//  LIRestAPIHandlers.m
//  TestLK
//
//  Created by Vijay Viswas on 6/19/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "LIRestAPIHandlers.h"
#import "LIAPIUtility.h"
#import "LITokenHandler.h"
#import "LIServiceClient.h"
#import "LIConstants.h"
#import "LISettings.h"
@implementation LIRestAPIHandlers

+(BOOL)shareComment:(NSString*)comment
       withVisibity:(LICommentVisibilityMode)mode
withCompletionBlock:(LIAPICompletionBlock)completionBlock
            failure:(LIAPIErrorBlock)failureBlock
{
    
    
    NSDictionary *dict=@{
                         @"comment":comment,
                         @"visibility": @{
                                 @"code": [LIRestAPIHandlers getStringForConnectionType:mode]
                                 }
                         };
    
    NSURLRequest *serviceRequest=[LIRestAPIHandlers requestWithPOSTTypeWithURL:URL_People_Share withDictionary:dict];
    if(!serviceRequest)
    {
        return false;
    }
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    
    
    return true;
    
}

+(BOOL)shareComment:(NSString*)comment withTitle:(NSString*)title
    withDescription:(NSString*)description
   withSubmittedUrl:(NSString*)url
       withImageURL:(NSString*)imgUrl
       withVisibity:(LICommentVisibilityMode)mode
withCompletionBlock:(LIAPICompletionBlock)completionBlock
            failure:(LIAPIErrorBlock)failureBlock
{
    
    
    NSDictionary *dict=@{
                         @"comment": comment,
                         @"content": @{
                                 @"title": title,
                                 @"description": description,
                                 @"submitted-url": url,
                                 @"submitted-image-url": imgUrl
                                 },
                         @"visibility": @{
                                 @"code": [LIRestAPIHandlers getStringForConnectionType:mode]
                                 }
                         };
    
    
    
    NSURLRequest *serviceRequest=[LIRestAPIHandlers requestWithPOSTTypeWithURL:URL_People_Share withDictionary:dict];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    
    return true;
}
+(BOOL)shareComment:(NSString*)comment
       forCompanyID:(NSString*)companyID
       withVisibity:(LICommentVisibilityMode)mode
withCompletionBlock:(LIAPICompletionBlock)completionBlock
            failure:(LIAPIErrorBlock)failureBlock
{
    
    NSDictionary *dict=@{
                         @"comment":comment,
                         @"visibility": @{
                                 @"code": [LIRestAPIHandlers getStringForConnectionType:mode]
                                 }
                         };
    
    NSURLRequest *serviceRequest=[LIRestAPIHandlers requestWithPOSTTypeWithURL:[NSString stringWithFormat:URL_Company_Share,companyID] withDictionary:dict];
    if(!serviceRequest)
    {
        return false;
    }
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    
    
    return true;
}

+(BOOL)shareComment:(NSString*)comment
       forCompanyID:(NSString*)companyID
          withTitle:(NSString*)title
    withDescription:(NSString*)description
   withSubmittedUrl:(NSString*)url
       withImageURL:(NSString*)imgUrl
       withVisibity:(LICommentVisibilityMode)mode
withCompletionBlock:(LIAPICompletionBlock)completionBlock
            failure:(LIAPIErrorBlock)failureBlock;
{
    
    NSDictionary *dict=@{
                         @"comment": comment,
                         @"content": @{
                                 @"title": title,
                                 @"description": description,
                                 @"submitted-url": url,
                                 @"submitted-image-url": imgUrl
                                 },
                         @"visibility": @{
                                 @"code": [LIRestAPIHandlers getStringForConnectionType:mode]
                                 }
                         };
    
    NSURLRequest *serviceRequest=[LIRestAPIHandlers requestWithPOSTTypeWithURL:[NSString stringWithFormat:URL_Company_Share,companyID] withDictionary:dict];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    return true;
}
+(BOOL)requestProfile:(LIAPICompletionBlock)completionBlock failure:(LIAPIErrorBlock)failureBlock
{
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeWithURL:URL_Profile ];
    if(!serviceRequest)
    {
        return false;
    }
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    
    return true;
}
+(BOOL)checkSharingEnabledForCompanyID:(NSString *)companyID
                   withCompletionBlock:(LIAPICompletionBlock)completionBlock
                               failure:(LIAPIErrorBlock)failureBlock
{
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeWithURL:[NSString stringWithFormat:URL_Company_Check_Enabled,companyID] ];
    if(!serviceRequest)
    {
        return false;
    }
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    return true;
    
}
+(BOOL)checkMemberIsAdminForCompanyID:(NSString *)companyID
                   withCompletionBlock:(LIAPICompletionBlock)completionBlock
                               failure:(LIAPIErrorBlock)failureBlock
{
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeWithURL:[NSString stringWithFormat:URL_Company_Check_Admin,companyID] ];
    if(!serviceRequest)
    {
        return false;
    }
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    return true;
    
}
+(BOOL)companyProfileForCompanyID:(NSString *)companyID
              withCompletionBlock:(LIAPICompletionBlock)completionBlock
                          failure:(LIAPIErrorBlock)failureBlock
{
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeWithURL:[NSString stringWithFormat:URL_Company_Profile,companyID] ];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    
    return true;
    
}
+(BOOL)getStatisticsForCompanyID:(NSString *)companyID
             withCompletionBlock:(LIAPICompletionBlock)completionBlock
                         failure:(LIAPIErrorBlock)failureBlock;
{
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeWithURL:[NSString stringWithFormat:URL_Company_Get_Statistics,companyID] ];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    return true;
}
+(BOOL)getHistoricalStatisticsForCompanyID:(NSString *)companyID
                       withTimeGranularity:(LIGranularity)granularity
                             withTimestamp:(NSString*)time
                       withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                   failure:(LIAPIErrorBlock)failureBlock
{
    NSString *format=@"day";
    if(granularity==LIGranularityMonth)
    {
        format=@"month";
    }
    NSMutableURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeStaticsWithURL:[NSString stringWithFormat:URL_Company_Get_Historical_Statistics,companyID] withGranularity:format withTime:time];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    return true;
}
+(BOOL)getHistoricalFollowerStatisticsForCompanyID:(NSString *)companyID
                               withTimeGranularity:(LIGranularity)granularity
                                     withTimestamp:(NSString*)time
                               withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                           failure:(LIAPIErrorBlock)failureBlock
{
    NSString *format=@"day";
    if(granularity==LIGranularityMonth)
    {
        format=@"month";
    }
    
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeStaticsWithURL:[NSString stringWithFormat:URL_Company_Get_Historical_Follower_Statistics,companyID] withGranularity:format withTime:time];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    
    return true;
}
+(BOOL)getCompanyUpdatesForCompanyID:(NSString *)companyID
                 withCompletionBlock:(LIAPICompletionBlock)completionBlock
                             failure:(LIAPIErrorBlock)failureBlock
{
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeWithURL:[NSString stringWithFormat:URL_Company_Updates,companyID] ];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    return true;
}
+(BOOL)getSpecificCompanyUpdatesForCompanyID:(NSString *)companyID
                                andUpdateKEy:(NSString*)updateKey
                         withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                     failure:(LIAPIErrorBlock)failureBlock
{
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeWithURL:[NSString stringWithFormat:URL_Specific_Company_Updates,companyID,updateKey] ];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    
    return true;
}
+(BOOL)getCommentsOfSpecificCompanyUpdatesForCompanyID:(NSString *)companyID
                                          andUpdateKEy:(NSString*)updateKey
                                   withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                               failure:(LIAPIErrorBlock)failureBlock
{
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeWithURL:[NSString stringWithFormat:URL_Comments_Specific_Company_Updates,companyID,updateKey] ];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    
    return true;
}

+(BOOL)getLikesOfSpecificCompanyUpdatesForCompanyID:(NSString *)companyID
                                       andUpdateKEy:(NSString*)updateKey
                                withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                            failure:(LIAPIErrorBlock)failureBlock
{
    NSURLRequest *serviceRequest= [LIRestAPIHandlers requestWithGETTypeWithURL:[NSString stringWithFormat:URL_Likes_Specific_Company_Updates,companyID,updateKey] ];
    if(!serviceRequest)
    {
        return false;
    }
    
    [LIRestAPIHandlers callServiceWithRequest:serviceRequest withCompletionBlock:completionBlock failure:failureBlock];
    
    return true;
}
+(NSMutableURLRequest*)requestWithGETTypeWithURL:(NSString*)url
{
    if(![[LISettings sharedInstance] isValidKey])
    {
        return nil;
    }
    
    NSString *access_token=[LITokenHandler getLIAccessToken];
    if(!access_token)
    {
        return nil;
    }
    
    NSString *strURL=[NSString stringWithFormat:@"%@?format=json&oauth2_access_token=%@",url,access_token];
    NSURL *nurl = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *serviceRequest = [NSMutableURLRequest requestWithURL:nurl];
    [serviceRequest addValue: @"application/json" forHTTPHeaderField: @"Content-Type"];

    
    [serviceRequest setHTTPMethod:@"GET"];
    return serviceRequest;
}
+(NSMutableURLRequest*)requestWithGETTypeStaticsWithURL:(NSString*)url withGranularity:(NSString*)granularity withTime:(NSString*)time
{
    if(![[LISettings sharedInstance] isValidKey])
    {
        return nil;
    }
    NSString *access_token=[LITokenHandler getLIAccessToken];
    if(!access_token)
    {
        return nil;
    }
    NSString *strURL=[NSString stringWithFormat:@"%@?format=json&oauth2_access_token=%@&time-granularity=%@&start-timestamp=%@",url,access_token,granularity,time];
    NSURL *nurl = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *serviceRequest = [NSMutableURLRequest requestWithURL:nurl];
    [serviceRequest addValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
    
    [serviceRequest setHTTPMethod:@"GET"];
    return serviceRequest;
}
+(NSMutableURLRequest*)requestWithPOSTTypeWithURL:(NSString*)url withDictionary:(NSDictionary*)requestDictionary
{
    if(![[LISettings sharedInstance] isValidKey])
    {
        return nil;
    }
    NSString *access_token=[LITokenHandler getLIAccessToken];
    if(!access_token)
    {
        return nil;
    }
    NSString *strURL=[NSString stringWithFormat:@"%@?format=json&oauth2_access_token=%@",url,access_token];
    NSURL *nurl = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *serviceRequest = [NSMutableURLRequest requestWithURL:nurl];
    [serviceRequest addValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
    [serviceRequest addValue: @"json" forHTTPHeaderField: @"x-li-format"];
    
    [serviceRequest setHTTPMethod:@"POST"];
    
    NSError*error;
    //convert object to data
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:requestDictionary options:kNilOptions error:&error];
    [serviceRequest setHTTPBody:jsonData];
    return serviceRequest;
}

+(void)callServiceWithRequest:(NSURLRequest*)request withCompletionBlock:(LIAPICompletionBlock)completionBlock
                      failure:(LIAPIErrorBlock)failureBlock
{
    [LIServiceClient callServiceURL:request success:^(NSData *data, NSURLResponse *response) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        long status=(long)[httpResponse statusCode];
        if(status==200 || status==201)
        {
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if(!json)
            {
                NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                json=[[NSDictionary alloc]initWithObjectsAndKeys:newStr,@"response", nil];
            }
            if (completionBlock) {
                completionBlock(json,response);
            }
        }
        else{
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if(!json)
            {
                NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                json=[[NSDictionary alloc]initWithObjectsAndKeys:newStr,@"response", nil];
            }
            NSError *error = [[NSError alloc] initWithDomain:@"LinkedIn Rest API error." code:60005 userInfo:json];
            if(failureBlock)
            {
                failureBlock(error);
            }
        }
    } failure:^(NSError *error) {
        if(failureBlock)
        {
            failureBlock(error);
        }
    }];
}

+(NSString*)getStringForConnectionType:(LICommentVisibilityMode)mode
{
    
    NSString *connectionType=LI_VISIBILITY_CONNECTIONS_ONLY;
    
    if(mode==LICommentVisibilityAnyone)
    {
        connectionType=LI_VISIBILITY_ANYONE;
    }
    return connectionType;
}


@end
