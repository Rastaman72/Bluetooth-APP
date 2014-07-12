//
//  SettingsViewController.m
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    if([[[_userData valueForKey:@"Role"] description]rangeOfString:@"Student"].location != NSNotFound)
        _teacherButton.enabled=false;
    else
        _studentButton.enabled=false;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (void)requestFinished:(ASIHTTPRequest *)request
{
    if (request.responseStatusCode == 400) {
        // _result.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
        //  _result.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        
        NSLog(@"%@",responseString);
      //  _student = [forJSON JSONValue];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        [[self navigationController]popToRootViewControllerAnimated:YES];
        
    } else if (request.responseStatusCode == 201) {
        NSString *responseString = [request responseString];
        //dokonczyc parsowanie odpowiedzi na temat ustawien studenta i teachera
      
        
        NSLog(@"%@",responseString);
        
        //  _student = [forJSON JSONValue];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        [[self navigationController]popToRootViewControllerAnimated:YES];
        
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


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
     if ([segue.identifier isEqualToString:@"SettingsToStudent"]) {
         SettingsStudentViewController *SSVC = (SettingsStudentViewController *)segue.destinationViewController;
         SSVC.student = _userData;
         SSVC.departmentArray;
         SSVC.yearArray;
         SSVC.termArray;
         SSVC.specArray;
        }
     
     if ([segue.identifier isEqualToString:@"SettingsToTeacher"]) {
         SettingsTeacherViewController *STVC = (SettingsTeacherViewController *)segue.destinationViewController;
         STVC.teacher = _userData;
     
     }
     

 }
 

- (IBAction)studentPush:(id)sender
{
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    
    [request setPostValue:@"loadStudentSettings" forKey:@"TYPE"];

    
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Updating...";
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)teacherPush:(id)sender {
}
@end
