//
//  MainViewController.m
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "MainViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)alertView:(UIAlertView *)alert clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 0)
    {
        [self performSegueWithIdentifier:@"MainToSettings" sender:self];
        _updateData=YES;
        
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    if(_updateData)
    {
        [self getNewData];
        _updateData=false;
    }
    else
    {
        if (_user)
        {
        if([[[_user valueForKey:@"Department"] description]rangeOfString:@""].location != NSNotFound)
        {
            
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:@"You have empty detail\n Do you want fill it right now?"
                                                                delegate:self
                                                       cancelButtonTitle:@"Fill it"
                                                       otherButtonTitles:@"Back",nil];
            errorAlert.show;
          
        }
        }
        
    }
    
}

-(void)getNewData
{
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"getNewDataS" forKey:@"TYPE"];
    [request setPostValue:[_user valueForKey:@"Login"] forKey:@"Login"];
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Updating...";
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
//        NSRange startRange = [responseString rangeOfString:@"Array[{"];
//        NSRange endRange = [responseString rangeOfString:@"\"}]"];
//        NSRange searchRange = NSMakeRange(startRange.location+6 , endRange.location-startRange.location-4 );
//        
//        NSString* forJSON=[[NSString alloc]initWithString:[responseString substringWithRange:searchRange]];
//        
        NSLog(@"%@",responseString);
       
        
        _user = [responseString JSONValue];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    } else {
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
    
    
    
}

- (void)viewDidLoad
{
   
    [super viewDidLoad];
     [self performSegueWithIdentifier:@"MainToLogin" sender:self];
    self.navigationItem.hidesBackButton = YES;

    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginSucced:(NSDictionary *)dictForMain
{
    _user=dictForMain;
       
}





/*
 -(void)studentSettingsViewControllerDidBack:(StudentSettingsViewController *)controller
 {
 [self dismissViewControllerAnimated:YES completion:nil];
 }
 
 
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MainToLogin"]) {
         MainAccessViewController *MAVC = (MainAccessViewController *)segue.destinationViewController;
         MAVC.loginDelegate = self;
         }
    
    
    if ([segue.identifier isEqualToString:@"MainToBTList"]) {
        BTViewControllerTableViewController *BTVCTVC = (BTViewControllerTableViewController *)segue.destinationViewController;
        BTVCTVC.user = _user;
    }
    
    if ([segue.identifier isEqualToString:@"MainToSettings"]) {
        SettingsViewController *SVC = (SettingsViewController*)segue.destinationViewController;
        SVC.userData = _user;        
    }
    
}

- (IBAction)logOut:(id)sender {
  
    [self performSegueWithIdentifier:@"MainToLogin" sender:self];
    
}


@end
