//
//  PiURLConnection.m
//  Pi Controller
//
//  Created by James Robinson on 08/11/2012.
//  Copyright (c) 2012 GTX World. All rights reserved.
//

#import "PiURLConnection.h"
#import "PiAppDelegate.h"

@implementation PiURLConnection
@synthesize delegate = _delegate;

+(NSString *)baseURL {
    NSString *url = [[NSUserDefaults standardUserDefaults] objectForKey:kSettingIP];
    url = [url stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    return [NSString stringWithFormat:@"http://%@", url];
}

-(id)initWithQuery:(NSString *)query delegate:(id<PiURLConnectionDelegate>)delegate {
    self = [self init];
    if (self) {
        _delegate = delegate;
        _receivedData = [[NSMutableData alloc] init];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [PiURLConnection baseURL], query]];
        
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];


        [request release];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:true];
        
    }
    return self;
}



-(void)cancel {
    [_connection release];
    _connection = nil;
}



#pragma mark - Connection Delegate
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_receivedData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [_receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.delegate piconnectionFailed:self];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [alert show];
    [alert release];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:false];
    
    [connection release];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *data = [[[NSString alloc] initWithData:_receivedData encoding:NSUTF8StringEncoding] autorelease];
    [self.delegate piconnection:self didFinishWithString:data];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:false];
    
    [connection release];
}

@end
