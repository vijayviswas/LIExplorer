//
//  LIApplication.h
//  TestLK
//
//  Created by Vijay Viswas on 6/18/15.
//  strongright (c) 2015 Vijay Viswas. All rights reserved.
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
#import <UIKit/UIKit.h>
/*!
 @details LIApplication is a model class used to define application preferences.
 @author Vijay Viswas
 */

@interface LIApplication : NSObject
/*!
 * @brief A unique string value of your choice that is hard to guess. Used to prevent CSRF.
 */
@property(nonatomic, strong) NSString *state;
/*!
 * @brief This property is used to hide default webview login screen.
 */
@property (nonatomic,assign) BOOL hideDefaultWebView;
/*!
 * @brief This property contains rectangular bounds of webview.
 */
@property(nonatomic, assign) CGRect webviewRect;
/*!
 * @brief The URI your users will be sent back to after authorization.  This value must match one of the defined OAuth 2.0 Redirect URLs in your application configuration.
 */
@property(nonatomic, strong) NSString *redirectURL;
/*!
 * @brief The "LinkedIn API Key" value generated when you registered your application.
 */
@property(nonatomic, strong) NSString *clientId;
/*!
 * @brief The "LinkedIn API secret" value generated when you registered your application.
 */
@property(nonatomic, strong) NSString *clientSecret;
/*!
 * @brief This property is used to store access token, toekn expiration value and token generated time in keychain instead NSUserDefaults
 */
@property(nonatomic, assign) BOOL storeTokenInKeyChain;
/*!
 * @brief This property is used to define keychain identifier to save token.
 */
@property(nonatomic, strong) NSString *keychainIdentifier;

@end
