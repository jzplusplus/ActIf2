//
//  AIConditions.h
//  ActIf 2
//
//  Created by Jay Zuerndorfer on 11/25/16.
//  Copyright © 2016 Jay Zuerndorfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AIConditions : NSObject

+ (id)sharedInstance;

- (void)loadFromFile;
- (void)saveToFile;
- (NSInteger)count;
- (NSMutableDictionary *)conditionForIndex:(NSInteger)index;
- (void)updateCondition:(NSMutableDictionary *)cond ForIndex:(NSInteger)index;
- (NSInteger)addCondition;
- (void)removeConditionAtIndex:(NSInteger)index;

@end
