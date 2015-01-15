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

@interface Zzish()

@end

@implementation Zzish

static Zzish *instance;
static dispatch_once_t predicate = 0;

+ (void)startWithApplicationId:(NSString *)applicationId withBlock: (void (^) (NSDictionary *response)) block  {
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
    NSMutableDictionary *result = [NSMutableDictionary new];
    result[@"status"] = [NSNumber numberWithInt:200];
    result[@"message"] = @"";
    block(result);
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

+ (void)sendMessage:(ZZUser *)userModel withActivivity:(ZZActivity *)activityModel forVerb:(NSString *)verbName withAction:(ZZAction*)actionModel  withBlock: (void (^) (NSDictionary *response)) block {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[@"id"] = activityModel.uuid;
    dictionary[@"actor"] = [userModel tincan];
    
    NSMutableDictionary *verb = [NSMutableDictionary new];
    verb[@"id"] = verbName;
    dictionary[@"verb"] = verb;
    
    dictionary[@"object"] = [activityModel tincan];

    if (actionModel) {
        dictionary[@"actions"] = @[[actionModel tincan]];
    }
    NSMutableDictionary *context = [NSMutableDictionary new];
    NSMutableDictionary *extensions = [NSMutableDictionary new];
    if (activityModel.groupCode) {
        extensions[@"http://www.zzish.com/context/extension/groupCode"]=activityModel.groupCode;
    }
    if ([ZZPropertyService deviceId]) {
        extensions[@"http://www.zzish.com/context/extension/deviceId"]=[ZZPropertyService deviceId];
    }
    if ([ZZPropertyService sessionId]) {
        extensions[@"http://www.zzish.com/context/extension/sessionId"]=[ZZPropertyService sessionId];
    }
    context[@"extensions"] = extensions;
    dictionary[@"context"] = context;

    [self uploadDictionary:dictionary toEndPoint:@"statements" withBlock:block];
}

+ (void)saveUser:(ZZUser*)user withBlock: (void (^) (NSDictionary *response)) block {
    NSMutableDictionary *dictionary = [NSMutableDictionary new];
    dictionary[@"name"] = user.name;
    dictionary[@"uuid"] = user.uuid;
    [Zzish uploadDictionary:dictionary toEndPoint:@"profiles" withBlock:block];
}

+ (void)uploadDictionary:(NSDictionary *)dictionary toEndPoint:(NSString *)endpoint withBlock: (void (^) (NSDictionary *response)) block {
    NSMutableDictionary* toPost = [NSMutableDictionary new];
    toPost[ENDPOINT_PARAM] = endpoint;

    
    NSError *error;
    NSData *jsonOutputData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                             options:NSJSONWritingPrettyPrinted
                                                               error:&error];
    
    
    //set json string to body data
    NSString *jsonOutputString = [[NSString alloc] initWithData:jsonOutputData encoding:NSUTF8StringEncoding];
    toPost[DATA_PARAM] = jsonOutputString;

    if ([Zzish connected]) {
        NSDictionary *firstToSend = [ZZJsonService saveRequest:toPost andReturn:YES];
        NSLog(@"Connected Sending %@",firstToSend);
        //connected so we can send message
        ZZWebService* wservice = [[ZZWebService alloc] init];
        [wservice upload:firstToSend withBlock:block];
    }
    else {
        [ZZJsonService saveRequest:toPost andReturn:NO];
    }
}
+ (BOOL)connected {
    return YES;
}

@end
