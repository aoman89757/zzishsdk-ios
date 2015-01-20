//
//  ZZTincanService.m
//  Pods
//
//  Created by Samir Seetal on 20/01/2015.
//
//

#import "ZZTincanService.h"
#import "ZZPropertyService.h"
#import "ZZJsonService.h"

@implementation ZZTincanService

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

@end
