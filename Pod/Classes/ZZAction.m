//
//  ZZAction.m
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import "ZZAction.h"
#import "ZZActivity.h"
#import "ZZService.h"

@interface ZZAction()

@property (strong,nonatomic) NSNumber* score;
@property (strong,nonatomic) NSNumber* duration;
@property (nonatomic,nonatomic) NSNumber* correct;
@property (nonatomic,nonatomic) NSNumber* attempts;

@end

@implementation ZZAction

- (ZZAction *)score:(float)score {
    self.score = [NSNumber numberWithFloat:score];
    return self;
}

- (ZZAction *)duration:(long)duration {
    self.duration = [NSNumber numberWithLong:duration];
    return self;
}

- (ZZAction *)correct:(BOOL)correct {
    self.correct = [NSNumber numberWithBool:correct];
    return self;
}

- (ZZAction *)attempts:(int)attempts {
    self.correct = [NSNumber numberWithInt:attempts];
    return self;
}

- (void)save {
    [ZZService sendMessage:self.activity.user withActivivity:self.activity forVerb:@"http://activitystrea.ms/schema/1.0/start" withAction:self];
}

- (NSDictionary *)tincan {
    NSMutableDictionary *action = [NSMutableDictionary new];
    if (self.score) action[@"score"] = self.score;
    if (self.duration) action[@"duration"] = self.duration;
    if (self.correct) action[@"correct"] = [NSString stringWithFormat:@"%@",self.correct];
    if (self.attempts) action[@"attempts"] = [NSString stringWithFormat:@"%@",self.attempts];
    
    NSMutableDictionary *actionDefinition = [NSMutableDictionary new];
    actionDefinition[@"name"] = self.name;
    action[@"definition"] = actionDefinition;
    action[@"uuid"] = self.uuid;
    
    if ([self.attributes count]>0) {
        NSMutableDictionary *actionState = [NSMutableDictionary new];
        actionState[@"attributes" ]= self.attributes;
        action[@"state"] = actionState;
    }
    return action;
}


@end
