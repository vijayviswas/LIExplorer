//
//  ViewController.m
//  TestLK
//
//  Created by Vijay Viswas on 6/16/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "ViewController.h"
#import "ShareViewController.h"
#import "LIAuthorizationVC.h"
#import "LITokenHandler.h"

#import "CustomViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //self.WebView.hidden=YES;
    /// Do any additional setup after loading the view, typically from a nib.
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    
}
-(void)loadShareVC
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    ShareViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
    [self presentViewController:lvc animated:YES completion:nil];
    //[self sharelinkedin];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] isKindOfClass:[CustomViewController class]])
    {
        LIAuthorizationVC *checkOutVC = [segue destinationViewController];
        
        checkOutVC.successCallback= ^{
            NSLog(@"This is a block");
        };
        checkOutVC.failureCallback=^(NSError* error){
            NSLog(@"This is a error block");
        };
    }
}
- (IBAction)StartEvent:(id)sender {
    
    
    
    if(![LITokenHandler isValidToken])
    {
        LIAuthorizationVC *vc=[[LIAuthorizationVC alloc]initWithSuccessBlock:^{
            [self dismissViewControllerAnimated:YES completion:nil];
            [self loadShareVC];
        } failureBlock:^(NSError *error) {
            NSDictionary *userInfo = [error userInfo];
            if([userInfo objectForKey:@"Url"])
            {
                NSLog(@"User clicked on link :%@",[userInfo objectForKey:@"Url"]);
            }
            
        }];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else{
        [self loadShareVC];
    }
    
    
}
-(void)yourMethod
{
    
}
-(void)yourOtherMethod
{
    
}
- (IBAction)OpenLiWithNavigationBar:(id)sender {
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
            [self loadShareVC];
        } failureBlock:^(NSError *error) {
            NSDictionary *userInfo = [error userInfo];
            if([userInfo objectForKey:@"Url"])
            {
                NSLog(@"User clicked on link :%@",[userInfo objectForKey:@"Url"]);
            }
        }];
        vc.webViewNavigationNar=navBar;
        [self presentViewController:vc animated:YES completion:nil];
    }
    else{
        [self loadShareVC];
    }
    
    
}

- (IBAction)OPenCustomVC:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    CustomViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"LIAuthorizationVC"];
    [self presentViewController:lvc animated:YES completion:nil];
    return;
    
}
@end

