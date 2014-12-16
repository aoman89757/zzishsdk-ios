//
//  ZZDataService.h
//  Pods
//
//  Created by Samir Seetal on 16/12/2014.
//
//

#import <Foundation/Foundation.h>
#import "ZZObject.h"
#import "FileService.h"

@interface ZZDataService : FileService

+ (void)save:(ZZObject *)model;

+ (ZZObject *)get:(NSString *)uuid;

@end
