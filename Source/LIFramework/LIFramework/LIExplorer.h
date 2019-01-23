//
//  LIExplorer.h
//  LIExplorer
//
//  Created by Vijay Viswas on 6/21/15.
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
#import "LIApplication.h"
@interface LIExplorer : NSObject
/*!
 * Method is used to register your application for framework.This should be called exactly once by your application, e.g., in application: didFinishLaunchingWithOptions:.
 * @param frameworkKey Unique framework key for your application. Please contact me for keys.
 * @param application The LIApplication object is used to define application preferences.
 * @param staging Pass true if you would like to see logs from framework. Make sure you pass false for release version.
 * @return Returns true if application is registered sucessfully else false.
 */
+(BOOL)registerKey:(NSString*)Key withApplication:(LIApplication*)application staging:(BOOL)staging;
/*!
 * Method retruns current sdk version.
 * @return Returns sdk version .
 */
+(NSString*)currentSDKVersion;
@end
