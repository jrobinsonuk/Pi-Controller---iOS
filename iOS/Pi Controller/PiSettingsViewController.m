//
//  PiSettingsViewController.m
//  Pi Controller
//
//  Created by James Robinson on 17/05/2013.
//  Copyright (c) 2013 GTX World. All rights reserved.
//

#import "PiSettingsViewController.h"
#import "PiAppDelegate.h"

@interface PiSettingsViewController ()

@end

@implementation PiSettingsViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Settings", @"Settings");
        self.tabBarItem.image = [UIImage imageNamed:@"settings"];
    }
    return self;
}



#pragma mark - Actions
-(void)loadSettingValues {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    ipField.text = [defaults objectForKey:kSettingIP];
}



#pragma mark - UITextField Delegate
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"nasd");
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"sas");
    if (textField == ipField) {
        // Update IP
        [defaults setObject:ipField.text forKey:kSettingIP];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return true;
}




#pragma mark - View Lifecycle
-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self loadSettingValues];
}

-(void)viewDidAppear:(BOOL)animated {
    //[self getCurrentValues];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [super dealloc];
}




@end
