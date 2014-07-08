//
//  SettingsStudentViewController.m
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "SettingsStudentViewController.h"

@interface SettingsStudentViewController ()

@end

@implementation SettingsStudentViewController

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
    self.departmentArray = [[NSArray alloc] initWithObjects:@"AEII",@"Green",@"Orange",@"Purple",@"Red",@"Yellow" , nil];
    self.yearArray = [[NSArray alloc] initWithObjects:@"I",@"II",@"III",@"IV",@"V" , nil];
    
    self.termArray = [[NSArray alloc] initWithObjects:@"I",@"II",@"III",@"IV",@"V",@"VI",@"VII",@"VIII",@"IX",@"X" , nil];
    self.specArray = [[NSArray alloc] initWithObjects:@"gkio",@"bdisd",@"psi", nil];
    
    
    self.selectDepartment = [[NSString alloc]init];
    self.selectYear = [[NSString alloc]init];
    self.selectTerm = [[NSString alloc]init];
    self.selectSpec = [[NSString alloc]init];
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
    if (pickerView==_department) {
         return 6;
    }
    else if (pickerView==_year)
    {
         return 5;
    }
    else if (pickerView==_term)
    {
        return 10;
    }
    else if (pickerView==_spec)
    {
        return 3;
    }
    return 0;
   
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row   forComponent:(NSInteger)component
{
    if (pickerView==_department) {
       return [self.departmentArray objectAtIndex:row];
    }
    else if (pickerView==_year)
    {
        return [self.yearArray objectAtIndex:row];    }
    else if (pickerView==_term)
    {
       return [self.termArray objectAtIndex:row];
    }
    else if (pickerView==_spec)
    {
        return [self.specArray objectAtIndex:row];
    }

    return 0;
    
  
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView==_department)
    {
        self.selectDepartment=[self.departmentArray objectAtIndex:row];
    }
    else if (pickerView==_year)
    {
        self.selectYear= [self.yearArray objectAtIndex:row];
    }
    else if (pickerView==_term)
    {
        self.selectTerm= [self.termArray objectAtIndex:row];
    }
    else if (pickerView==_spec)
    {
        self.selectSpec= [self.specArray objectAtIndex:row];
    }

    
    
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



- (void)requestFinished:(ASIHTTPRequest *)request
{
    
    if (request.responseStatusCode == 400) {
        // _result.text = @"Invalid code";
    } else if (request.responseStatusCode == 403) {
        //  _result.text = @"Code already used";
    } else if (request.responseStatusCode == 200) {
        NSString *responseString = [request responseString];
        
        
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
- (IBAction)SaveSChange:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"UpdateS" forKey:@"TYPE"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Registering...";
    self.navigationItem.hidesBackButton = YES;
    
}
@end
