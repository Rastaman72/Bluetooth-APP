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
    self.accountTypeArray = [[NSArray alloc] initWithObjects:@"Student",@"Wykładowca" , nil];
    self.selectAccountType = [[NSString alloc]init];
    self.selectAccountType=[self.accountTypeArray objectAtIndex:0];

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
    return 2;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    
    return [self.accountTypeArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectAccountType=[self.accountTypeArray objectAtIndex:row];
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

- (IBAction)CreateAccount:(id)sender {
    
    
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    if([_selectAccountType  isEqual: @"Student"])
        [request setPostValue:@"CreateS" forKey:@"TYPE"];
    
    else
        [request setPostValue:@"CreateT" forKey:@"TYPE"];
    
    [request setPostValue:_loginField.text forKey:@"Login"];
    [request setPostValue:_passwordField.text forKey:@"Password"];

    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Registering...";
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
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
        
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
@end
