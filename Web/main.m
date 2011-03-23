//
//  main.m
//  Web
//
//  Created by Pat Collins on 3/23/11.
//  Copyright 2011 ShowClix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSON.h"
#if FASTCGI
#import <fcgiapp.h>
#import "PLInvocationHandler.h"
#endif

int main (int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
//    NSLog(@"stuff");
//    printf("%s<br>", [@"test22" UTF8String]);
    
    NSDictionary *dict = [[NSProcessInfo processInfo] environment];
    NSLog(@"environment: %@", dict);

    if (getenv("WEB_ENV") != NULL) {
        NSDictionary *webdict = [[NSString stringWithCString:getenv("WEB_ENV") encoding:NSUTF8StringEncoding] JSONValue];
        NSLog(@"web environment: %@", webdict);

        for (NSString *key in webdict) {
            NSString *val = [webdict objectForKey:key];
            printf("%s: %s<br>", [key UTF8String], [[NSString stringWithFormat:@"%@", val] UTF8String]);
        }
    }


#if FASTCGI
	FCGX_Stream *in, *out, *err;
	FCGX_ParamArray envp;
    
	PLInvocationHandler *handler = [[PLInvocationHandler alloc] init];
    
    // insert code here...
	while (FCGX_Accept(&in, &out, &err, &envp) >= 0) {
		[handler handleInputStream:in outputStream:out errorStream:err paramArray:envp];
	}
    
	[handler release];
#endif
    
    [pool drain];
    return 0;
}

