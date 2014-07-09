//
//  MainViewController.m
//  BT
//
//  Created by LGBS dev on 7/3/14.
//  Copyright (c) 2014 LGBS. All rights reserved.
//

#import "MainViewController.h"

@implementation ProperViewSegue
- (void)perform {
    [((UIViewController *)self.sourceViewController).navigationController setViewControllers:@[self.destinationViewController]];
}
@end

@interface MainViewController ()

@end

@implementation MainViewController

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
    [self performSegueWithIdentifier:@"MainToLogin" sender:self];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginSucced:(NSDictionary *)dictForMain
{
    _user=dictForMain;
}

/*
 -(void)studentSettingsViewControllerDidBack:(StudentSettingsViewController *)controller
 {
 [self dismissViewControllerAnimated:YES completion:nil];
 }
 
 
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MainToLogin"]) {
         MainAccessViewController *MAVC = (MainAccessViewController *)segue.destinationViewController;
         MAVC.loginDelegate = self;
         }
    
    
    if ([segue.identifier isEqualToString:@"MainToBTList"]) {
        BTViewControllerTableViewController *BTVCTVC = (BTViewControllerTableViewController *)segue.destinationViewController;
        BTVCTVC.user = _user;
    }
    
    if ([segue.identifier isEqualToString:@"MainToSettings"]) {
        SettingsViewController *SVC = (SettingsViewController*)segue.destinationViewController;
        SVC.userData = _user;
    }
    
}


@end
