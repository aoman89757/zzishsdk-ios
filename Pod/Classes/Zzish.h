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

@protocol ZZCallbackDelegate <NSObject>
@required
- (void) processZzishResponse:(int)status andMessage:(NSString *)message;
@end

@interface Zzish : NSObject<ZZWebCallbackDelegate>
{
    id <ZZCallbackDelegate> delegate;
}

@property (retain) id delegate;

+ (void)startWithApplicationId:(NSString *)applicationId;
+ (ZZUser *)user:(NSString *)user;
+ (void)sendMessage:(ZZUser *)user withActivivity:(ZZActivity *)activity forVerb:(NSString *)verbName withAction:(ZZAction*)action;
+ (void)delegate:(id)delegate;


@end
