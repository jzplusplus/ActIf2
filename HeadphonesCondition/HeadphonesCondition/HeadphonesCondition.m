//
//  HeadphonesCondition.m
//  HeadphonesCondition
//
//  Created by Jay Zuerndorfer on 12/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

// ActIf by Jay Zuerndorfer
// See https://github.com/jzplupslus/actif2

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ActIf.h"

@interface HeadphonesCondition : NSObject<ActIfCondition> {}
@end

@implementation HeadphonesCondition

#pragma mark Metadata
- (NSString *)conditionTitle {
    return @"Check Headphones";
}

- (NSString *)conditionDescription {
    return @"Check if headphones are plugged in";
}

- (NSString *)titleForPassed {
    return @"Headphones Present";
}

- (NSString *)titleForFailed {
    return @"Headphones Not Present";
}

- (NSString *)descriptionForPassed {
    return @"Headphones are currently plugged in";
}

- (NSString *)descriptionForFailed {
    return @"Headphones are not currently plugged in";
}

#pragma mark Condition

- (BOOL)checkCondition {
    AVAudioSessionRouteDescription* route = [[AVAudioSession sharedInstance] currentRoute];
    for (AVAudioSessionPortDescription* desc in [route outputs]) {
        if ([[desc portType] isEqualToString:AVAudioSessionPortHeadphones])
            return YES;
    }
    return NO;
}

@end

