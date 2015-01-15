//
//  ZZUser.m
//  Pods
//
//  Created by Samir Seetal on 04/12/2014.
//
//

#import "ZZUser.h"
#import "ZZPropertyService.h"
#import "Zzish.h"

@implementation ZZUser

/*!
 * @discussion Upload contents to serve
 */
- (void)saveWithBlock: (void (^) (NSDictionary *response)) block {
    [Zzish saveUser:self withBlock:block];
}

+ (ZZUser *) currentUser {
    NSString* currentUserId = [ZZPropertyService userId];
    if (currentUserId) {
        //userId is new or changed
        ZZUser* user = [[ZZUser alloc] init];
        user.uuid = currentUserId;
        return user;
    }
    return nil;
}

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
