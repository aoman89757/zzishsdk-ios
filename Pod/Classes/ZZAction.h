//
//  ZZAction.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZObject.h"
@class ZZActivity;

@interface ZZAction : ZZObject

@property (strong,nonatomic) ZZActivity* activity;
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* response;

/*!
 * @discussion Save the activity
 */
- (void)save;

/*!
 * @discussion Set the score of the action
 * @param score a float value representing the score
 */
- (ZZAction *)score:(float)score;

/*!
 * @discussion Set the duration of the action
 * @param duration duration in milliseconds
 */
- (ZZAction *)duration:(long)duration;

/*!
 * @discussion Set whether the answer is correct
 * @param duration duration in milliseconds
 */
- (ZZAction *)correct:(BOOL)correct;

/*!
 * @discussion Set the number of attempts fot this action
 * @param attempts the number of attempts for this action
 */
- (ZZAction *)attempts:(int)attempts;

/*!
 * @discussion Returns the actor portion of a tincan statement
 */
- (NSDictionary *)tincan;

@end
