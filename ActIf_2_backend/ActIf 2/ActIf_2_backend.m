//
//  ActIf_2_backend.m
//  ActIf_2_backend
//
//  Created by Jay Zuerndorfer on 9/25/2016.
//  Copyright (c) 2016 Jay Zuerndorfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libactivator/libactivator.h>
#import "ActIf.h"
#include <dlfcn.h>

@interface ActIf_2 ()

@property NSString *eventID;
@property NSString *passedEventName;
@property NSString *failedEventName;
@property int displayNum;

@end

@implementation ActIf_2

+ (void)load
{
    @autoreleasepool
    {
        if (![[NSFileManager defaultManager] fileExistsAtPath:@"/Library/ActIf/conditions.plist"]){
            NSLog(@"ActIf2 no conditions.plist file");
            return;
        }
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/Library/ActIf/conditions.plist"];
        int displayNum = 1;
        
        for(NSDictionary *conditionDict in dict[@"conditions"]) {
            
            NSString *conditionName = conditionDict[@"name"];
            NSString *conditionID = conditionDict[@"id"];
            NSString *conditionParam = conditionDict[@"parameter"];
            
            Class Condition = NSClassFromString(conditionName);
            if(!Condition) {
                NSString *libraryPath = [NSString stringWithFormat:@"/Library/ActIf/Conditions/%@.dylib", conditionName];
                
                if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
                    dlopen([libraryPath UTF8String], RTLD_NOW);
                    Condition = NSClassFromString(conditionName);
                }
                else {
                    NSLog(@"ActIf Condition dylib for %@ doesn't exist!", conditionName);
                }
            }
            
            if(Condition) {
                id condition = [[Condition alloc] init];
                if([condition respondsToSelector:@selector(setParameter:)]) {
                    [condition setParameter:conditionParam];
                }
                [[ActIf_2 alloc] initWithDelegate:condition andName:conditionName andEventID:conditionID andDisplayNum:displayNum];
                displayNum++;
            }
        }
    }
}

- (ActIf_2 *) initWithDelegate:(id<ActIfCondition>)delegate andName:(NSString *)name andEventID:(NSString *)eventID andDisplayNum:(int)displayNum{
    self = [super init];
    if( !self ) return nil;
    
    self.delegate = delegate;
    
    NSString *eventName = [NSString stringWithFormat:@"ActIf2.%@.%@", name, eventID];
    self.passedEventName = [eventName stringByAppendingString:@".passed"];
    self.failedEventName = [eventName stringByAppendingString:@".failed"];
    self.eventID = eventID;
    self.displayNum = displayNum;
    
    [LASharedActivator registerListener:self forName:eventName];
    [LASharedActivator registerEventDataSource:self forEventName:self.passedEventName];
    [LASharedActivator registerEventDataSource:self forEventName:self.failedEventName];
    
    return self;
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedGroupForListenerName:(NSString *)listenerName {
    return @"ActIf conditions";
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedTitleForListenerName:(NSString *)listenerName {
    return [NSString stringWithFormat:@"%@ %d", [self.delegate conditionTitle], self.displayNum];
}

- (NSString *)activator:(LAActivator *)activator requiresLocalizedDescriptionForListenerName:(NSString *)listenerName {
    return [self.delegate conditionDescription];
}

- (NSString *)localizedGroupForEventName:(NSString *)eventName {
    return @"ActIf results";
}

- (NSString *)localizedTitleForEventName:(NSString *)eventName {
    NSString *title = @"ActIf condition title";
    
    if ([eventName isEqualToString:self.passedEventName]) title = [self.delegate titleForPassed];
    else if ([eventName isEqualToString:self.failedEventName]) title = [self.delegate titleForFailed];
    
    title = [NSString stringWithFormat:@"%@ %d", title, self.displayNum];
    
    return title;
}

- (NSString *)localizedDescriptionForEventName:(NSString *)eventName {
    NSString *description = @"ActIf condition description";
    
    if ([eventName isEqualToString:self.passedEventName]) {
        description = [self.delegate descriptionForPassed];
    }
    else if ([eventName isEqualToString:self.failedEventName]) {
        description = [self.delegate descriptionForFailed];
    }
    
    return description;
}

- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event
{
    BOOL conditionPassed = [self.delegate checkCondition];
    
    NSString *eventName = self.failedEventName;
    if(conditionPassed)
    {
        eventName = self.passedEventName;
    }
    
    LAEvent *eventOut = [LAEvent eventWithName:eventName mode:[LASharedActivator currentEventMode]];
    [LASharedActivator sendEventToListener:eventOut];
    [event setHandled:[eventOut isHandled]];
    
}

- (void)activator:(LAActivator *)activator abortEvent:(LAEvent *)event {}

@end
