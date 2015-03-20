//
//  ZZTincanService.h
//  Pods
//
//  Created by Samir Seetal on 20/01/2015.
//
//

#import <Foundation/Foundation.h>
#import "ZzishSDK.h"

@interface ZZTincanService : NSObject

+ (void)validateClassCode:(NSString *)code withBlock: (void (^) (NSDictionary *response)) block;

+ (void)sendMessage:(ZZUser *)user withActivivity:(ZZActivity *)activity forVerb:(NSString *)verbName withAction:(ZZAction*)action withBlock: (void (^) (NSDictionary *response)) block;

+ (void)uploadDictionary:(NSDictionary *)dictionary toEndPoint:(NSString *)endpoint withBlock: (void (^) (NSDictionary *response)) block;

@end
