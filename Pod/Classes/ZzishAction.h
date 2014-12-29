//
//  ZZAction.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZObject.h"
@class ZzishActivity;

@interface ZzishAction : ZZObject

@property (strong,nonatomic) ZzishActivity* activity;
@property (strong,nonatomic) NSString* name;
@property (strong,nonatomic) NSString* response;

/// A score assigned to this action, this will be incorporated into the total score for the activity.
@property (nonatomic) float score;

/// The duration it took for the user to complete the action. Measured in milliseconds.
@property (nonatomic) long duration;

/// Whether this action was correct.
@property (nonatomic) BOOL correct;

/// The number of tries the user had.
@property (nonatomic) int attempts;


/*!
 * @discussion Save the activity
 */
- (void)save;

/*!
 * @discussion Set the score of the action
 * @param score a float value representing the score
 */
- (ZzishAction *)score:(float)score;

/*!
 * @discussion Set the duration of the action
 * @param duration duration in milliseconds
 */
- (ZzishAction *)duration:(long)duration;

/*!
 * @discussion Set whether the answer is correct
 * @param duration duration in milliseconds
 */
- (ZzishAction *)correct:(BOOL)correct;

/*!
 * @discussion Set the number of attempts fot this action
 * @param attempts the number of attempts for this action
 */
- (ZzishAction *)attempts:(int)attempts;

/*!
 * @discussion Returns the actor portion of a tincan statement
 */
- (NSDictionary *)tincan;

@end
