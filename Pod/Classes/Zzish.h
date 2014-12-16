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

@interface ZZService : NSObject

+ (void)initWithApplicationId:(NSString *)applicationId;
+ (ZZUser *)user:(NSString *)user;
+ (void)sendMessage:(ZZUser *)user withActivivity:(ZZActivity *)activity forVerb:(NSString *)verbName withAction:(ZZAction*)action;


@end
