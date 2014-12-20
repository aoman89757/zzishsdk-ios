//
//  ZZActivity.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZZActivity.h"
#import "ZZUser.h"
#import "Zzish.h"

@implementation ZZActivity

- (void)start {
    [Zzish sendMessage:self.user withActivivity:self forVerb:@"http://activitystrea.ms/schema/1.0/start" withAction:nil];
}

- (void)stop {
    [Zzish sendMessage:self.user withActivivity:self forVerb:@"http://activitystrea.ms/schema/1.0/complete" withAction:nil];
}

- (void)cancel {
    [Zzish sendMessage:self.user withActivivity:self forVerb:@"http://activitystrea.ms/schema/1.0/cancel" withAction:nil];
}

- (ZZAction *)createAction:(NSString *)name {
    ZZAction* action = [[ZZAction alloc] init];
    action.name = name;
    action.uuid = [[NSUUID UUID] UUIDString];
    action.activity = self;
    return action;
}

- (NSDictionary *)tincan {
    NSMutableDictionary *activity = [NSMutableDictionary new];
    if (self.name) {
        NSMutableDictionary *activityDefinition = [NSMutableDictionary new];
        activityDefinition[@"type"] = self.name;
        activity[@"definition"] = activityDefinition;
    }
    
    if ([self.attributes count]>0) {
        NSMutableDictionary *activityState = [NSMutableDictionary new];
        activityState[@"attributes" ] = self.attributes;
        activity[@"state"] = activityState;
    }
    return activity;
}

@end
