//
//  ConditionDetailViewController.m
//  ActIf 2
//
//  Created by Jay Zuerndorfer on 11/25/16.
//  Copyright © 2016 Jay Zuerndorfer. All rights reserved.
//

#import "ConditionDetailViewController.h"
#import "ConditionTypeViewController.h"
#import "AIConditions.h"
#include <dlfcn.h>

@interface ConditionDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *conditionTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *paramTextField;

@property NSMutableDictionary *condition;
@property NSString *parameterName;

@end

@implementation ConditionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"detail didLoad");
    
    self.paramTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"detail willAppear");
    self.condition = [[AIConditions sharedInstance] conditionForIndex:self.index];
    
    self.conditionTypeLabel.text = self.condition[@"name"];
    
    self.parameterName = @"";
    Class Condition = NSClassFromString(self.condition[@"name"]);
    if(!Condition) {
        NSString *libraryPath = [NSString stringWithFormat:@"/Library/ActIf/Conditions/%@.dylib", self.condition[@"name"]];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:libraryPath]){
            dlopen([libraryPath UTF8String], RTLD_NOW);
            Condition = NSClassFromString(self.condition[@"name"]);
        }
        else {
            NSLog(@"ActIf Condition dylib for %@ doesn't exist!", self.condition[@"name"]);
        }
    }
    
    if(Condition) {
        id condition = [[Condition alloc] init];
        if([condition respondsToSelector:@selector(parameterName)]) {
            self.parameterName = [condition parameterName];
            self.paramTextField.text = self.condition[@"parameter"];
        }
    }
    
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    if(self.isMovingFromParentViewController)
    {
        if([self.conditionTypeLabel.text length] > 0)
        {
            self.condition[@"name"] = self.conditionTypeLabel.text;
            if(self.condition[@"parameter"])
            {
                self.condition[@"parameter"] = self.paramTextField.text;
            }
            
            [[AIConditions sharedInstance] updateCondition:self.condition ForIndex:self.index];
        }
        else
        {
            [[AIConditions sharedInstance] removeConditionAtIndex:self.index];
        }
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showConditionTypes"])
    {
        ConditionTypeViewController *vc = [segue destinationViewController];
        [vc setIndex:self.index];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([self.parameterName isEqualToString:@""]) return 1;
    else return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0) return @"Condition";
    else return self.parameterName;
}

#pragma mark - Text field delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
