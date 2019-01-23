//
//  ShareViewController.m
//  TestLK
//
//  Created by Vijay Viswas on 6/16/15.
//  Copyright (c) 2015 Vijay Viswas. All rights reserved.
//

#import "ShareViewController.h"
#import "LIRestAPIHandlers.h"
#import "LITokenHandler.h"
@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleNames=[[NSMutableArray alloc] initWithObjects:@"Share comment",@"Share with specific values",@"Company share comment",@"Company Share with specific values",@"Get profile",@"Check if sharing is enabled for a company",@"Company profile",@"Statistics for a company page",@"Historical status update statistics about a company",@"Historical follower statistics about a company",@"Company's updates",@"single specific company update record for the company",@"Comments for a specific company update",@"Likes for a specific company update",@"Check member admin of company",@"Logout", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.titleNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECell" forIndexPath:indexPath];
    cell.textLabel.text=[self.titleNames objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}
-(void)callAPIAtIndex:(int)index
{
    if (index==0) {
        
        [LIRestAPIHandlers shareComment:@"TEST share API" withVisibity:LICommentVisibilityConnectionsOnly
                    withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
                        NSLog(@"%@",dic);
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                        NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
                    } failure:^(NSError *error) {
                        NSLog(@"Error: check error object");
                    }];
    }
    else if (index==1)
    {
        
        [LIRestAPIHandlers shareComment:@"Test APi" withTitle:@"LinkedIn Developers Resources" withDescription:@"Leverage LinkedIn's APIs to maximize engagement" withSubmittedUrl:@"https://developer.linkedin.com" withImageURL:@"" withVisibity:LICommentVisibilityConnectionsOnly withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else if (index==2)
    {
        [LIRestAPIHandlers shareComment:@"TEST API" forCompanyID:@"2414183" withVisibity:LICommentVisibilityAnyone
                    withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
                        NSLog(@"%@",dic);
                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                        NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
                    } failure:^(NSError *error) {
                        NSLog(@"Error: check error object");
                    }];

    }
    else if (index==3)
    {
        [LIRestAPIHandlers shareComment:@"Test APi" forCompanyID:@"2414183" withTitle:@"LinkedIn Developers Resources" withDescription:@"Leverage LinkedIn's APIs to maximize engagement" withSubmittedUrl:@"https://developer.linkedin.com" withImageURL:@"" withVisibity:LICommentVisibilityAnyone withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];

    }
    else if (index==4)
    {
        
        [LIRestAPIHandlers requestProfile:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
            
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else if (index==5)
    {
        [LIRestAPIHandlers  checkSharingEnabledForCompanyID:@"2414183" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else if (index==6)
    {
        [LIRestAPIHandlers companyProfileForCompanyID:@"2414183" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else if (index==7)
    {
        [LIRestAPIHandlers getStatisticsForCompanyID:@"2414183" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else if (index==8)
    {
        [LIRestAPIHandlers getHistoricalStatisticsForCompanyID:@"2414183" withTimeGranularity:LIGranularityDay withTimestamp:@"1434856518"withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];

    }
    else if (index==9)
    {
        [LIRestAPIHandlers getHistoricalFollowerStatisticsForCompanyID:@"2414183" withTimeGranularity:LIGranularityDay withTimestamp:@"1434856518" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else if (index==10)
    {
        [LIRestAPIHandlers getCompanyUpdatesForCompanyID:@"2414183" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];

    }
    else if (index==11)
    {
        [LIRestAPIHandlers getSpecificCompanyUpdatesForCompanyID:@"2414183" andUpdateKEy:@"" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else if (index==12)
    {
        [LIRestAPIHandlers getCommentsOfSpecificCompanyUpdatesForCompanyID:@"2414183" andUpdateKEy:@"" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else if (index==13)
    {
        [LIRestAPIHandlers getLikesOfSpecificCompanyUpdatesForCompanyID:@"2414183" andUpdateKEy:@"" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else if (index==14)
    {
        [LIRestAPIHandlers checkMemberIsAdminForCompanyID:@"2414183" withCompletionBlock:^(NSDictionary *dic, NSURLResponse *response) {
            NSLog(@"%@",dic);
        } failure:^(NSError *error) {
            NSLog(@"Error: check error object");
        }];
    }
    else{
        [LITokenHandler clearToken];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self callAPIAtIndex:indexPath.row];
}

@end
