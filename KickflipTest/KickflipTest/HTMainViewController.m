//
//  HTMainViewController.m
//  KickflipTest
//
//  Created by Jason on 2015/7/13.
//  Copyright (c) 2015年 HT. All rights reserved.
//

#import "HTMainViewController.h"
#import "Kickflip.h"
#import "KFAPIClient.h"
#import <MediaPlayer/MediaPlayer.h>

@interface HTMainViewController ()

@end

@implementation HTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Authentication
    [Kickflip setupWithAPIKey:@"VNGs;Xo?EJ_d-gC-HKpu@JJ!W-?rVl77pwN?lJys" secret:@"l7tb_OsLhICF0=J!HyTx7kV-cXvv.K0ETGF5QhSZOAO44K.o561fhEOQR@d1pNJM3P3ZKFC1DQx7SA5FPXi8OmW1x9jgTpbkPKe_o1:Y1y9qnBr=Pi:H9o6Fzp=f7Qnu"];
}

-(IBAction)recordButtonClicked:(UIButton *)button
{
    
    //
    [Kickflip presentBroadcasterFromViewController:self ready:^(KFStream *stream) {
        NSLog(@"Stream is ready to view at URL: %@", stream.streamURL);
        if (stream) {
            NSLog(@"Stream is ready to view at URL: %@", stream.streamURL);
        } else {
            //            NSLog(@"An error occurred: %@", error);
        }
    } completion:^(BOOL success, NSError *error) {
        NSLog(@"Finished broadcasting.");
    }];

}

-(IBAction)playButtonClicked:(UIButton *)button
{
    NSURL *url = [NSURL URLWithString:@"https://d29xsu8h6iusrj.cloudfront.net/happytest/vvzlx5pl3uc4/f2545b78-1688-4254-9c13-a55f3c2151bf/index.m3u8"];
    MPMoviePlayerViewController *movieView = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self presentViewController:movieView animated:YES completion:nil];
}

-(IBAction)createUserButtonClicked:(UIButton *)button
{
    // Creating a New User
    [[KFAPIClient sharedClient] requestNewActiveUserWithUsername:@"HappyBoy" password:@"123456" email:@"happyboy@gmail.com" displayName:@"Happy Boy" extraInfo:@{@"gender":@"boy",@"otherInfo": @"Any other key/values you would want"} callbackBlock:^(KFUser *activeUser, NSError *error) {
        if (activeUser) {
            NSLog(@"great, you've got a new user!");
        }
        else {
            NSLog(@"bad, you've got a old user!");
        }
    }];
}

-(IBAction)getUserButtonClicked:(UIButton *)button
{
    [[KFAPIClient sharedClient] requestUserInfoForUsername:@"HappyBoy" callbackBlock:^(KFUser *existingUser, NSError *error) {
        if (existingUser) {
            NSLog(@"you got info for an existing user!");
        }
    }];
}

-(IBAction)changeUserButtonClicked:(UIButton *)button
{
    [[KFAPIClient sharedClient] updateMetadataForActiveUserWithNewPassword:@"123456" email:@"test@example.com" displayName:@"Happy Girl" extraInfo:@{@"otherInfo": @"Any other key/values you would want"}  callbackBlock:^(KFUser *updatedUser, NSError *error) {
        if (updatedUser) {
            NSLog(@"great, you've got updated a user!");
        }
    }];
}

-(IBAction)getUserKeyButtonClicked:(UIButton *)button
{
    [[KFAPIClient sharedClient] loginExistingUserWithUsername:@"HappyBoy" password:@"123456" callbackBlock:^(KFUser *existingUser, NSError *error) {
        if (existingUser) {
            NSLog(@"successfully logged in existing user");
        }
    }];
}

@end
