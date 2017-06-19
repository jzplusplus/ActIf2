//
//  ActIf.h
//
//  Created by Jay Zuerndorfer on 9/25/16.
//
//

#ifndef ActIf_h
#define ActIf_h


@protocol ActIfCondition <NSObject>
@required
- (NSString *)conditionTitle;
- (NSString *)conditionDescription;
- (NSString *)titleForPassed;
- (NSString *)titleForFailed;
- (NSString *)descriptionForPassed;
- (NSString *)descriptionForFailed;
- (BOOL)checkCondition;

@optional
- (NSString *)parameterName;
- (void)setParameter:(NSString *)parameter;

@end

#endif /* ActIf_h */

