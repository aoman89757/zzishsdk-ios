//
//  ZZService.m
//  Pods
//
//  Created by Samir Seetal on 27/11/2014.
//
//

#import "ZZService.h"
#import "Reachability.h"
#import "sqlite3.h"

@implementation ZZService

static sqlite3 *database;

+ (NSString* ) databasePath {
    NSString *docsDir;
    NSArray *dirPaths;
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    return [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"ZZISHDB"]];
}

+ (const char*) databasename {
    return [[self databasePath] UTF8String];
}

+ (void)open {
    if (sqlite3_open([self databasename], &database) != SQLITE_OK) {
        NSLog(@"Failed to open database! %s", sqlite3_errmsg(database));
    }
    NSLog(@"YES");
}

+ (BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}

@end
