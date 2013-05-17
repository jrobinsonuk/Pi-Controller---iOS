//
//  PiAppDelegate.h
//  Pi Controller
//
//  Created by James Robinson on 08/11/2012.
//  Copyright (c) 2012 GTX World. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kSettingIP @"ip_address"


@class PiRadioViewController, PiSettingsViewController;

@interface PiAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) PiRadioViewController *radioController;
@property (strong, nonatomic) PiSettingsViewController *settingsController;

@end
