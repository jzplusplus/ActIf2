//
//  ConditionTypeViewController.m
//  ActIf 2
//
//  Created by Jay Zuerndorfer on 11/25/16.
//  Copyright © 2016 Jay Zuerndorfer. All rights reserved.
//

#import "ConditionTypeViewController.h"
#import "ConditionDetailViewController.h"
#import "AIConditions.h"

@interface ConditionTypeViewController ()

@property NSArray *conditionTypes;
@property NSMutableDictionary *condition;

@end

@implementation ConditionTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.conditionTypes = [[AIConditions sharedInstance] conditionTypes];
    self.condition = [[AIConditions sharedInstance] conditionForIndex:self.index];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.conditionTypes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conditionTypeCell" forIndexPath:indexPath];
    
    [cell.textLabel setText:self.conditionTypes[indexPath.row]];
    if([cell.textLabel.text isEqualToString:self.condition[@"name"]])
    {
        [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    self.condition[@"name"] = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    [[AIConditions sharedInstance] updateCondition:self.condition ForIndex:self.index];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
