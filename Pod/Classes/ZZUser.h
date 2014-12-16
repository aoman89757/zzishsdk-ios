//
//  ZZUser.h
//  Pods
//
//  Created by Samir Seetal on 04/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZObject.h"
#import "ZZActivity.h"

@interface ZZUser : ZZObject

@property (strong, nonatomic) NSString* name;

@property (strong, nonatomic) NSString* groupCode;

/*!
 * @discussion Create an activity for this user
 * @param name The name of the activity
 */
- (ZZActivity *) createActivity:(NSString *)name;

/*!
 * @discussion Returns the actor portion of a tincan statement
 */
- (NSDictionary *)tincan;

@end
