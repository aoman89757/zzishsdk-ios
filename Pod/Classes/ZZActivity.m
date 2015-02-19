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

@interface ZZActivity()

@property (nonatomic,nonatomic) NSNumber* proficiencyObject;

@end

@implementation ZZActivity


- (ZZActivity *)proficiency:(int)proficiency {
    self.proficiencyObject = [NSNumber numberWithInt:proficiency];
    return self;
}

- (void)setProficiency:(int)proficiency {
    [self proficiency:proficiency];
}

- (int)proficiency {
    return [self.proficiencyObject intValue];
}
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
    BOOL haveState = false;
    NSMutableDictionary *activityState = [NSMutableDictionary new];
    if ([self.attributes count]>0) {
        haveState = true;
        activityState[@"attributes" ]= self.attributes;
    }
    if(self.proficiencyObject) {
        haveState = true;
        activityState[@"proficiency"] = self.proficiencyObject;
    }
    if (haveState) {
        activity[@"state"] = activityState;
    }
    return activity;
}

@end
