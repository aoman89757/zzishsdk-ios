//
//  ZZService.m
//  Pods
//
//  Created by Samir Seetal on 27/11/2014.
//
//

#import "ZZService.h"
#import "PropertyService.h"
#import "ZZWebService.h"

@implementation ZZService

+ (void)initWithApplicationId:(NSString *)applicationId {
    if (![PropertyService deviceId]) {
        [PropertyService setDeviceId:[[NSUUID UUID] UUIDString]];
    }
    [PropertyService setAppToken:applicationId];
}

+ (ZZUser *)user:(NSString *)uuid {
    NSString* currentUserId = [PropertyService userId];
    if (!currentUserId || ![uuid isEqualToString:currentUserId]) {
        //userId is new or changed
        [PropertyService setSessionId:[[NSUUID UUID] UUIDString]];
    }
    [PropertyService setUserId:uuid];
    ZZUser* user = [[ZZUser alloc] init];
    user.uuid = uuid;
    return user;
}

+ (void)sendMessage:(ZZUser *)userModel withActivivity:(ZZActivity *)activityModel forVerb:(NSString *)verbName withAction:(ZZAction*)actionModel {
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
    NSError *error;
    NSData *jsonOutputData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                             options:NSJSONWritingPrettyPrinted
                                                               error:&error];

    NSMutableDictionary *context = [NSMutableDictionary new];
    NSMutableDictionary *extensions = [NSMutableDictionary new];
    if (userModel.groupCode) {
        extensions[@"http://www.zzish.com/context/extension/groupCode"]=userModel.groupCode;
    }
    if ([PropertyService deviceId]) {
        extensions[@"http://www.zzish.com/context/extension/deviceId"]=[PropertyService deviceId];
    }
    if ([PropertyService sessionId]) {
        extensions[@"http://www.zzish.com/context/extension/sessionId"]=[PropertyService sessionId];
    }
    context[@"extensions"] = extensions;
    dictionary[@"context"] = context;
    
    //set json string to body data
    NSString *jsonOutputString = [[NSString alloc] initWithData:jsonOutputData encoding:NSUTF8StringEncoding];
    NSLog(@"Sending %@",jsonOutputString);
    [[[ZZWebService alloc] init] upload:@"statements" withJSON:jsonOutputString];
}

@end
