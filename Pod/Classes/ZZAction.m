//
//  ZZAction.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZZAction.h"
#import "ZZActivity.h"
#import "ZZTincanService.h"

@interface ZZAction()

@property (strong,nonatomic) NSNumber* scoreObject;
@property (strong,nonatomic) NSNumber* durationObject;
@property (nonatomic,nonatomic) NSNumber* correctObject;
@property (nonatomic,nonatomic) NSNumber* attemptsObject;
@property (nonatomic,nonatomic) NSNumber* proficiencyObject;

@end

@implementation ZZAction

- (ZZAction *)score:(float)score {
    self.scoreObject = [NSNumber numberWithFloat:score];
    return self;
}

- (ZZAction *)duration:(long)duration {
    self.durationObject = [NSNumber numberWithLong:duration];
    return self;
}

- (ZZAction *)correct:(BOOL)correct {
    self.correctObject = [NSNumber numberWithBool:correct];
    return self;
}

- (ZZAction *)attempts:(int)attempts {
    self.attemptsObject = [NSNumber numberWithInt:attempts];
    return self;
}

- (ZZAction *)response:(NSString*)response {
    self.response = response;
    return self;
}

- (ZZAction *)proficiency:(int)proficiency {
    self.proficiencyObject = [NSNumber numberWithInt:proficiency];
    return self;
}

- (void)setScore:(float)score {
    [self score:score];
}

- (void)setDuration:(long)duration {
    [self duration:duration];
}

- (void)setAttempts:(int)attempts {
    [self attempts:attempts];
}

- (void)setCorrect:(BOOL)correct {
    [self correct:correct];
}

- (void)setProficiency:(int)proficiency {
    [self proficiency:proficiency];
}

- (float)score {
    return [self.scoreObject floatValue];
}

- (long)duration {
    return [self.durationObject longLongValue];
}

- (int)attempts {
    return [self.attemptsObject intValue];
}

- (BOOL)correct {
    return [self.correctObject boolValue];
}

- (int)proficiency {
    return [self.proficiencyObject intValue];
}


- (void)save {
    [self saveWithBlock:nil];
}

- (void)saveWithBlock: (void (^) (NSDictionary *response)) block {
    [ZZTincanService sendMessage:self.activity.user withActivivity:self.activity forVerb:@"http://activitystrea.ms/schema/1.0/start" withAction:self withBlock:block];
}

- (NSDictionary *)tincan {
    NSMutableDictionary *action = [NSMutableDictionary new];
    if (self.scoreObject) action[@"score"] = self.scoreObject;
    if (self.durationObject) action[@"duration"] = self.durationObject;
    if (self.correctObject) {
        int x = [self.correctObject intValue];
        action[@"correct"] = x==1?@"true":@"false";
    }
    if (self.attemptsObject) action[@"attempts"] = self.attemptsObject;
    if (self.response) action[@"response"] = self.response;
    
    NSMutableDictionary *actionDefinition = [NSMutableDictionary new];
    actionDefinition[@"type"] = self.name;
    action[@"definition"] = actionDefinition;
    action[@"uuid"] = self.uuid;
    BOOL haveState = false;
    NSMutableDictionary *actionState = [NSMutableDictionary new];
    if ([self.attributes count]>0) {
        haveState = true;
        actionState[@"attributes" ]= self.attributes;
    }
    if(self.proficiencyObject) {
        haveState = true;
        actionState[@"proficiency"] = self.proficiencyObject;
    }
    if (haveState) {
        action[@"state"] = actionState;
    }
    return action;
}


@end
