//
//  PiURLConnection.h
//  Pi Controller
//
//  Created by James Robinson on 08/11/2012.
//  Copyright (c) 2012 GTX World. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PiURLConnection;

@protocol PiURLConnectionDelegate <NSObject>
-(void)piconnectionFailed:(PiURLConnection *)connection;
-(void)piconnection:(PiURLConnection *)connection didFinishWithString:(NSString *)data;
@end


@interface PiURLConnection : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate> {
    NSMutableData *_receivedData;
    NSURLConnection *_connection;
}

@property (nonatomic, assign) id<PiURLConnectionDelegate> delegate;

+(NSString *)baseURL;
-(id)initWithQuery:(NSString *)query delegate:(id<PiURLConnectionDelegate>)delegate;

-(void)cancel;

@end
