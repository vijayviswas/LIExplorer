//
//  LIServiceClient.m
//  TestLK
//
//  Created by Vijay Viswas on 6/19/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "LIServiceClient.h"

@implementation LIServiceClient


+(void)callServiceURL:(NSURLRequest*)request success:(LIServiceSucccessBlock)successBlock failure:(LIServiceErrorBlock)failureBlock
{
    
    
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];


    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                          completionHandler:^(NSData *taskData, NSURLResponse *taskResponse, NSError *error) {
                              
                              if(error != nil && failureBlock)
                              {
                                  
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      failureBlock(error);
                                  });
                                  return;
                              }
                              else if(successBlock)
                              {
                                  
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      successBlock(taskData, taskResponse);
                                  });
                                  
                                  return;
                              }
                              
                          }];

    [dataTask resume];
}

@end
