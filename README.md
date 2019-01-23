

**LIExplorer is going to shut down as Linkedin annouced all developers need to migrate their apps to our newest APIs and OAuth 2.0 by March 1, 2019. I have uploaded the source code, free to troubleshoot or modify it. Loop me in for any modification to this library

To test the libraray, you have to run TestApp target from source project
**






#LIExplorer.framework- Wow its free now.
LIExplorer.framework is a BSD-licensed Objective C library for LinkedIn integration in iOS applications. This framework doesn't have any dependency with third party libraries.




<p align="center" >
  <img src="https://github.com/vijayviswas/LIExplorer/blob/master/Images/Slide1.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIExplorer/blob/master/Images/Slide2.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>




User guide
------------
* Register and configure your application at https://www.linkedin.com/developer/apps. Make sure you setup client id, client secret ,redirect URL and provide application permissions. 
* 
* Please read  this link (https://developer.linkedin.com/docs/oauth2) before using the framework to get familiarize with authenticating linked with OAuth 2.0.
* 
* Download latest framework file from github 
[**release**] (https://github.com/vijayviswas/LIExplorer/releases).
* 
* Register your application with framework.
* 
**NOTE**:Use *"LIExplorer_Public"* key to register the framework to run it in simulator & device. Contact me incase if you have any questions.
 

 If you want to see logs from framework then pass "Yes" value to staging. 


**NOTE**: [LIExplorer registerKey: withApplication: staging:] should be called once so it is better to call this method in - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions.

```
LIApplication *app=[[LIApplication alloc] init];
    app.clientId=;
    app.clientSecret=;
    app.redirectURL=;
    app.state=;
    [LIExplorer registerKey:@"LIExplorer_Public" withApplication:app staging:YES];
  ```
There are various properties defined in LIApplication to specify login webview size, hide default login webview and also token is stored in NSUserdefaults by default. If you would like to store it in keychain then pass true to **storeTokenInKeyChain** property. Also ensure to pass keychain identifier.

* Invoke linkedin login screen

LIAuthorizationVC viewcontroller is used to autheticate to linkedIn. Check whether accesstoken is already present or not before you initialize LIAuthorizationVC because we don't need to login again if access token is already granted and is not expired. The below code opens default linkedin webview without navigation bar..
<p align="center" >
  <img src="https://github.com/vijayviswas/LIExplorer/blob/master/Images/Slide3.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>

```
 if(![LITokenHandler isValidToken])
    {
        LIAuthorizationVC *vc=[[LIAuthorizationVC alloc]initWithSuccessBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        } failureBlock:^(NSError *error) {
            NSDictionary *userInfo = [error userInfo];
            if([userInfo objectForKey:@"Url"])// This is to identify whether user has clicked on any button/links other than sign in/login button in default linkedin login page
             {
                 NSLog(@"User clicked on link :%@",[userInfo objectForKey:@"Url"]);
             }
        }];
        [self presentViewController:vc animated:YES completion:nil];
    }
  ```
If you want to have a navigation bar on the top of webview then use below code.
<p align="center" >
  <img src="https://github.com/vijayviswas/LIExplorer/blob/master/Images/Slide4.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>

```
UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    navBar.backgroundColor = [UIColor whiteColor];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    navItem.title = @"Navigation Bar title here";
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(yourMethod)];
    navItem.leftBarButtonItem = leftButton;
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStylePlain target:self action:@selector(yourOtherMethod)];
    navItem.rightBarButtonItem = rightButton;
    
    navBar.items = @[ navItem ];
    
    if(![LITokenHandler isValidToken])
    {
        LIAuthorizationVC *vc=[[LIAuthorizationVC alloc]initWithSuccessBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        } failureBlock:^(NSError *error) {
            NSDictionary *userInfo = [error userInfo];
            if([userInfo objectForKey:@"Url"])// This is to identify whether user has clicked on any button/links other than sign in/login button
             {
                 NSLog(@"User clicked on link :%@",[userInfo objectForKey:@"Url"]);
             }
        }];
        vc.webViewNavigationNar=navBar;
        [self presentViewController:vc animated:YES completion:nil];
    }
    else{
        [self loadShareVC];
    }

  ```
If you fed up with webview and you want to have a completely native screen then create a viewcontroller in xib or storyboard and dervied it from LIAuthorizationVC. See below picture.
<p align="center" >
  <img src="https://github.com/vijayviswas/LIExplorer/blob/master/Images/Slide5.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>

* REST API

Once you have authenticated to LinkedIn then you can start calling below services.
No need to check **[LITokenHandler isValidToken]**when calling services as it is handled inside the framework. All the service methods return true if framework has valid access token.

<p align="center" >
  <img src="https://github.com/vijayviswas/LIExplorer/blob/master/Images/Slide7.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIExplorer/blob/master/Images/Slide8.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIExplorer/blob/master/Images/Slide9.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>

Get user linkedIn profile.
```

        [LIRestAPIHandlers requestProfile:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
            
        } failure:^(NSError *error) {
            
        }];
  ```
Share user comments.
```

 [LIRestAPIHandlers shareComment:@"TEST API" withVisibity:LICommentVisibilityConnectionsOnly
                    withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
                        NSLog(@"%@",dic);
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                        NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
                    } failure:^(NSError *error) {
                        
                    }];
  ```
Share with specific values.

```

  [LIRestAPIHandlers shareComment:@"Test APi" withTitle:@"LinkedIn Developers Resources" withDescription:@"Leverage LinkedIn's APIs to maximize engagement" withSubmittedUrl:@"https://developer.linkedin.com" withImageURL:@"" withVisibity:LICommentVisibilityConnectionsOnly withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            
        }];
  ```
Company share.
```
[LIRestAPIHandlers shareComment:@"TEST API" forCompanyID:@"###" withVisibity:LICommentVisibilityConnectionsOnly
                    withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
                        NSLog(@"%@",dic);
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                        NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
                    } failure:^(NSError *error) {
                        
                    }];
  ```
Get company profile.
```
 [LIRestAPIHandlers companyProfileForCompanyID:@"###" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            
        }];
  ```
Get company updates.
```
  [LIRestAPIHandlers getCompanyUpdatesForCompanyID:@"##" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            
        }];
  ```
There are more APIs refer **LIRestAPIHandlers** class methods for more details.

*Storing token.

LIExplorer has the ability to store token in NSUserDefaults and Keychain. See *LIApplication* class for more details.
<p align="center" >
  <img src="https://github.com/vijayviswas/LIExplorer/blob/master/Images/Slide6.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>

By default LIExplorer stores access token in NSUserDefaults. If you would like to store it in keychain then set LIApplication class property **storeTokenInKeyChain** value as true and also set **keychainIdentifier** while registering the framework in applicationdidfinishLaunch method in Appdelegate.

Sample code
```
  LIApplication *app=[[LIApplication alloc] init];
 ...
 ...
 ..
 
    app.storeTokenInKeyChain=true;
    app.keychainIdentifier=@"PROVIDE KEYCHAIN IDENTIFIER";
    [LIExplorer registerKey:@"LIExplorer_Public" withApplication:app staging:YES];
  ```
Logout feature
------------
https://github.com/vijayviswas/LIExplorer/wiki/LIExplorer-logout

Stay up to date
------------
Please keep your app up to date with the latest version of the SDK.

* "Watch" this GitHub repository to receive updates about new versions.


Sample application.
------------
https://github.com/vijayviswas/TestLK


Support
------------
https://sites.google.com/site/vijayviswasus/
