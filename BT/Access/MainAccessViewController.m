//
//  MainAccessViewController.m
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "MainAccessViewController.h"

@interface MainAccessViewController ()

@end

@implementation MainAccessViewController

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
    self.navigationController.navigationBar.hidden = YES;

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

- (IBAction)LoginPush:(id)sender {


    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"Login" forKey:@"TYPE"];
    [request setPostValue:self.loginField.text forKey:@"Login"];
    [request setPostValue:self.passwordFIeld.text forKey:@"Password"];
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Login...";
    self.navigationItem.hidesBackButton = YES;
    // Hide keyword
    
    // Clear text field
    
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
    	
    NSString *responseString = [request responseString];
    NSLog(@"%@",responseString);
     NSLog(@"%d",request.responseStatusCode);
    
    if (request.responseStatusCode == 400)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                message:@"User not found"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        errorAlert.show;
        return;
        
    }
    else if (request.responseStatusCode == 410)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"You put bad password"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        errorAlert.show;
        
    }
    else if (request.responseStatusCode == 403)
    {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"Unknown error"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        errorAlert.show;
        
        
    }
    else if (request.responseStatusCode == 200)
    {
        NSString *responseString = [request responseString];
        
        
                NSRange startRange = [responseString rangeOfString:@"Array[{"];
               NSRange endRange = [responseString rangeOfString:@"\"}]"];
        
               NSRange searchRange = NSMakeRange(startRange.location+6 , endRange.location-startRange.location-4 );
               NSString* forJSON=[[NSString alloc]initWithString:[responseString substringWithRange:searchRange]];
        
        NSLog(@"%@",responseString);
               NSLog(@"%@",forJSON);
        
               NSDictionary *responseDict = [forJSON JSONValue];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
       // [self.navigationController popToRootViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
       // [self.navigationController popToRootViewControllerAnimated:YES];
    

        
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
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:[error localizedDescription]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    errorAlert.show;

    // _result.text = error.localizedDescription;

}

@end
