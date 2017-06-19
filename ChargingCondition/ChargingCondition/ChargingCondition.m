//
//  ChargingCondition.m
//  ChargingCondition
//
//  Created by Jay Zuerndorfer on 12/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

// ActIf by Jay Zuerndorfer
// See https://github.com/jzplupslus/actif2

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActIf.h"

@interface ChargingCondition : NSObject<ActIfCondition> {}
@end

@implementation ChargingCondition

#pragma mark Metadata
- (NSString *)conditionTitle {
    return @"Check Phone Charging";
}

- (NSString *)conditionDescription {
    return @"Check if the phone is currently charging";
}

- (NSString *)titleForPassed {
    return @"Charging";
}

- (NSString *)titleForFailed {
    return @"Not Charging";
}

- (NSString *)descriptionForPassed {
    return @"Phone is currently charging";
}

- (NSString *)descriptionForFailed {
    return @"Phone is not currently charging";
}

#pragma mark Condition

- (BOOL)checkCondition {
    UIDeviceBatteryState batteryState = [UIDevice currentDevice].batteryState;
    return (batteryState == UIDeviceBatteryStateCharging || batteryState == UIDeviceBatteryStateFull);
}

@end

