//
//  WifiConnectedCondition.m
//  WifiConnectedCondition
//
//  Created by Jay Zuerndorfer on 12/26/16.
//  Copyright (c) 2016 Jay Zuerndorfer. All rights reserved.
//

// ActIf by Jay Zuerndorfer
// See https://github.com/jzplupslus/actif2

#import <Foundation/Foundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "ActIf.h"

@interface WifiConnectedCondition : NSObject<ActIfCondition> {}
@end

@implementation WifiConnectedCondition

#pragma mark Metadata
- (NSString *)conditionTitle {
    return [NSString stringWithFormat:@"Check if Wifi Connected"];
}

- (NSString *)conditionDescription {
    return [NSString stringWithFormat:@"Check if Wifi is currently connected"];
}

- (NSString *)titleForPassed {
    return [NSString stringWithFormat:@"Wifi Connected"];
}

- (NSString *)titleForFailed {
    return [NSString stringWithFormat:@"Wifi Not Connected"];
}

- (NSString *)descriptionForPassed {
    return [NSString stringWithFormat:@"Currently connected to a Wifi network"];
}

- (NSString *)descriptionForFailed {
    return [NSString stringWithFormat:@"Not currently connected to a Wifi network"];
}

#pragma mark Condition

- (BOOL)checkCondition {
    NSArray *ifs = (id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"info:%@",info);
        if (info[@"SSID"]) {
            return YES;
        }
    }
    return NO;
}

@end

