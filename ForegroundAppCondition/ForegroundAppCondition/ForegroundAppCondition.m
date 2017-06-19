//
//  ForegroundAppCondition.m
//  ActIf 2 backend
//
//  Created by Jay Zuerndorfer on 9/25/16.
//  Copyright (c) 2016 Jay Zuerndorfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActIf.h"

@interface ForegroundAppCondition : NSObject <ActIfCondition> {}

@property (retain) NSString *appName;

@end

@implementation ForegroundAppCondition

- (NSString *)conditionTitle {
    return [NSString stringWithFormat:@"Check \"%@\" is Open", self.appName];
}

- (NSString *)conditionDescription {
    return [NSString stringWithFormat:@"Check if \"%@\" is the currently open app", self.appName];
}

- (NSString *)titleForPassed {
    return [NSString stringWithFormat:@"\"%@\" Open", self.appName];
}

- (NSString *)titleForFailed {
    return [NSString stringWithFormat:@"\"%@\" Not Open", self.appName];
}

- (NSString *)descriptionForPassed {
    return [NSString stringWithFormat:@"\"%@\" is the currently open app", self.appName];
}

- (NSString *)descriptionForFailed {
    return [NSString stringWithFormat:@"\"%@\" is not the currently open app", self.appName];
}

- (NSString *)parameterName {
    return @"App name";
}

- (void)setParameter:(NSString *)parameter {
    self.appName = parameter;
}

- (BOOL)checkCondition {
    NSString *app = [[[UIApplication sharedApplication] _accessibilityFrontMostApplication] displayIdentifier];
    if(!app) return NO;
    return ([app rangeOfString:self.appName].location != NSNotFound);
}

@end
