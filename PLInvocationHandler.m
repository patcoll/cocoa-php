//
//  PLInvocationHandler.m
//  fcgi_objc
//
//  Created by ampatspell on 8/30/08.
//  Copyright 2008 ampatspell. All rights reserved.
//

#import "PLInvocationHandler.h"


@implementation PLInvocationHandler
@synthesize invocationNumber;

- (PLInvocationHandler *)init
{
	if(self == [super init]) {
		[self setInvocationNumber:0];
	}
	return self;
}

#pragma mark -

- (void)handleInputStream:(FCGX_Stream *)inputStream 
			 outputStream:(FCGX_Stream *)outputStream 
			  errorStream:(FCGX_Stream *)errorStream
			   paramArray:(FCGX_ParamArray)params;
{
	FCGX_FPrintF(outputStream, "Content-type: text/html\r\n\r\n");
	FCGX_FPrintF(outputStream, "Hello from %i with #%i", getpid(), [self incrementInvocationNumber]);
    FCGX_FPrintF(outputStream, "<br>");

//    NSDictionary *dict = [[NSProcessInfo processInfo] environment];
//    for (NSString *key in dict) {
//        NSString *val = [dict objectForKey:key];
//        FCGX_FPrintF(outputStream, "%s: %s<br>", [key UTF8String], [val UTF8String]);
//    }

    FCGX_FPrintF(outputStream, "sizeof FCGX_ParamArray: %d<br>", sizeof(FCGX_ParamArray));
    
    for (int i=0; i<sizeof(params); i++) {
        FCGX_FPrintF(outputStream, "%s<br>", params[i]);
    }
}

- (int)incrementInvocationNumber
{
	return invocationNumber++;
}

#pragma mark -

- (void)dealloc
{
	[super dealloc];
}

@end
