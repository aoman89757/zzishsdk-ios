//
//  JSONValueTransformer+CustomTransformer.m
//  Zzish
//
//  Created by Samir Seetal on 06/10/2014.
//  Copyright (c) 2014 Zzish. All rights reserved.
//

#import "JSONValueTransformer+CustomTransformer.h"
#import "ZZDataModel.h"

@implementation JSONValueTransformer (CustomTransformer)

- (ZZDataModel *)ZZDataModelFromNSString:(NSString*)string {
    NSArray* components = [string componentsSeparatedByString:@":"];
    if ([components count]==2) {
//        Class daoClass = NSClassFromString([NSString stringWithFormat:@"%@DAO", components[0]]);
        //return [daoClass queryByServerId:components[1]];
    }
    return nil;
}

- (NSString *)JSONObjectFromZZDataModel:(ZZDataModel *)data {
    return [NSString stringWithFormat:@"%@:%@",[data class],data.serverId];
}

@end
