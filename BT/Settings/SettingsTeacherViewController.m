//
//  SettingsTeacherViewController.m
//  BT
//
//  Created by LGBS dev on 7/5/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SettingsTeacherViewController.h"

@interface SettingsTeacherViewController ()

@end

@implementation SettingsTeacherViewController

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
      self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // Do any additional setup after loading the view.
//    self.departmentArray = [[NSArray alloc] initWithObjects:@"EIM",@"ZMITAC",@"INF",@"GK", nil];
//    self.subjectArray = [[NSArray alloc] initWithObjects:@"test1",@"test2",@"test3",@"test4",@"test5" , nil];
    
    self.selectDepartment = [[NSString alloc]init];
    self.selectSubject = [[NSString alloc]init];

    [self performSegueWithIdentifier:@"TeacherToLogin" sender:self];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent: (NSInteger)component
{
    if (pickerView==_department) {
        return [_departmentArray count];

    }
    else if (pickerView==_subject)
    {
       return [_subjectArray count];    }
    return 0;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    if (pickerView==_department) {
        return [self.departmentArray objectAtIndex:row];
    }
    else if (pickerView==_subject)
    {
        return [self.subjectArray objectAtIndex:row];
    }
    
    return 0;
    
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView==_department)
    {
        self.selectDepartment=[self.departmentArray objectAtIndex:row];
    }
    else if (pickerView==_subject)
    {
        self.selectSubject= [self.subjectArray objectAtIndex:row];
        
        
    }
    
    
    
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     /*
     
     if ([segue.identifier isEqualToString:@"TeacherToLogin"]) {
         VerifyTeacherViewController.h *MAVC = (MainAccessViewController *)segue.destinationViewController;
         MAVC.loginDelegate = self;
     }*/
 }


- (IBAction)SaveChange:(id)sender {
#warning SYFFFFF
#warning SYFFFFF
#warning SYFFFFF
    if(self.delegate.sendFree)
    {
         self.delegate.sendFree=false;
    NSString* test =[[NSString alloc]initWithString:[[_teacher valueForKey:@"Login"]description]];
    test = [test stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
    test = [test stringByReplacingOccurrencesOfString:@"\n)" withString:@""];
    test = [test stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"UpdateT" forKey:@"TYPE"];
    [request setPostValue:_selectDepartment forKey:@"Department"];
    [request setPostValue:_selectSubject forKey:@"Subject"];
   // [request setPostValue:[[_teacher valueForKey:@"Login"]description ] forKey:@"Login"];
    [request setPostValue:test forKey:@"Login"];

    
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Updating...";
    self.navigationItem.hidesBackButton = YES;
    }
}



- (void)requestFinished:(ASIHTTPRequest *)request
{
      self.delegate.sendFree=true;
    if (request.responseStatusCode == 400) {
        // _result.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
        //  _result.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        
 
        NSLog(@"%@",responseString);

        // _result.text = responseString;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.navigationItem.hidesBackButton = NO;
        [[self navigationController]popToRootViewControllerAnimated:YES];

        
    } else {
        //_result.text = @"Unexpected error";
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        self.navigationItem.hidesBackButton = NO;
        
    }
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
      self.delegate.sendFree=true;
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
