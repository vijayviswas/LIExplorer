//
//  LIAuthorizationVC.h
//  TestLK
//
//  Created by Vijay Viswas on 6/18/15.
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

#import <UIKit/UIKit.h>
#import "LIApplication.h"
/*!
 * @typedef  LICompletionBlock
 * @brief    Framework calls this block when access token is received from LinkedIn.
 */
typedef void (^LICompletionBlock) (void);
/*
 Error code 60001: User denied access.
 Error code 60002: Internal Error.
 Error code 60003: Invalid redirection.
 Error code 60004: Form validation error.
 Error code 60005: LinkedIn Rest API error.
 
 * @typedef  LIErrorBlock
 * @brief    This block is called by framework when an error occured by authenticating to LinkedIn.
 * @property error The NSError object related to the failure.
 */
typedef void (^LIErrorBlock) (NSError *error);
/*!
 @details LIAuthorizationVCView provides default webview to authenticate LinkedIn. Also subclass this viewcontroller to override default webview login screen.
 @author Vijay Viswas
 */
@interface LIAuthorizationVC : UIViewController
/*!
 * @brief This property is used to define custom navigation bar for default webview screen.
 */
@property(nonatomic,strong)UINavigationBar *webViewNavigationNar;
@property(nonatomic, copy) LIErrorBlock failureCallback;
@property(nonatomic, copy) LICompletionBlock successCallback;
/**
 Initializes a LIAuthorizationVC viewcontroller.
 * @param success A success block.
 * @param failure A failure block.
 * @returns A pointer to a LIAuthorizationVC instance.
 **/
- (id)initWithSuccessBlock:(LICompletionBlock)success failureBlock:(LIErrorBlock)failure;
/*!
 * Method is used in custom viewcontroller to authenticate using user name and password.
 * @param username User name.
 * @param password Password.
 */
-(void)authenticateWithUsername:(NSString*)username andPassword:(NSString*)password;
@end
