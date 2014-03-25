//
//  AddDeleteRows.h
//  DropDownTable
//
//  Created by Abby Schlageter on 25/03/2014.
//  Copyright (c) 2014 Abby Schlageter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddDeleteRows : NSObject

- (void)insertRow:(NSInteger)row andSection:(NSInteger)section forTableView:(UITableView*) tableView;

- (void)deleteRow:(NSInteger)row andSection:(NSInteger)section forTableView:(UITableView*) tableView;

@end
