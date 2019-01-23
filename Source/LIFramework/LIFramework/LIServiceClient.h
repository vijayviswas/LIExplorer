//
//  LIServiceClient.h
//  TestLK
//
//  Created by Vijay Viswas on 6/19/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^LIServiceSucccessBlock) (NSData *data, NSURLResponse *response);
typedef void (^LIServiceErrorBlock) (NSError *error);
@interface LIServiceClient : NSObject
+(void)callServiceURL:(NSURLRequest*)request success:(LIServiceSucccessBlock)successBlock failure:(LIServiceErrorBlock)failureBlock;
@end
