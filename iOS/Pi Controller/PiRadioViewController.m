//
//  PiRadioViewController.m
//  Pi Controller
//
//  Created by James Robinson on 08/11/2012.
//  Copyright (c) 2012 GTX World. All rights reserved.
//

#import "PiRadioViewController.h"


@interface PiRadioViewController ()

@end

@implementation PiRadioViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedString(@"Radio", @"Radio");
        self.tabBarItem.image = [UIImage imageNamed:@"radio"];
        
        _connection = nil;
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        volumeSlider.transform = CGAffineTransformRotate(volumeSlider.transform, -M_PI_2);
        
        CGRect fr = volumeSlider.frame;
        fr.origin = CGPointMake(self.view.frame.size.width - 34.0, (self.view.frame.size.height - fr.size.height)/2.0);
        volumeSlider.frame = fr;
    }
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
    
    [nowPlayingLabel release];
}





#pragma mark - Actions
-(IBAction)selectStation:(id)sender {
    UIButton *button = sender;
    
    NSString *query = [NSString stringWithFormat:@"station&value=%d", button.tag - 100];
    [self _startConnectionWithQuery:query];
    
    
    stopButton.tag = 1;
    [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
}

-(IBAction)toggleRadio:(id)sender {
    UIButton *button = sender;
    
    NSString *query = @"";
    if (button.tag == 0) {
        // Start
        query = @"start";
        
        [button setTitle:@"Stop" forState:UIControlStateNormal];
        button.tag = 1;
    } else {
        // stop
        query = @"stop";
        
        [button setTitle:@"Start" forState:UIControlStateNormal];
        button.tag = 0;
    }

    [self _startConnectionWithQuery:query];
}


-(IBAction)setVolume:(id)sender {
    if (volumeSlider != sender) return;
    
    double volume = floorf(volumeSlider.value);//10 * floorf(volumeSlider.value/10 + 0.5);
    volumeLabel.text = [NSString stringWithFormat:@"%.0f%%", volume];

    if (!volumeSlider.isTracking) {
        [volumeSlider setValue:volume animated:true];
    
        NSString *query = [NSString stringWithFormat:@"volume&value=%.0f", volume];
        [self _startConnectionWithQuery:query];
    }
}

-(IBAction)openShazam:(id)sender {
    NSString *ipad = @"";
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) ipad = @"ipad";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"shazam%@://", ipad]]];
}


bool gettingCurrentDetails = false;
-(void)getCurrentValues {
    gettingCurrentDetails = true;
    
    NSString *query = @"current_details";
    [self _startConnectionWithQuery:query];
}




-(void)_startConnectionWithQuery:(NSString *)query {
    if (_connection) {
//        [_connection cancel];
        //[_connection release];
    }
    
    _connection = [[PiURLConnection alloc] initWithQuery:[@"radio.php?action=" stringByAppendingString:query] delegate:self];
}






#pragma mark - Connection Delegate
-(void)piconnectionFailed:(PiURLConnection *)connection {
    nowPlayingLabel.text = @"Error";
    
    [connection release];
    gettingCurrentDetails = false;
}

-(void)piconnection:(PiURLConnection *)connection didFinishWithString:(NSString *)data {
    if (![data isEqualToString:@"failed"]) {
        // We had success
        if (gettingCurrentDetails) {
            // getting current details
            NSArray *chunks = [data componentsSeparatedByString:@" {} "];
            nowPlayingLabel.text = [chunks objectAtIndex:0];
            
            if (nowPlayingLabel.text.length > 0) {
                stopButton.tag = 1;
                [stopButton setTitle:@"Stop" forState:UIControlStateNormal];
            }
            
            NSString *volume = [[chunks objectAtIndex:1] stringByReplacingOccurrencesOfString:@"volume: " withString:@""];
            volumeLabel.text = volume;
            volumeSlider.value = [volume floatValue];
        } else {
            // result of change in station
            NSArray *chunks = [data componentsSeparatedByString:@"[playing]"];
            NSString *station = [chunks objectAtIndex:0];
            chunks = [station componentsSeparatedByString:@"[paused]"];
            if (chunks.count > 1) station = [[chunks objectAtIndex:0] stringByAppendingString:@" [paused]"];
            
            if ([station rangeOfString:@"repeat:"].location != NSNotFound) {
                station = @"";
            }
            nowPlayingLabel.text = station;
        }
    }
    
    
    [connection release];
    gettingCurrentDetails = false;
}


@end
