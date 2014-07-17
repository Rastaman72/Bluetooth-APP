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
       
        responseString= [responseString stringByReplacingOccurrencesOfString:@"[" withString:@""];
        responseString= [responseString stringByReplacingOccurrencesOfString:@"]" withString:@""];
        NSLog(@"%@",responseString);
        NSArray *listItems = [responseString componentsSeparatedByString:@","];
        _tempDepartment = [[NSMutableDictionary alloc]init];
        _tempYear = [[NSMutableDictionary alloc]init];
        _tempTerm = [[NSMutableDictionary alloc]init];
        _tempSpec = [[NSMutableDictionary alloc]init];
        
        _tempDepartmentArray= [[NSMutableArray alloc]init];
        _tempYearArray= [[NSMutableArray alloc]init];
        _tempTermArray= [[NSMutableArray alloc]init];
        _tempSpecArray= [[NSMutableArray alloc]init];

        
        NSError* error;
        for(NSString* key in listItems)
        {
            if([key rangeOfString:@"Department"].location != NSNotFound)
            {
                NSData* data = [key dataUsingEncoding:NSUTF8StringEncoding];
#warning IOS PONIZEJ 7 DO SPRAWDZENIA
#warning nsjson moze sie wywalic
#warning WAZNE
                [_tempDepartment setDictionary:[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error]];
                
                 [_tempDepartmentArray addObject:_tempDepartment[[[_tempDepartment allKeys] objectAtIndex:0]] ];
            }
            else if([key rangeOfString:@"Year"].location != NSNotFound)
            {
                NSData* data = [key dataUsingEncoding:NSUTF8StringEncoding];
#warning IOS PONIZEJ 7 DO SPRAWDZENIA
#warning nsjson moze sie wywalic
#warning WAZNE
                [_tempYear setDictionary:[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error]];
                [_tempYearArray addObject:_tempYear[[[_tempYear allKeys] objectAtIndex:0]] ];

            }
            else if([key rangeOfString:@"Term"].location != NSNotFound)
            {
                NSData* data = [key dataUsingEncoding:NSUTF8StringEncoding];
#warning IOS PONIZEJ 7 DO SPRAWDZENIA
#warning nsjson moze sie wywalic
#warning WAZNE
                [_tempTerm setDictionary:[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error]];
                 [_tempTermArray addObject:_tempTerm[[[_tempTerm allKeys] objectAtIndex:0]] ];

            }
            else if([key rangeOfString:@"Spec"].location != NSNotFound)
            {
                NSData* data = [key dataUsingEncoding:NSUTF8StringEncoding];
#warning IOS PONIZEJ 7 DO SPRAWDZENIA
#warning nsjson moze sie wywalic
#warning WAZNE
                [_tempSpec setDictionary:[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error]];
                [_tempSpecArray addObject:_tempSpec[[[_tempSpec allKeys] objectAtIndex:0]] ];

            }
            
            
        }

        
        //  _student = [forJSON JSONValue];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        //[[self navigationController]popToRootViewControllerAnimated:YES];
         [self performSegueWithIdentifier:@"SettingsToStudent" sender:self];
    } else if (request.responseStatusCode == 202) {
        NSString *responseString = [request responseString];
        //dokonczyc parsowanie odpowiedzi na temat ustawien studenta i teachera
        responseString= [responseString stringByReplacingOccurrencesOfString:@"[" withString:@""];
        responseString= [responseString stringByReplacingOccurrencesOfString:@"]" withString:@""];
        
        
        
        NSLog(@"%@",responseString);
        
        
        
        NSArray *listItems = [responseString componentsSeparatedByString:@","];
        _tempDepa = [[NSMutableDictionary alloc]init];
        _tempInst = [[NSMutableDictionary alloc]init];

        
        _tempDepaArray= [[NSMutableArray alloc]init];
        _tempInstArray= [[NSMutableArray alloc]init];

        
        
        NSError* error;
        for(NSString* key in listItems)
        {
            if([key rangeOfString:@"Department"].location != NSNotFound)
            {
                NSData* data = [key dataUsingEncoding:NSUTF8StringEncoding];
#warning IOS PONIZEJ 7 DO SPRAWDZENIA
#warning nsjson moze sie wywalic
#warning WAZNE
                [_tempDepa setDictionary:[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error]];
                
                [_tempDepaArray addObject:_tempDepa[[[_tempDepa allKeys] objectAtIndex:0]] ];
            }
            else if([key rangeOfString:@"Institute"].location != NSNotFound)
            {
                NSData* data = [key dataUsingEncoding:NSUTF8StringEncoding];
#warning IOS PONIZEJ 7 DO SPRAWDZENIA
#warning nsjson moze sie wywalic
#warning WAZNE
                [_tempInst setDictionary:[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error]];
                [_tempInstArray addObject:_tempInst[[[_tempInst allKeys] objectAtIndex:0]] ];
                
            }
            
            
            
        }
        
        
        //  _student = [forJSON JSONValue];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        //[[self navigationController]popToRootViewControllerAnimated:YES];
        [self performSegueWithIdentifier:@"SettingsToTeacher" sender:self];
    }else {
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
         SSVC.departmentArray=_tempDepartmentArray;
         SSVC.yearArray=_tempYearArray;
         SSVC.termArray=_tempTermArray;
         SSVC.specArray=_tempSpecArray;

        }
     
     if ([segue.identifier isEqualToString:@"SettingsToTeacher"]) {
         SettingsTeacherViewController *STVC = (SettingsTeacherViewController *)segue.destinationViewController;
         STVC.teacher = _userData;
         STVC.departmentArray=_tempDepaArray;
         STVC.subjectArray=_tempInstArray;
     
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
    NSURL *url = [NSURL URLWithString:@"http://www.bluetoothtestniemiec.w8w.pl"];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"loadTeacherSettings" forKey:@"TYPE"];
    [request setDelegate:self];
    [request startAsynchronous];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Updating...";
    self.navigationItem.hidesBackButton = YES;
}

- (IBAction)backPush:(id)sender {
    [[self navigationController]popToRootViewControllerAnimated:YES];
    
   // [self dismissViewControllerAnimated:YES completion:nil];
}
@end
