//
//  BluetoothDeviceCondition.m
//  BluetoothDeviceCondition
//
//  Created by Jay Zuerndorfer on 12/18/16.
//  Copyright (c) 2016 Jay Zuerndorfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActIf.h"

@interface BluetoothDeviceCondition : NSObject<ActIfCondition> {}

@property (retain) NSString *deviceName;

@end

@implementation BluetoothDeviceCondition

- (NSString *)conditionTitle {
    return [NSString stringWithFormat:@"Check \"%@\" is Connected", self.deviceName];
}

- (NSString *)conditionDescription {
    return [NSString stringWithFormat:@"Check if \"%@\" Bluetooth device is currently connected", self.deviceName];
}

- (NSString *)titleForPassed {
    return [NSString stringWithFormat:@"\"%@\" Connected", self.deviceName];
}

- (NSString *)titleForFailed {
    return [NSString stringWithFormat:@"\"%@\" Not Connected", self.deviceName];
}

- (NSString *)descriptionForPassed {
    return [NSString stringWithFormat:@"\"%@\" Bluetooth device is currently connected", self.deviceName];
}

- (NSString *)descriptionForFailed {
    return [NSString stringWithFormat:@"\"%@\" Bluetooth device is not currently connected", self.deviceName];
}

- (NSString *)parameterName {
    return @"Device name";
}

- (void)setParameter:(NSString *)parameter {
    self.deviceName = parameter;
}

- (BOOL)checkCondition {
    NSArray *devices = [[NSClassFromString(@"BluetoothManager") sharedInstance] connectedDevices];
    
    if(devices.count < 1) return NO;
    
    for(id bd in devices)
    {
        if([[bd name] rangeOfString:self.deviceName options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            return YES;
        }
    }
    
    return NO;
}

@end
