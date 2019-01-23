//
//  CustomViewController.h
//  TestLK
//
//  Created by Vijay Viswas on 6/21/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "LIAuthorizationVC.h"
@interface CustomViewController : LIAuthorizationVC
@property (weak, nonatomic) IBOutlet UITextField *Email;
@property (weak, nonatomic) IBOutlet UITextField *PWD;
- (IBAction)SubmitButtonEvent:(id)sender;

@end
