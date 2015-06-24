//
//  LIRestAPIHandlers.h
//  TestLK
//
//  Created by Vijay Viswas on 6/19/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

typedef enum
{
    LICommentVisibilityAnyone,
    LICommentVisibilityConnectionsOnly
} LICommentVisibilityMode;
typedef enum
{
    LIGranularityDay,
    LIGranularityMonth
} LIGranularity;
/*!
 * @typedef  LIAPICompletionBlock
 * @brief    Block is called when API service is called successfully.
 * @property dic The dictionary object contains service response data.
 * @property error The NSURLResponse object.
 */
typedef void (^LIAPICompletionBlock) (NSDictionary *dic, NSURLResponse *response);
/*
 Error code 60001: User denied access.
 Error code 60002: Internal Error.
 Error code 60003: Invalid redirection.
 Error code 60004: Form validation error.
 Error code 60005: LinkedIn Rest API error.
 * @typedef  LIAPIErrorBlock
 * @brief    Block is called when an error ocurred in API service call.
 * @property error The NSError object related to the failure.
 */
typedef void (^LIAPIErrorBlock) (NSError *error);
/*!
 @details LIRestAPIHandlers provides method to call various LinkedIn APIs.
 @author Vijay Viswas
 */
@interface LIRestAPIHandlers : NSObject
/*!
 * Method is used to share member comment in LinkedIn.
 * @param comment A comment by the member to associated with the share.
 * @param mode A collection of visibility information about the share.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)shareComment:(NSString*)comment
       withVisibity:(LICommentVisibilityMode)mode
withCompletionBlock:(LIAPICompletionBlock)completionBlock
            failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method is used to share content in LinkedIn.
 * @param comment A comment by the member to associated with the share.
 * @param title The title of the content being shared.
 * @param description The description of the content being shared.
 * @param url A fully qualified URL for the content being shared.
 * @param imgUrl A fully qualified URL to a thumbnail image to accompany the shared content.
 * @param mode A collection of visibility information about the share.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */

+(BOOL)shareComment:(NSString*)comment
          withTitle:(NSString*)title
    withDescription:(NSString*)description
   withSubmittedUrl:(NSString*)url
       withImageURL:(NSString*)imgUrl
       withVisibity:(LICommentVisibilityMode)mode
withCompletionBlock:(LIAPICompletionBlock)completionBlock
            failure:(LIAPIErrorBlock)failureBlock;

/*!
 * Method is used to create company share.
 * @param comment A comment by the member to associated with the share.
 * @param companyID Company identifier.
 * @param mode A collection of visibility information about the share.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)shareComment:(NSString*)comment
       forCompanyID:(NSString*)companyID
       withVisibity:(LICommentVisibilityMode)mode
withCompletionBlock:(LIAPICompletionBlock)completionBlock
            failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method is used to create company share.
 * @param comment A comment by the member to associated with the share.
 * @param companyID Company identifier.
 * @param title The title of the content being shared.
 * @param description The description of the content being shared.
 * @param url A fully qualified URL for the content being shared.
 * @param imgUrl A fully qualified URL to a thumbnail image to accompany the shared content.
 * @param mode A collection of visibility information about the share.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)shareComment:(NSString*)comment
       forCompanyID:(NSString*)companyID
          withTitle:(NSString*)title
    withDescription:(NSString*)description
   withSubmittedUrl:(NSString*)url
       withImageURL:(NSString*)imgUrl
       withVisibity:(LICommentVisibilityMode)mode
withCompletionBlock:(LIAPICompletionBlock)completionBlock
            failure:(LIAPIErrorBlock)failureBlock;

/*!
 * Method returns authenticated user profile information.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)requestProfile:(LIAPICompletionBlock)completionBlock failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method Check if sharing is enabled for a company
 * @param companyID Company identifier.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)checkSharingEnabledForCompanyID:(NSString *)companyID
                   withCompletionBlock:(LIAPICompletionBlock)completionBlock
                               failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method retruns company profile.
 * @param companyID Company identifier.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)companyProfileForCompanyID:(NSString *)companyID
              withCompletionBlock:(LIAPICompletionBlock)completionBlock
                          failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method retruns statistics for a company page.
 * @param companyID Company identifier.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)getStatisticsForCompanyID:(NSString *)companyID
             withCompletionBlock:(LIAPICompletionBlock)completionBlock
                         failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method retruns historical status update statistics about a company.
 * @param companyID Company identifier.
 * @param LIGranularity Granularity of statistics. Supported values are:day & month
 * @param time Starting timestamp of when the stats search should begin (milliseconds since epoch).
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)getHistoricalStatisticsForCompanyID:(NSString *)companyID
                       withTimeGranularity:(LIGranularity)granularity
                             withTimestamp:(NSString*)time
                       withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                   failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method returns historical follower statistics about a company.
 * @param companyID Company identifier.
 * @param LIGranularity Granularity of statistics. Supported values are:day & month
 * @param time Starting timestamp of when the stats search should begin (milliseconds since epoch).
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)getHistoricalFollowerStatisticsForCompanyID:(NSString *)companyID
                               withTimeGranularity:(LIGranularity)granularity
                                     withTimestamp:(NSString*)time
                               withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                           failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method retruns company's updates.
 * @param companyID Company identifier.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)getCompanyUpdatesForCompanyID:(NSString *)companyID
                 withCompletionBlock:(LIAPICompletionBlock)completionBlock
                             failure:(LIAPIErrorBlock)failureBlock;
/*! Method returns a single specific company update record for the company identified by the {id} value and the update identified by the {update-key} value in the request.
 * @param companyID Company identifier.
 * @param updateKey Unique identifier for the event, similar to an id.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)getSpecificCompanyUpdatesForCompanyID:(NSString *)companyID
                                andUpdateKEy:(NSString*)updateKey
                         withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                     failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method returns comments for a specific company update.
 * @param companyID Company identifier.
 * @param updateKey Unique identifier for the event, similar to an id.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)getCommentsOfSpecificCompanyUpdatesForCompanyID:(NSString *)companyID
                                          andUpdateKEy:(NSString*)updateKey
                                   withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                               failure:(LIAPIErrorBlock)failureBlock;
/*!
 * Method returns likes for a specific company update.
 * @param companyID Company identifier.
 * @param updateKey Unique identifier for the event, similar to an id.
 * @param success A completion block.
 * @param failure A failure block.
 * @return Returns true if service is called successfully else returns false when there is an invalid access token or framework key.
 */
+(BOOL)getLikesOfSpecificCompanyUpdatesForCompanyID:(NSString *)companyID
                                       andUpdateKEy:(NSString*)updateKey
                                withCompletionBlock:(LIAPICompletionBlock)completionBlock
                                            failure:(LIAPIErrorBlock)failureBlock;
@end
