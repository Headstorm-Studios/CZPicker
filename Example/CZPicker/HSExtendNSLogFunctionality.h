//
//  HSExtendNSLogFunctionality.h
//  ExtendNSLog
//
//  Created by Emily Priddy on 1/26/16.
//  Copyright © 2016 Headstorm Studios. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG
#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(x...)
#endif

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);

@interface HSExtendNSLogFunctionality : NSObject

@end
