//
//  AddDeleteRows.m
//  DropDownTable
//
//  Created by Abby Schlageter on 25/03/2014.
//  Copyright (c) 2014 Abby Schlageter. All rights reserved.
//

#import "AddDeleteRows.h"


@implementation AddDeleteRows

- (void)deleteRow:(NSInteger)row andSection:(NSInteger)section forTableView:(UITableView*) tableView
{
    NSArray *deleteIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:section], nil];
    
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:deleteIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
}

- (void)insertRow:(NSInteger)row andSection:(NSInteger)section forTableView:(UITableView*) tableView
{
    NSArray *insertIndexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:row inSection:section], nil];
    
    [tableView beginUpdates];
    [tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
    [tableView endUpdates];
    
}

@end
