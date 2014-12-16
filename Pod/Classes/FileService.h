//
//  FileService.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>

@interface FileService : NSObject

/*!
 * @discussion The File name of the preference file to use to save data
 * @param fileName The NSString* name of the file
 */
+ (NSString *) fileName;

/*!
 * @discussion Returns the value of key
 * @param key The key to be searched for
 * @return the value from preference file
 */
+ (NSString *)data:(NSString *)key;

/*!
 * @discussion Updates a property in file
 * @param key The key (which may or may not exists)
 * @param value The new/updated value
 */
+ (void)setData:(NSString *)key withValue:(NSString*) value;

/*!
 * @discussion Removes a property from file
 * @param key The key to be removed
 */
+ (void)removeDataForKey:(NSString *)key;


@end
