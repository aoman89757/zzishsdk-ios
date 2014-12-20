//
//  ZZUser.m
//  Pods
//
//  Created by Samir Seetal on 04/12/2014.
//
//

#import "ZZUser.h"
#import "ZzishSDK.h"
#import "ZZPropertyService.h"

@implementation ZZUser

- (ZZActivity *) createActivity:(NSString *)name {
    ZZActivity* activity = [[ZZActivity alloc] init];
    activity.uuid = [[NSUUID UUID] UUIDString];
    activity.name = name;
    activity.user = self;
    return activity;
}

- (NSDictionary *)tincan {
    NSMutableDictionary *actor = [NSMutableDictionary new];
    if (self.name) {
        actor[@"name"] = self.name;
    }
    
    NSMutableDictionary *account = [NSMutableDictionary new];
    account[@"homePage"] = [NSString stringWithFormat:@"http://www.zzish.com/%@",[ZZPropertyService appToken]];
    account[@"name"] = self.uuid;
    actor[@"account"] = account;
    return actor;
}

@end
