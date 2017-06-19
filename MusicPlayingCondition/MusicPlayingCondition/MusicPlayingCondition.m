//
//  MusicPlayingCondition.m
//
//  Created by Jay Zuerndorfer on 9/25/16.
//  Copyright (c) 2016 Jay Zuerndorfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVAudioSession.h>
#import "ActIf.h"

@interface MusicPlayingCondition : NSObject <ActIfCondition> {}

@end

@implementation MusicPlayingCondition

- (NSString *)conditionTitle {
    return @"Check Music Playing";
}

- (NSString *)conditionDescription {
    return @"Check if music is currently playing";
}

- (NSString *)titleForPassed {
    return @"Music playing";
}

- (NSString *)titleForFailed {
    return @"Music not playing";
}

- (NSString *)descriptionForPassed {
    return @"Music is currently playing";
}

- (NSString *)descriptionForFailed {
    return @"Music is not currently playing";
}

- (BOOL)checkCondition {
    return [[AVAudioSession sharedInstance] isOtherAudioPlaying];
}

@end
