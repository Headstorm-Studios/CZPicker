//
//  HSExtendNSLogFunctionality.m
//  ExtendNSLog
//
//  Created by Emily Priddy on 1/26/16.
//  Copyright © 2016 Headstorm Studios. All rights reserved.
//

#import "HSExtendNSLogFunctionality.h"

@implementation HSExtendNSLogFunctionality

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...)
{
    // Type to hold information about variable arguments.
    va_list ap;

    // Initialize a variable argument list.
    va_start(ap, format);

    // NSLog only adds a newline to the end of the NSLog format if
    // one is not already there.
    // Here we are utilizing this feature of NSLog().
    if (![format hasSuffix:@"\n"])
    {
        format = [format stringByAppendingString:@"\n"];
    }

    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];

    // End using variable argument list.
    va_end(ap);

    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    fprintf(stderr, "%s (%s:%d) %s",
            functionName, [fileName UTF8String],
            lineNumber, [body UTF8String]);
}

@end
