//
//  Design.m
//  DropDownTable
//
//  Created by Abby Schlageter on 24/03/2014.
//  Copyright (c) 2014 Abby Schlageter. All rights reserved.
//

#import "Design.h"

@implementation Design

-(UIView*)deleteCellAccessory
{
    UIView *deleteAcc = [self customAccessoryViewFor:[UIImage imageNamed:@"minus_button.png"]];
    return deleteAcc;
}

-(UIView*)addCellAccessory
{
    UIView *addAcc = [self customAccessoryViewFor:[UIImage imageNamed:@"plus_button.png"]];
    return addAcc;
}


//custom accessory view
-(UIView*)customAccessoryViewFor:(UIImage*)theAccessory
{
    UIImageView *accImageView = [[UIImageView alloc] initWithImage:theAccessory];
    accImageView.userInteractionEnabled = YES;
    [accImageView setFrame:CGRectMake(0, 0, 24.0, 24.0)];
    
    return accImageView;
}


-(void)designForMainCell:(UITableViewCell*)theMainCell
{
    // Configure the cell.
    
    theMainCell.selectionStyle = UITableViewCellSelectionStyleNone;
    theMainCell.accessoryView = [self addCellAccessory];
    theMainCell.textLabel.font = [UIFont fontWithName:@"Gill Sans" size:20.0];
    theMainCell.backgroundColor = [UIColor colorWithRed:0.533 green:0.533 blue:0.533 alpha:1.0];
    theMainCell.textLabel.textColor = [UIColor whiteColor];
}


-(void)designForDropDownCells:(UITableViewCell*)theDropDownCells
{
    //for all drop down parts of table change color of background so it's obvious
    //[theDropDownCells setBackgroundColor:[UIColor whiteColor]];
    theDropDownCells.textLabel.textColor = [UIColor whiteColor];
    theDropDownCells.textLabel.font = [UIFont fontWithName:@"Lato Light" size:16.0];
    theDropDownCells.accessoryView = Nil;
    theDropDownCells.textLabel.textAlignment = NSTextAlignmentRight;
}



@end
