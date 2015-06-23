# LIFramework.framework
LIFramework.framework is a Objective C library for LinkedIn integration in iOS applications.
This is lite version. This works only in simulator. Use "TEST" key to register the framework.
Coming soon....


<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide1.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide2.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide6.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide9.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>


User guide
------------
* Register your application with framework.
For simulator use "TEST" key. If you want to see logs from framework then pass "Yes" value to staging. Also ensure to setup LIApplication object with client id, client secret key,redrect url, state etc. Please refer below linkedIn website.

https://developer.linkedin.com/docs

```
LIApplication *app=[[LIApplication alloc] init];
    app.clientId=;
    app.clientSecret=;
    app.redirectURL=;
    app.state=;
    [LIFramework registerKey:@"TEST" withApplication:app staging:YES];
  ```
There are various properties defined in LIApplication to specify login webview size, hide default login webview and also token is stored in NSUserdefaults by default. If you would like to store it in keychain then pass true to **storeTokenInKeyChain** property. Also ensure to pass keychain identifier.

* Invoke linkedin login screen
LIAuthorizationVC viewcontroller is used to autheticate to linkedIn. Check whether accesstoken is already present or not before you initialize LIAuthorizationVC because we don't need to login again if access token is already granted and is not expired. The below code opens default linkedin webview without navigation bar..
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide3.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>

```
 if(![LITokenHandler isValidToken])
    {
        LIAuthorizationVC *vc=[[LIAuthorizationVC alloc]initWithSuccessBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
        } failureBlock:^(NSError *error) {
            
        }];
        [self presentViewController:vc animated:YES completion:nil];
    }
  ```
If you want to have a navigation bar on the top of webview then use below code.
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide4.jpg" alt="Authentication" title="Authentication" width="720" height="540">
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
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide5.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>

* REST API

if **[LITokenHandler isValidToken]** returns true then you have a valid access token and you can start calling below services.

<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide7.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide8.jpg" alt="Authentication" title="Authentication" width="720" height="540">
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
