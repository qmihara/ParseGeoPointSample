//
//  QMStation.h
//  Station
//
//  Created by Kyusaku Mihara on 2014/02/26.
//  Copyright (c) 2014年 epohsoft. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>

@interface QMStation : PFObject<PFSubclassing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) PFGeoPoint *location;

@end
