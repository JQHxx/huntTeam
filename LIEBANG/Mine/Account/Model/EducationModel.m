    //
//  EducationModel.m
//  LIEBANG
//
//  Created by  YIQI on 2018/7/30.
//  Copyright © 2018年  YIQI. All rights reserved.
//

#import "EducationModel.h"

@implementation EducationModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"img" : [WorkImgModel class]
             };
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"image" : @"img.image",
             @"type" : @"img.type"
             };
}

@end
