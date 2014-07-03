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

@end
