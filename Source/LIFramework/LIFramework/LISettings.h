//
//  LILicense.h
//  TestLK
//
//  Created by Vijay Viswas on 6/20/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LIApplication.h"


@interface LISettings : NSObject

@property(nonatomic,strong)LIApplication *application;
@property(nonatomic, assign) BOOL staging;


+(instancetype)sharedInstance;
-(BOOL)registerApplicationKey:(NSString*)applicationKey;
-(BOOL)validateLIApplication:(LIApplication*)application;
-(BOOL)isValidKey;



@end
