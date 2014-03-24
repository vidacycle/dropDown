//
//  Design.h
//  DropDownTable
//
//  Created by Abby Schlageter on 24/03/2014.
//  Copyright (c) 2014 Abby Schlageter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Design : NSObject

-(void)designForMainCell:(UITableViewCell*)theMainCell;
-(void)designForDropDownCells:(UITableViewCell*)theDropDownCells;

-(UIView*)deleteCellAccessory;
-(UIView*)addCellAccessory;

@end
