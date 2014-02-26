//
//  QMStation.m
//  Station
//
//  Created by Kyusaku Mihara on 2014/02/26.
//  Copyright (c) 2014年 epohsoft. All rights reserved.
//

#import <Parse/PFObject+Subclass.h>
#import "QMStation.h"

@implementation QMStation

@dynamic name;
@dynamic location;

+ (NSString *)parseClassName {
    return @"Station";
}

@end
