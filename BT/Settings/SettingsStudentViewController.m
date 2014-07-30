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
      self.delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];    
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
         return [_departmentArray count];
    }
    else if (pickerView==_year)
    {
         return [_yearArray count];
    }
    else if (pickerView==_term)
    {
        return [_termArray count];
    }
    else if (pickerView==_spec)
    {
        return [_specArray count];
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
        return [[self.yearArray objectAtIndex:row]description];

    }
    else if (pickerView==_term)
    {
    
        return [[self.termArray objectAtIndex:row]description];

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
        self.selectYear=[[self.yearArray objectAtIndex:row]integerValue];
       /* switch (row) {
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
        }*/
        
        
    }
    else if (pickerView==_term)
    {
        /*switch (row) {
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
        }*/
         self.selectTerm=[[self.termArray objectAtIndex:row]integerValue];

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


-(BOOL)validTermAndYear:(int)selectYear term:(int)selectTerm
{
    switch (selectYear) {
        case 1:
            if (selectTerm==1 || selectTerm==2) {
                return true;
            }
            break;
            
        case 2:
            if (selectTerm==3 || selectTerm==4) {
                return true;
            }
            break;
            
        case 3:
            if (selectTerm==5 || selectTerm==6) {
                return true;
            }
            break;
            
        case 4:
            if (selectTerm==7 || selectTerm==8) {
                return true;
            }
            break;
            
        case 5:
            if (selectTerm==9 || selectTerm==10) {
                return true;
            }
            break;
            
        default:
            break;
    }
    return false;
}

- (IBAction)SaveSChange:(id)sender {
    if(self.delegate.sendFree)
    {
        
#warning SYFFFFF
#warning SYFFFFF
#warning SYFFFFF
    NSString* test =[[NSString alloc]initWithString:[[_student valueForKey:@"Login"]description]];
    test = [test stringByReplacingOccurrencesOfString:@"(\n" withString:@""];
    test = [test stringByReplacingOccurrencesOfString:@"\n)" withString:@""];
    test = [test stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];

    
        if([self validTermAndYear:_selectYear term:_selectTerm])
    {
         self.delegate.sendFree=false;
        NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        

    NSNumber* year=[[NSNumber alloc]initWithInt:_selectYear];
    NSNumber* term=[[NSNumber alloc]initWithInt:_selectTerm];
    
    [request setPostValue:@"UpdateS" forKey:@"TYPE"];
    //[request setPostValue:[_student valueForKey:@"Login"] forKey:@"Login"];
    [request setPostValue:test forKey:@"Login"];

       [request setPostValue:_selectDepartment forKey:@"Department"];
       [request setPostValue:year forKey:@"Year"];
       [request setPostValue:term forKey:@"Term"];
       [request setPostValue:_selectSpec forKey:@"Spec"];
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Updating...";
    self.navigationItem.hidesBackButton = YES;
    }
    
    else{
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                             message:@"Choose correct year and term"
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
    errorAlert.show;
    }
    }

}




- (void)requestFinished:(ASIHTTPRequest *)request
{
      self.delegate.sendFree=true;
    if (request.responseStatusCode == 400) {
        NSString *responseString = [request responseString];
        NSLog(@"%@",responseString);

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
//        NSLog(@"%@",responseString);
//        NSLog(@"%@",forJSON);
//        
//        _student = [forJSON JSONValue];
        NSLog(@"%@",responseString);
        NSData* data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
        NSError*error;
        _student=[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];

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
