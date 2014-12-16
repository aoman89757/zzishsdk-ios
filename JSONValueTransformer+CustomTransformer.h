//
//  JSONValueTransformer+CustomTransformer.h
//  Zzish
//
//  Created by Samir Seetal on 06/10/2014.
//  Copyright (c) 2014 Zzish. All rights reserved.
//

#import "JSONValueTransformer.h"
#import "ZZDataModel.h"

@interface JSONValueTransformer (CustomTransformer)

- (ZZDataModel *)ZZDataModelFromNSString:(NSString*)string;
- (NSString *)JSONObjectFromZZDataModel:(ZZDataModel *)data;
@end
