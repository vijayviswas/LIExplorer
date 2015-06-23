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
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide3.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide4.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide5.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide6.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide7.jpg" alt="Authentication" title="Authentication" width="720" height="540">
</p>
<p align="center" >
  <img src="https://github.com/vijayviswas/LIFramework/blob/master/Images/Slide8.jpg" alt="Authentication" title="Authentication" width="720" height="540">
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

