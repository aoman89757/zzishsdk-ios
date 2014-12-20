//
//  ZZJsonService.h
//  Pods
//
//  Created by Samir Seetal on 17/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZFileService.h"

@interface ZZJsonService : ZZFileService

/*!
 * @discussion Returns the next value to submit to web service. nil if there is nothi
 * @return returns nil if nothing exists or a string in dictionary
 */
+ (NSString *)next;

/*!
 * @discussion Saves a JSON string at the end of the list
 * @param json the JSON string to save
 */
+ (NSString *)saveRequest:(NSString *)json andReturn:(BOOL)returnFirst;

/*!
 * @discussion Inserts a JSON string at the begnning
 * @param json the JSON string to save
 */
+ (void)buffer:(NSString *)json;


@end
