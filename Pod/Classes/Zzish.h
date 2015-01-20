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

/*!
 * @discussion initializes the Zzish SDK
 * @param apiKey The API Key received from creating an app on the Zzish developer console
 */
+ (void)startWithApplicationId:(NSString *)apiKey;

/*!
 * @discussion initializes the Zzish SDK
 * @param apiKey The API Key received from creating an app on the Zzish developer console
 * @param block A block to process the response from initialising
 */
+ (void)startWithApplicationId:(NSString *)apiKey withBlock: (void (^) (NSDictionary *response)) block;

/*!
 * @discussion Creates a ZZUser object
 * @param user A unique userId (e.g. from another login system)
 */
+ (ZZUser *)user:(NSString *)user;

/*!
 * @discussion Saves a ZZUser object
 * @param user The ZZUser to save
 */
+ (void)saveUser:(ZZUser*)user;

/*!
 * @discussion Saves a ZZUser object
 * @param user The ZZUser to save
 * @param block the block to process the response.
 */
+ (void)saveUser:(ZZUser*)user withBlock: (void (^) (NSDictionary *response)) block;



/*!
 * @discussion Returns true if it can connect to internet
 */
+ (BOOL)connected;

@end
