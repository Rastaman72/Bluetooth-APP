//
//  RegisterViewController.m
//  BT
//
//  Created by LGBS dev on 7/7/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    self.selectAccountType = [[NSString alloc]init];
    self.selectAccountType=[self.accountTypeArray objectAtIndex:0];
    _loginField.delegate=self;
 
    // Do any additional setup after loading the view.
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
    return [_accountTypeArray count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.accountTypeArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectAccountType=[self.accountTypeArray objectAtIndex:row];
}

- (void)sendRequest {
    if(self.delegate.sendFree)
    {
        
    if([_passwordField.text isEqualToString:_repeatPasswordField.text])
    {
         self.delegate.sendFree=false;
        NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        
        if([_selectAccountType  isEqual: @"Student"])
            [request setPostValue:@"CreateS" forKey:@"TYPE"];
        
        else
            [request setPostValue:@"CreateT" forKey:@"TYPE"];
        
        [request setPostValue:_loginField.text forKey:@"Login"];
        [request setPostValue:_passwordField.text forKey:@"Password"];
        [request setPostValue:_tPassword forKey:@"TPassword"];
        
        [request setDelegate:self];
        [request startAsynchronous];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Registering...";
        self.navigationItem.hidesBackButton = YES;
    }
    else
    {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"You put diffrent password in repeat password field"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        errorAlert.show;
        
    }
    }
}

- (IBAction)CreateAccount:(id)sender {
    if(![[_loginField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]
       &&
       ![[_passwordField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""])
    {
    
    if([_selectAccountType  isEqual: @"Teacher"])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verify"
                                                       message:@"Please put verify password"
                                                      delegate:self
                                             cancelButtonTitle:@"Send"
                                             otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
       
    }
    else
    [self sendRequest];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Fields cannot be empty"
                                                       delegate:self
                                              cancelButtonTitle:@"Back"
                                              otherButtonTitles:nil];
    [alert show];
    }

}



- (void)requestFinished:(ASIHTTPRequest *)request
{
      self.delegate.sendFree=true;
    if (request.responseStatusCode == 400) {
        // _result.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
        //  _result.text = @"Code already used";
    }else if (request.responseStatusCode == 410) {
        
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"User already exsist"
                                                             delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        errorAlert.show;
        

        
    }
    else if (request.responseStatusCode == 405) {
        NSString *responseString = [request responseString];

        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"Verification failed"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
        errorAlert.show;
        
        
        
    }
    else if (request.responseStatusCode == 200) {
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
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        
    } else {
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
}
- (IBAction)backPush:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)textFieldDidEndEditing:(UITextField *)textField;
{
    _loginField.text=[_loginField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    _tPassword=[[NSString alloc]init];
    if(alertView.alertViewStyle== UIAlertViewStylePlainTextInput )
    {
        _tPassword= [alertView textFieldAtIndex:0].text;
        if(![_tPassword isEqualToString:@""])
            [self sendRequest];
        else
        {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:@"Verify field cannot be empty"
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
            errorAlert.show;
        }
    }

}
@end
