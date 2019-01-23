//
//  LIAuthorizationVC.m
//  TestLK
//
//  Created by Vijay Viswas on 6/18/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "LIAuthorizationVC.h"
#import "LIApplication.h"
#import "LIServiceClient.h"
#import "LITokenHandler+Extension.h"
#import "LISettings.h"
#import "LIConstants.h"
#import "LIAPIUtility.h"
@interface LIAuthorizationVC ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *liWebView;
@property (nonatomic,assign) BOOL webviewLoaded;
-(BOOL)checkScopeAndState:(NSURL*)urlString;
@end

@implementation LIAuthorizationVC

- (id)initWithSuccessBlock:(LICompletionBlock)success failureBlock:(LIErrorBlock)failure
{
    self = [super init];
    if (self) {
        self.successCallback=success;
        self.failureCallback=failure;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    self.liWebView=[[UIWebView alloc]init];
    self.liWebView.delegate=self;
    [self.view addSubview:self.liWebView];
    if([LISettings sharedInstance].application)
    {
        
        if (![LISettings sharedInstance].application.hideDefaultWebView) {
            if(self.webViewNavigationNar)
            {
                [self.view addSubview:self.webViewNavigationNar];
                self.liWebView.frame=CGRectMake(0, self.webViewNavigationNar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-self.webViewNavigationNar.frame.size.height);
            }
            else
            {
                self.liWebView.frame=self.view.frame;
            }
        }
        else
        {
            self.liWebView.frame=CGRectMake(0, 0, 0, 0);
        }
        NSString *strURL=[NSString stringWithFormat:@"%@?response_type=code&client_id=%@&redirect_uri=%@&state=%@",URL_Authorization,[LISettings sharedInstance].application.clientId,[LISettings sharedInstance].application.redirectURL,[LISettings sharedInstance].application.state];
        NSURL *nurl = [NSURL URLWithString:strURL];
        
        
        NSMutableURLRequest *serviceRequest = [NSMutableURLRequest requestWithURL:nurl];
        [serviceRequest addValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
        
        [serviceRequest setHTTPMethod:@"GET"];
        [self.liWebView loadRequest:serviceRequest];
    }
    else
    {
        NSError *error = [[NSError alloc] initWithDomain:@"Invalid LIApplication object" code:60021 userInfo:[[NSMutableDictionary alloc] init]];
        if (self.failureCallback) {
            self.failureCallback(error);
        }
    }
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)authenticateWithUsername:(NSString*)username andPassword:(NSString*)password
{
    if(!self.webviewLoaded)
    {
        LILOG(@"Webview not loaded.");
        return;
    }
    if([self.liWebView.request.URL.absoluteString  rangeOfString:URL_Authorization].location != NSNotFound && [LISettings sharedInstance].application && [LISettings sharedInstance].application.hideDefaultWebView )
    {
        NSString *loadPasswordJS =
        [NSString stringWithFormat:@"var passFields = document.querySelectorAll(\"input[type='password']\"); \
         for (var i = passFields.length>>> 0; i--;) { passFields[i].value ='%@';}", password];
        [self.liWebView stringByEvaluatingJavaScriptFromString: loadPasswordJS];
        
        NSString *loadText =
        [NSString stringWithFormat:@"var inputFields = document.querySelectorAll(\"input[type='text']\"); \
         for (var i = inputFields.length >>> 0; i--;) { inputFields[i].value = '%@';}",username];
        [self.liWebView stringByEvaluatingJavaScriptFromString: loadText];
        
        NSString *performSubmitJS = @"var passFields = document.querySelectorAll(\"input[type='submit']\"); \
        passFields[0].click()";
        [self.liWebView stringByEvaluatingJavaScriptFromString:performSubmitJS];
    }
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    if(![[LISettings sharedInstance] isValidKey])
    {
        return false;
    }
    
    LILOG(@"%@",request.URL.absoluteString);
    if([request.URL.absoluteString  hasPrefix:[LISettings sharedInstance].application.redirectURL])
    {
        return [self checkScopeAndState:request.URL];
    }
    else if([request.URL.absoluteString  hasPrefix:URL_Authorization]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/uas/login"]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/uas/login-submit"]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/checkpoint/lg/login-submit"]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/oauth/v2/login-success"]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/uas/oauth2/authorizedialog/submit"]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/oauth/v2/authorization-submit"]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/uas/connect-email-challenge"]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/uas/ato-pin-challenge-submit"]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/uas/connect-captcha"]
            || [request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/uas/captcha-submit"])
    {
        return true;
    }
    NSError *error = [[NSError alloc] initWithDomain:@"User navigated to other links" code:60003 userInfo:[[NSMutableDictionary alloc] initWithObjectsAndKeys:request.URL.absoluteString,@"Url", nil]];
    if (self.failureCallback) {
        self.failureCallback(error);
    }

    return false;
}
- (void)webViewDidFinishLoad:(UIWebView *)webView;
{
    self.webviewLoaded=true;
    if([LISettings sharedInstance].application.hideDefaultWebView && webView.request && [webView.request.URL.absoluteString  hasPrefix:@"https://www.linkedin.com/uas/oauth2/authorizedialog/submit"])
    {
        NSString *html = [webView stringByEvaluatingJavaScriptFromString:
                          @"document.body.innerHTML"];
        if([html rangeOfString:@"Please correct"].location != NSNotFound)
        {
            NSError *error = [[NSError alloc] initWithDomain:@"Form validation error" code:60004 userInfo:[[NSMutableDictionary alloc] init]];
            if (self.failureCallback) {
                self.failureCallback(error);
            }
        }
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    if([webView.request.URL.absoluteString  hasPrefix:[LISettings sharedInstance].application.redirectURL])
    {
        if (self.failureCallback) {
            self.failureCallback(error);
        }
    }
}
-(BOOL)checkScopeAndState:(NSURL*)urlString
{
    
    
    NSString *query = [urlString query];
    
    if ([urlString.absoluteString rangeOfString:@"error"].location != NSNotFound) {
        BOOL accessDenied = [urlString.absoluteString rangeOfString:@"the+user+denied+your+request"].location != NSNotFound;
        if (accessDenied) {
            NSError *error = [[NSError alloc] initWithDomain:@"User denied access" code:60001 userInfo:[[NSMutableDictionary alloc] init]];
            self.failureCallback(error);
        } else {
            NSError *error = [[NSError alloc] initWithDomain:@"Internal Error" code:60002 userInfo:[[NSMutableDictionary alloc] init]];
            if (self.failureCallback) {
                self.failureCallback(error);
            }
        }
    }
    
    if (query && ([query rangeOfString:@"code="].location != NSNotFound)) {
        NSArray *queryComponents = [query componentsSeparatedByString:@"&"];
        NSArray *firstParam = [[queryComponents objectAtIndex:0] componentsSeparatedByString:@"="];
        if(![[LISettings sharedInstance] isValidKey])
        {
            return false;
        }
        
        
        NSString *strURL=[NSString stringWithFormat:@"https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code&code=%@&redirect_uri=%@&client_id=%@&client_secret=%@",[firstParam objectAtIndex:1],[LISettings sharedInstance].application.redirectURL,[LISettings sharedInstance].application.clientId,[LISettings sharedInstance].application.clientSecret];
        
        
        NSURL *url = [NSURL URLWithString:strURL];
        NSMutableURLRequest *serviceRequest = [NSMutableURLRequest requestWithURL:url];
        [serviceRequest addValue: @"application/x-www-form-urlencoded" forHTTPHeaderField: @"Content-Type"];
        
        [serviceRequest setHTTPMethod:@"POST"];
        
        [LIServiceClient callServiceURL:serviceRequest success:^(NSData *data, NSURLResponse *response) {
            
            if(data)
            {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if(json && [json objectForKey:LI_ACCESS_TK])
                {
                    [LITokenHandler setLIAccessToken:json];
                }
            }
            if(self.successCallback)
            {
                self.successCallback();
            }
        } failure:^(NSError *error) {
            
            if (self.failureCallback) {
                self.failureCallback(error);
            }
        }];
        return false;
    }
    
    
    
    return true;
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
