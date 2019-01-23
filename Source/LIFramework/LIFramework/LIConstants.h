//
//  LIConstants.h
//  TestLK
//
//  Created by Vijay Viswas on 6/20/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#define LI_DATE_FORMAT @"yyyy-MM-dd'T'HH:mm:ssZZZ"
#define LI_CACHING_FLAG @"li_caching_flag"
#define LI_TK_KEY @"li_token_dictionary"


#define URL_Company_Check_Enabled @"https://api.linkedin.com/v1/companies/%@/is-company-share-enabled"

#define URL_Company_Check_Admin @"https://api.linkedin.com/v1/companies/%@/relation-to-viewer/is-company-share-enabled"

#define URL_Company_Profile @"https://api.linkedin.com/v1/companies/%@:(id,name,company-type,email-domains,ticker,description,website-url,industries,employee-count-range,twitter-id,specialties,locations,stock-exchange,founded-year,end-year,num-followers)"

#define URL_Company_Get_Statistics @"https://api.linkedin.com/v1/companies/%@/company-statistics"

#define URL_Company_Get_Historical_Statistics @"https://api.linkedin.com/v1/companies/%@/historical-status-update-statistics"

#define URL_Company_Get_Historical_Follower_Statistics @"https://api.linkedin.com/v1/companies/%@/historical-follow-statistics"

#define URL_Company_Updates @"https://api.linkedin.com/v1/companies/%@/updates"

#define URL_Specific_Company_Updates @"https://api.linkedin.com/v1/companies/%@/updates/key=%@"

#define URL_Comments_Specific_Company_Updates @"https://api.linkedin.com/v1/companies/%@/updates/key=%@/update-comments"

#define URL_Likes_Specific_Company_Updates @"https://api.linkedin.com/v1/companies/%@/updates/key=%@/likes"

#define URL_People_Share @"https://api.linkedin.com/v1/people/~/shares"

#define URL_Company_Share @"https://api.linkedin.com/v1/companies/%@/shares"

#define URL_Profile @"https://api.linkedin.com/v1/people/~:(id,first-name,last-name,maiden-name,email-address,headline,location,current-share,industry,num-connections,summary,specialties,positions,picture-url,public-profile-url,site-standard-profile-request)"
#define URL_Token_Invalidation  @"https://api.linkedin.com/uas/oauth/invalidateToken"
#define URL_Authorization @"https://www.linkedin.com/oauth/v2/authorization"
