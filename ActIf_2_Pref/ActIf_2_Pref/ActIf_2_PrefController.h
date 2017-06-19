//
//  ActIf_2_PrefController.h
//  ActIf_2_Pref
//
//  Created by Jay Zuerndorfer on 11/25/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>

@interface ActIf_2_PrefController : PSListController
{
}

- (id)getValueForSpecifier:(PSSpecifier*)specifier;
- (void)setValue:(id)value forSpecifier:(PSSpecifier*)specifier;
- (void)followOnTwitter:(PSSpecifier*)specifier;
- (void)visitWebSite:(PSSpecifier*)specifier;
- (void)makeDonation:(PSSpecifier*)specifier;

@end