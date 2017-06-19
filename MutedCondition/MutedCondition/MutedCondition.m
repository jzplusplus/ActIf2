//
//  MutedCondition.m
//  MutedCondition
//
//  Created by Jay Zuerndorfer on 12/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

// ActIf by Jay Zuerndorfer
// See https://github.com/jzplupslus/actif2

#import <Foundation/Foundation.h>
#import "ActIf.h"

@interface MutedCondition : NSObject<ActIfCondition> {}
@end

@implementation MutedCondition

#pragma mark Metadata
- (NSString *)conditionTitle {
    return @"Check Muted";
}

- (NSString *)conditionDescription {
    return @"Check if phone is currently muted";
}

- (NSString *)titleForPassed {
    return @"Muted";
}

- (NSString *)titleForFailed {
    return @"Not Muted";
}

- (NSString *)descriptionForPassed {
    return @"Phone is currently muted";
}

- (NSString *)descriptionForFailed {
    return @"Phone is not currently muted";
}

#pragma mark Condition

- (BOOL)checkCondition {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.apple.springboard.plist"];
    if(dict)
    {
        BOOL m = [[dict valueForKey:@"SBRingerMuted"] boolValue];
        return m;
    }
    else
    {
        return NO;
    }
}

@end

