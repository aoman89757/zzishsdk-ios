//
//  ZZService.m
//  Pods
//
//  Created by Samir Seetal on 27/11/2014.
//
//

#import "Zzish.h"
#import "ZZPropertyService.h"
#import "ZZWebService.h"
#import "ZZJsonService.h"
#import "ZZTincanService.h"

@interface Zzish()

@end

@implementation Zzish

static Zzish *instance;
static dispatch_once_t predicate = 0;

+ (void)startWithApplicationId:(NSString *)applicationId {
    [Zzish startWithApplicationId:applicationId withBlock:nil];
}

+ (void)startWithApplicationId:(NSString *)applicationId withBlock: (void (^) (NSDictionary *response)) block  {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if ([applicationId isEqualToString:@"YOUR API KEY"]) {
        result[@"status"] = [NSNumber numberWithInt:400];
        result[@"message"] = @"You must set the API Key";
    }
    else {
        if (!instance) {
            predicate = 0;
            dispatch_once(&predicate, ^{
                instance = [[self alloc] init];
                
                if (![ZZPropertyService deviceId]) {
                    [ZZPropertyService setDeviceId:[[NSUUID UUID] UUIDString]];
                }
                [ZZPropertyService setAppToken:applicationId];
            });
        }
        result[@"status"] = [NSNumber numberWithInt:200];
        result[@"message"] = @"";
    }
    if (block) {
        block(result);
    }
}


+ (void)validateClassCode:(NSString *)code {
    [Zzish validateClassCode:code withBlock:nil];
}

+ (void)validateClassCode:(NSString *)code withBlock: (void (^) (NSDictionary *response)) block  {
    NSMutableDictionary *result = [NSMutableDictionary new];
    if ([code length]>1) {
        int lastChar = [[code substringWithRange:NSMakeRange([code length]-1, 1)] intValue];
        int total = 0;
        for (int counter=0;counter<[code length]-1;counter++) {
            total+= [code characterAtIndex:counter];
        }
        total = total%10;
        if (lastChar==total) {
            if (block) {
                [ZZTincanService validateClassCode:code withBlock:block];
            }
        }
        else {
            if (block) {
                result[@"status"] = [NSNumber numberWithInt:400];
                result[@"message"] = @"Invalid Class Code";
                block(result);
            }            
        }
    }
    else {
        if (block) {
            result[@"status"] = [NSNumber numberWithInt:400];
            result[@"message"] = @"Invalid Class Code";
            block(result);
        }        
    }
}


+ (ZZUser *)user:(NSString *)uuid {
    if (!uuid) uuid = [[NSUUID UUID] UUIDString];
    NSString* currentUserId = [ZZPropertyService userId];
    if (!currentUserId || ![uuid isEqualToString:currentUserId]) {
        //userId is new or changed
        [ZZPropertyService setSessionId:[[NSUUID UUID] UUIDString]];
    }
    [ZZPropertyService setUserId:uuid];
    ZZUser* user = [[ZZUser alloc] init];
    user.uuid = uuid;
    return user;
}

+ (void)saveUser:(ZZUser*)user {
    [Zzish saveUser:user withBlock:nil];
}

+ (void)saveUser:(ZZUser*)user withBlock: (void (^) (NSDictionary *response)) block {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[@"name"] = user.name;
    dictionary[@"uuid"] = user.uuid;
    [ZZTincanService uploadDictionary:dictionary toEndPoint:@"profiles" withBlock:block];
}


+ (BOOL)connected {
    return YES;
}

@end
