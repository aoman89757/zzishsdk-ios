//
//  ZZActivity.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZZActivity.h"
#import "ZZUser.h"
#import "ZZTincanService.h"

@implementation ZZActivity

- (void)start {
    [self startWithBlock:nil];
}

- (void)startWithBlock: (void (^) (NSDictionary *response)) block {
    [ZZTincanService sendMessage:self.user withActivivity:self forVerb:@"http://activitystrea.ms/schema/1.0/start" withAction:nil withBlock:block];
}

- (void)stop {
    [self stopWithBlock:nil];
}

- (void)stopWithBlock: (void (^) (NSDictionary *response)) block {
    [ZZTincanService sendMessage:self.user withActivivity:self forVerb:@"http://activitystrea.ms/schema/1.0/complete" withAction:nil withBlock:block];
}

- (void)cancel {
    [self cancelWithBlock:nil];
}

- (void)cancelWithBlock: (void (^) (NSDictionary *response)) block {
    [ZZTincanService sendMessage:self.user withActivivity:self forVerb:@"http://activitystrea.ms/schema/1.0/cancel" withAction:nil withBlock:block];
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
