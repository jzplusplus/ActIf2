//
//  OrientationCondition.m
//  OrientationCondition
//
//  Created by Jay Zuerndorfer on 12/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

// ActIf by Jay Zuerndorfer
// See https://github.com/jzplupslus/actif2

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActIf.h"

@interface OrientationCondition : NSObject<ActIfCondition> {}
@end

@implementation OrientationCondition

#pragma mark Metadata
- (NSString *)conditionTitle {
    return @"CheckOrientation";
}

- (NSString *)conditionDescription {
    return @"Check if the phone is currently in portrait or landscape orientation";
}

- (NSString *)titleForPassed {
    return @"Portrait";
}

- (NSString *)titleForFailed {
    return @"Landscape";
}

- (NSString *)descriptionForPassed {
    return @"Phone is currently in portrait";
}

- (NSString *)descriptionForFailed {
    return @"Phone is currently in landscape";
}

#pragma mark Condition

- (BOOL)checkCondition {
    UIInterfaceOrientation orientation = [[[UIApplication sharedApplication] _accessibilityFrontMostApplication] statusBarOrientation];
    return (orientation != UIInterfaceOrientationLandscapeLeft && orientation != UIInterfaceOrientationLandscapeRight);
}

@end

