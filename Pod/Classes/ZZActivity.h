//
//  ZZActivity.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZObject.h"
#import "ZZAction.h"
@class ZZUser;

@interface ZZActivity : ZZObject

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) ZZUser* user;

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
- (ZZAction *)createAction:(NSString *)name;

/*!
 * @discussion Returns the actor portion of a tincan statement
 */
- (NSDictionary *)tincan;

@end
