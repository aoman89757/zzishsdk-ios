//
//  ZZService.h
//  Pods
//
//  Created by Samir Seetal on 27/11/2014.
//
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface ZZService : JSONModel

+ (BOOL)connected;
+ (void)open;

@end
