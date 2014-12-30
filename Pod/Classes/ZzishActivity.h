//
//  ZZActivity.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZObject.h"
#import "ZzishAction.h"
@class ZzishUser;

@interface ZzishActivity : ZZObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* groupCode;
@property (strong, nonatomic) ZzishUser* user;

/*!
 * @discussion Start the activity
 */
- (void)start;

/*!
 * @discussion Stop the activity
 */
- (void)stop;

/*!
 * @discussion Cancel the activity
 */
- (void)cancel;

/*!
 * @discussion Create an action for this activity
 * @param name The name of the action
 */
- (ZzishAction *)createAction:(NSString *)name;

/*!
 * @discussion Returns the actor portion of a tincan statement
 */
- (NSDictionary *)tincan;

@end
