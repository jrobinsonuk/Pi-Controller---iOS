//
//  PiRadioViewController.h
//  Pi Controller
//
//  Created by James Robinson on 08/11/2012.
//  Copyright (c) 2012 GTX World. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PiURLConnection.h"


@interface PiRadioViewController : UIViewController <PiURLConnectionDelegate> {
    IBOutlet UILabel *nowPlayingLabel;
    IBOutlet UIButton *stopButton;
    IBOutlet UILabel *volumeLabel;
    IBOutlet UISlider *volumeSlider;
    
    PiURLConnection *_connection;
}

-(IBAction)selectStation:(id)sender;
-(IBAction)toggleRadio:(id)sender;
-(IBAction)setVolume:(id)sender;
-(IBAction)openShazam:(id)sender;

-(void)getCurrentValues;

@end
