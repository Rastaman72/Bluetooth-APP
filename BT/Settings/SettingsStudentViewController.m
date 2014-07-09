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
        switch (row) {
            case 0:
                self.selectYear=1;
                break;
            case 1:
                self.selectYear=2;
                break;
            case 2:
                self.selectYear=3;
                break;
            case 3:
                self.selectYear=4;
                break;
            case 4:
                self.selectYear=5;
                break;
            default:
                break;
        }
        
        
    }
    else if (pickerView==_term)
    {
        switch (row) {
            case 0:
                self.selectTerm=1;
                break;
            case 1:
                self.selectTerm=2;
                break;
            case 2:
                self.selectTerm=3;
                break;
            case 3:
                self.selectTerm=4;
                break;
            case 4:
                self.selectTerm=5;
                break;
            case 5:
                self.selectTerm=6;
                break;
            case 6:
                self.selectTerm=7;
                break;
            case 7:
                self.selectTerm=8;
                break;
            case 8:
                self.selectTerm=9;
                break;
            case 9:
                self.selectTerm=10;
                break;
            default:
                break;
        }

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




- (IBAction)SaveSChange:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    NSNumber* year=[[NSNumber alloc]initWithInt:_selectYear];
    NSNumber* term=[[NSNumber alloc]initWithInt:_selectTerm];
    
    [request setPostValue:@"UpdateS" forKey:@"TYPE"];
       [request setPostValue:_selectDepartment forKey:@"Department"];
       [request setPostValue:year forKey:@"Year"];
       [request setPostValue:term forKey:@"Term"];
       [request setPostValue:_selectSpec forKey:@"Spec"];
    [request setPostValue:[_student valueForKey:@"Login"] forKey:@"Login"];
    
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
        
        NSLog(@"%@",responseString);
        
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
    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:[error localizedDescription]
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
    errorAlert.show;
    
    // _result.text = error.localizedDescription;
    
}

@end
