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
    else if (pickerView==_subject)
    {
        return 5;
    }
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
        self.selectSebject= [self.subjectArray objectAtIndex:row];
        
        
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

- (IBAction)SaveChange:(id)sender {
}
@end
