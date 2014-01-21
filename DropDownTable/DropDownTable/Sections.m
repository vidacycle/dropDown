//
//  Sections.m
//  DropDownTable
//
//  Created by Abby Schlageter on 29/11/2013.
//  Copyright (c) 2013 Abby Schlageter. All rights reserved.
//

#import "Sections.h"

@implementation Sections

- (id)initSectionWithTitles:(NSArray*)theTitles
{
    self = [super init];
    if (self) {
        _titles = [[NSArray alloc] initWithArray:theTitles];
        _down = NO;
        //initially all the rows are hidden except the top row
        _numberOfRows = 1;
        _currentTitles = [[NSMutableArray alloc] initWithCapacity:5];
        //current title is only the title for the first row in the array as initially this is the only one displayed
        [_currentTitles addObject:[_titles objectAtIndex:0]];
    }
    return self;
}

@end
