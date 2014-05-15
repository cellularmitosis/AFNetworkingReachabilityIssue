//
//  MasterViewController.m
//  AFDemoA
//
//  Created by Jason Pepas on 5/15/14.
//  Copyright (c) 2014 Jason Pepas. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()
@end

@implementation MasterViewController

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    switch (indexPath.row)
    {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Reachability" forIndexPath:indexPath];
            cell.textLabel.text = @"Reachability";
            break;
        }
            
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Reachability2" forIndexPath:indexPath];
            cell.textLabel.text = @"Reachability2";
            break;
        }
            
        default:
            break;
    }
    
    return cell;
}

@end
