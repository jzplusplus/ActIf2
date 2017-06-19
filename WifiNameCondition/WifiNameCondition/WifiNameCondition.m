//
//  WifiNameCondition.m
//  WifiNameCondition
//
//  Created by Jay Zuerndorfer on 12/26/16.
//  Copyright (c) 2016 Jay Zuerndorfer. All rights reserved.
//

// ActIf by Jay Zuerndorfer
// See https://github.com/jzplupslus/actif2

#import <Foundation/Foundation.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "ActIf.h"

@interface WifiNameCondition : NSObject<ActIfCondition> {}
@property (retain) NSString *wifiName;
@end

@implementation WifiNameCondition

#pragma mark Metadata
- (NSString *)conditionTitle {
    return [NSString stringWithFormat:@"Check \"%@\" Wifi Connected", self.wifiName];
}

- (NSString *)conditionDescription {
    return [NSString stringWithFormat:@"Check if connected to \"%@\" Wifi network", self.wifiName];
}

- (NSString *)titleForPassed {
    return [NSString stringWithFormat:@"\"%@\" Wifi Connected", self.wifiName];
}

- (NSString *)titleForFailed {
    return [NSString stringWithFormat:@"\"%@\" Wifi Not Connected", self.wifiName];
}

- (NSString *)descriptionForPassed {
    return [NSString stringWithFormat:@"Currently connected to \"%@\" Wifi network", self.wifiName];
}

- (NSString *)descriptionForFailed {
    return [NSString stringWithFormat:@"Not currently connected to \"%@\" Wifi network", self.wifiName];
}

#pragma mark Optional parameter methods

- (NSString *)parameterName {
    return @"Wifi network name";
}

- (void)setParameter:(NSString *)parameter {
    self.wifiName = parameter;
}

#pragma mark Condition

- (BOOL)checkCondition {
    NSString *ssid = @"";
    NSArray *ifs = (id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        NSDictionary *info = (id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        NSLog(@"info:%@",info);
        if (info[@"SSID"]) {
            ssid = info[@"SSID"];
        }
    }
    return [ssid isEqualToString:self.wifiName];
}

@end

