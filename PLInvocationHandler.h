//
//  PLInvocationHandler.h
//  fcgi_objc
//
//  Created by ampatspell on 8/30/08.
//  Copyright 2008 ampatspell. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <fcgiapp.h>

@interface PLInvocationHandler : NSObject {
	@private
	int invocationNumber;
}
@property(readwrite) int invocationNumber;

- (PLInvocationHandler *)init;

- (void)handleInputStream:(FCGX_Stream *)inputStream 
			 outputStream:(FCGX_Stream *)outputStream 
			  errorStream:(FCGX_Stream *)errorStream 
			   paramArray:(FCGX_ParamArray)params;

- (int)incrementInvocationNumber;

@end
