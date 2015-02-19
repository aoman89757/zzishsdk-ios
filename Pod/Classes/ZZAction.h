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

/*!
 * @discussion The activity that created the action
 */
@property (strong,nonatomic) ZZActivity* activity;
/*!
 * @discussion The name of the action (e.g question)
 */
@property (strong,nonatomic) NSString* name;
/*!
 * @discussion The response for the aciton
 */
@property (strong,nonatomic) NSString* response;

/*!
 * @discussion A score assigned to this action, this will be incorporated into the total score for the activity.
 */
@property (nonatomic) float score;

/*!
 * @discussion The duration it took for the user to complete the action. Measured in milliseconds.
 */
@property (nonatomic) long duration;

/*!
 * @discussion Whether this action was correct.
 */
@property (nonatomic) BOOL correct;

/*!
 * @discussion The number of attempts the user had.
 */
@property (nonatomic) int attempts;

/*!
 * @discussion The proficiency for this action
 */
@property (nonatomic) int proficiency;


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
 * @discussion Set the proficiency for this action
 * @param the proficiency for the action
 */
- (ZZAction *)proficiency:(int)proficiency;


/*!
 * @discussion Returns the actor portion of a tincan statement
 */
- (NSDictionary *)tincan;

@end
