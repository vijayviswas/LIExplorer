//
//  ShareViewController.h
//  TestLK
//
//  Created by Vijay Viswas on 6/16/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShareViewController : UIViewController
{
    NSMutableData *_responseData;
}
@property(nonatomic,strong) NSMutableArray *titleNames;

- (IBAction)submit:(id)sender;

@end
