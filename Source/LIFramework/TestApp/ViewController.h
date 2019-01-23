//
//  ViewController.h
//  TestLK
//
//  Created by Vijay Viswas on 6/16/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSMutableData *_responseData;
}

@property (weak, nonatomic) IBOutlet UIWebView *WebView;
@property (nonatomic,strong) NSString *code;
- (IBAction)StartEvent:(id)sender;
@property (nonatomic,strong) NSString *state;
- (IBAction)OpenLiWithNavigationBar:(id)sender;
- (IBAction)OPenCustomVC:(id)sender;
@property (nonatomic,strong) NSDictionary *config;
@end

