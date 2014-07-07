//
//  VerifyTeacherViewController.m
//  BT
//
//  Created by LGBS dev on 7/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "VerifyTeacherViewController.h"

@interface VerifyTeacherViewController ()

@end

@implementation VerifyTeacherViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)Verify:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"Verify" forKey:@"TYPE"];
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Veryfing...";
    self.navigationItem.hidesBackButton = YES;
    
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.responseStatusCode == 400) {
        // _result.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
        //  _result.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        
//        
//        NSRange startRange = [responseString rangeOfString:@"Array{"];
//        NSRange endRange = [responseString rangeOfString:@"\"}"];
//        
//        NSRange searchRange = NSMakeRange(startRange.location+5 , endRange.location-startRange.location+-3 );
//        NSString* forJSON=[[NSString alloc]initWithString:[responseString substringWithRange:searchRange]];
//        
        NSLog(@"%@",responseString);
//        NSLog(@"%@",forJSON);
//        
//        NSDictionary *responseDict = [forJSON JSONValue];
//        
        // _result.text = responseString;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.navigationItem.hidesBackButton = NO;
        
    } else {
        //_result.text = @"Unexpected error";
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.navigationItem.hidesBackButton = NO;
        
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    self.navigationItem.hidesBackButton = NO;
    // _result.text = error.localizedDescription;
}
@end
