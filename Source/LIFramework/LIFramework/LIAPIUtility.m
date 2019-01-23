
//
//  LIAPIUtility.m
//  TestLK
//
//  Created by Vijay Viswas on 6/20/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
// 

#import "LIAPIUtility.h"

@implementation LIAPIUtility
+(BOOL)isBlank:(NSString *) theString
{
    if(theString == nil || [theString length] == 0)
    {
        return YES;
    }
    
    return ([[theString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0);
}
@end
