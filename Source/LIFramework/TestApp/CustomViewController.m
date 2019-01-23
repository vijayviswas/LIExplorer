//
//  CustomViewController.m
//  TestLK
//
//  Created by Vijay Viswas on 6/21/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "CustomViewController.h"

#import "LITokenHandler.h"
@interface CustomViewController ()

@end

@implementation CustomViewController

- (void)viewDidLoad {
    
    
    self.successCallback= ^{
        NSLog(@"This is a block");
       
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Successfully authenticated"
                                                          message:@""
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
    };
    self.failureCallback=^(NSError* error){
        NSLog(@"This is a error block");
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Error"
                                                          message:@""
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
    };

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SubmitButtonEvent:(id)sender {
    [self authenticateWithUsername:self.Email.text andPassword:self.PWD.text];
}
@end
