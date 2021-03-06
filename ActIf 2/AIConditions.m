//
//  AIConditions.m
//  ActIf 2
//
//  Created by Jay Zuerndorfer on 11/25/16.
//  Copyright © 2016 Jay Zuerndorfer. All rights reserved.
//

#import "AIConditions.h"

@interface AIConditions ()

@property NSMutableDictionary *conditionsDict;

@end

@implementation AIConditions

+ (id)sharedInstance
{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (NSArray *)conditionTypes {
    NSString *basePath = [NSString stringWithFormat:@"/Library/ActIf/Conditions/"];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:basePath error:nil];
    return [files valueForKey:@"stringByDeletingPathExtension"];
}

- (void)loadFromFile {
    if (![[NSFileManager defaultManager] fileExistsAtPath:@"/var/mobile/Library/conditions.plist"]){
        [@{@"conditions": @[]} writeToFile:@"/var/mobile/Library/conditions.plist" atomically:YES];
    }
    self.conditionsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/conditions.plist"];
    
//    NSDictionary* dict = [[NSUserDefaults standardUserDefaults] dictionaryForKey:@"conditions"];
//    if(dict) {
//        self.conditionsDict = [dict mutableCopy];
//    }
//    else {
//        self.conditionsDict = [NSMutableDictionary dictionary];
//    }
    NSLog(@"Loaded conditions");
}

- (void)saveToFile {
//    [[NSUserDefaults standardUserDefaults] setObject:self.conditionsDict forKey:@"conditions"];
//    NSLog(@"Saved conditions");
    
    int ret = [self.conditionsDict writeToFile:@"/var/mobile/Library/conditions.plist" atomically:YES];
    NSLog(@"Saved conditions: %d", ret);
    
}

- (NSInteger)count {
    return [self.conditionsDict[@"conditions"] count];
}

- (NSMutableDictionary *)conditionForIndex:(NSInteger)index {
    return self.conditionsDict[@"conditions"][index];
}

- (void)updateCondition:(NSMutableDictionary *)cond ForIndex:(NSInteger)index {
    self.conditionsDict[@"conditions"][index] = cond;
    [self saveToFile];
}

- (NSInteger)addCondition {
//    int newid = 0;
//    bool conflict = true;
//    while(conflict)
//    {
//        newid++;
//        conflict = false;
//        for(NSDictionary *c in self.conditionsDict[@"conditions"])
//        {
//            if([c[@"id"] integerValue] == newid)
//            {
//                conflict = true;
//                break;
//            }
//        }
//    }
    
    NSMutableDictionary *cond = [NSMutableDictionary dictionary];
//    cond[@"id"] = [NSString stringWithFormat:@"%d", newid];
    cond[@"id"] = [[NSUUID UUID] UUIDString];
    cond[@"name"] = @"";
    cond[@"parameter"] = @"";
    [self.conditionsDict[@"conditions"] addObject:cond];
    [self saveToFile];
    return [self count]-1;
}

- (void)removeConditionAtIndex:(NSInteger)index {
    [self.conditionsDict[@"conditions"] removeObjectAtIndex:index];
    [self saveToFile];
}


@end
