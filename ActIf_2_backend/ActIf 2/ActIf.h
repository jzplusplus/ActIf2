//
//  ActIf.h
//
//  Created by Jay Zuerndorfer on 9/25/16.
//
//

#ifndef ActIf_h
#define ActIf_h


#import <libactivator/libactivator.h>

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

@interface ActIf_2 : NSObject<LAEventDataSource, LAListener>
{
    id<ActIfCondition> _delegate;
}

@property (nonatomic, weak) id<ActIfCondition> delegate;

- (ActIf_2 *) initWithDelegate:(id<ActIfCondition>)delegate andName:(NSString *)name andEventID:(NSString *)eventID andDisplayNum:(int)displayNum;

@end

#endif /* ActIf_h */
