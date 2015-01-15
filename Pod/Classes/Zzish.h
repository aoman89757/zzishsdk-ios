//
//  ZZService.h
//  Pods
//
//  Created by Samir Seetal on 27/11/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZUser.h"
#import "ZZActivity.h"
#import "ZZAction.h"
#import "ZZWebService.h"

@interface Zzish : NSObject

+ (void)startWithApplicationId:(NSString *)applicationId withBlock: (void (^) (NSDictionary *response)) block;
+ (ZZUser *)user:(NSString *)user;
+ (void)saveUser:(ZZUser*)user withBlock: (void (^) (NSDictionary *response)) block;
+ (void)sendMessage:(ZZUser *)user withActivivity:(ZZActivity *)activity forVerb:(NSString *)verbName withAction:(ZZAction*)action withBlock: (void (^) (NSDictionary *response)) block;
+ (BOOL)connected;

@end
