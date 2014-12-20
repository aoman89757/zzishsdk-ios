//
//  ZZJsonService.m
//  Pods
//
//  Created by Samir Seetal on 17/12/2014.
//
//

#import "ZZJsonService.h"

#define JSON_FILE_NAME @"ZZISHJSON"
#define JSON_DATA @"JSON_DATA"

@implementation ZZJsonService

+ (NSString *)fileName {
    return JSON_FILE_NAME;
}

+ (NSString *)next {
    return [self saveRequest:nil andReturn:YES];
}

+ (NSString *)saveRequest:(NSString *)json andReturn:(BOOL)returnFirst {
    NSMutableArray* data = [NSMutableArray new];
    [data addObjectsFromArray:[self data:JSON_DATA]];
    if (json) {
        [data addObject:json];
    }
    if (returnFirst) {
        if ([data count]>0) {
            NSString* first = (NSString *)data[0];
            [data removeObjectAtIndex:0];
            return first;
        }
    }
    if (data) {
        [self setData:JSON_DATA withValue:data];
    }
    return nil;

}

+ (void)buffer:(NSString *)json {
    NSMutableArray* data = [self data:JSON_DATA];
    if (!data) {
        data = [NSMutableArray new];
    }
    [data insertObject:json atIndex:0];
    [self setData:JSON_DATA withValue:data];
}

@end
