//
//  MainListViewController.m
//  ActIf 2
//
//  Created by Jay Zuerndorfer on 11/25/16.
//  Copyright © 2016 Jay Zuerndorfer. All rights reserved.
//

#import "MainListViewController.h"
#import "AIConditions.h"
#import "ConditionDetailViewController.h"

@interface MainListViewController ()

@end

@implementation MainListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AIConditions sharedInstance] loadFromFile];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 1) return 1;
    else return [[AIConditions sharedInstance] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 1) return @"Respring required after any changes";
    else return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 1)
    {
        return [tableView dequeueReusableCellWithIdentifier:@"respringCell" forIndexPath:indexPath];
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"conditionCell" forIndexPath:indexPath];
        
        NSDictionary *cond = [[AIConditions sharedInstance] conditionForIndex:indexPath.row];
//        NSString *title = [NSString stringWithFormat:@"%@ %@", cond[@"name"], cond[@"id"]];
        
        [cell.textLabel setText:cond[@"name"]];
        if(cond[@"parameter"]) [cell.detailTextLabel setText:cond[@"parameter"]];
        else [cell.detailTextLabel setText:@""];
        
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 1) return NO;
    else return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [[AIConditions sharedInstance] removeConditionAtIndex:indexPath.row];
        //[self.conditionsDict writeToFile:@"/Library/ActIf/conditions.plist" atomically:YES];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"showConditionDetail"])
    {
        ConditionDetailViewController *vc = [segue destinationViewController];
        [vc setIndex:[self.tableView indexPathForSelectedRow].row];
    }
    else if([[segue identifier] isEqualToString:@"showNewConditionDetail"])
    {
        NSInteger newIndex = [[AIConditions sharedInstance] addCondition];
        ConditionDetailViewController *vc = [segue destinationViewController];
        [vc setIndex:newIndex];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        setuid(0); system("killall SpringBoard");
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
